// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'dart:async';
import 'package:poly_geofence_service/poly_geofence_service.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart' as geofence;

class ExampleApp extends StatefulWidget {
  const ExampleApp(
      {Key? key, this.width, this.height, this.geofence1, this.geofence2})
      : super(key: key);

  final double? width;
  final double? height;
  final List<geofence.LatLng>? geofence1;
  final List<geofence.LatLng>? geofence2;
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final _streamController = StreamController<PolyGeofence>();

  // Create a [PolyGeofenceService] instance and set options.
  final _polyGeofenceService = PolyGeofenceService.instance.setup(
      interval: 1000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      allowMockLocations: false,
      printDevLog: false);

  Location _currentLocation =
      new Location.fromJson({'latitude': 0.0, 'longitude': 0.0});

  // This function is to be called when the geofence status is changed.
  Future<void> _onPolyGeofenceStatusChanged(PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus, Location location) async {
    print('polyGeofence: ${polyGeofence.toJson()}');
    print('polyGeofenceStatus: ${polyGeofenceStatus.toString()}');
    _streamController.sink.add(polyGeofence);
  }

  // This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
    print('location: ${location.toJson()}');
    this.setState(() {
      _currentLocation = location;
    });
  }

  // This function is to be called when a location services status change occurs
  // since the service was started.
  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  // This function is used to handle errors that occur in the service.
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }

    print('ErrorCode: $errorCode');
  }

  @override
  void initState() {
    final _polyGeofenceList = <PolyGeofence>[
      PolyGeofence(
        id: 'park1',
        data: {
          'about': 'Park #1',
        },
        polygon: widget.geofence1!,
      ),
      PolyGeofence(
        id: 'park2',
        data: {
          'about': 'Park #2',
        },
        polygon: widget.geofence2!,
      ),
    ];

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _polyGeofenceService
          .addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
      _polyGeofenceService.addLocationChangeListener(_onLocationChanged);
      _polyGeofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _polyGeofenceService.addStreamErrorListener(_onError);
      _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillStartForegroundTask(
      onWillStart: () async {
        // You can add a foreground task start condition.
        return _polyGeofenceService.isRunningService;
      },
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'geofence_service_notification_channel',
        channelName: 'Geofence Service Notification',
        channelDescription:
            'This notification appears when the geofence service is running in the background.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        isSticky: false,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        autoRunOnBoot: true,
      ),
      notificationTitle: 'Geofence Service is running',
      notificationText: 'Tap to return to the app',
      child: _buildContentView(),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  String parkedAt = '';
  String entered = '';
  String left = '';
  String prevParkedAt = '';
  String prevEntered = '';
  String prevLeft = '';

  Widget _buildContentView() {
    return StreamBuilder<PolyGeofence>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        print('snapshot: $_currentLocation');
        final updatedDateTime = DateTime.now();
        var content = snapshot.data?.toJson()['data']['about'] ?? '';

        if (content != '') {
          if (snapshot.data?.status == PolyGeofenceStatus.DWELL) {
            prevParkedAt = parkedAt;
            parkedAt = 'Curr: ' + content;
          } else if (snapshot.data?.status == PolyGeofenceStatus.ENTER) {
            prevEntered = entered;
            entered = 'Entry: ' + content;
          } else if (snapshot.data?.status == PolyGeofenceStatus.EXIT) {
            prevLeft = left;
            left = 'Left: ' + content;
          }
        }

        if (content == '') {
          parkedAt = 'NoGeoFence';
        }

        double speedMps = _currentLocation.speed;
        double speedMph = speedMps * 2.23694; // Convert m/s to mph

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '•\t\tPolyGeofence (updated: $updatedDateTime)',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),

            const Text(
              'Debugging',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Lat:' +
                  _currentLocation.latitude.toString() +
                  ' Long:' +
                  _currentLocation.longitude.toString(),
              style: const TextStyle(fontSize: 20.0),
            ),
            // Text('Speed:' + _currentLocation.speed.toString()), // Display speed in m/s
            Text(
              // 'Speed:' + speedMph.toStringAsFixed(2) + ' mph',
              speedMph.toStringAsFixed(2),
              style: const TextStyle(fontSize: 124.0),
            ), // Display speed in mph
            Text(
              content + '\n' + parkedAt + '\n' + entered + '\n' + left,
              style: const TextStyle(fontSize: 36.0),
            ),
            Text(
              'prev: ' + prevParkedAt + '\n' + prevEntered + '\n' + prevLeft,
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        );
      },
    );
  }
}
