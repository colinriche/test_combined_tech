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

void main() => runApp(const ExampleApp());

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

  // Create a [PolyGeofence] list.
  // final _polyGeofenceList = <PolyGeofence>[
  //   PolyGeofence(
  //     id: 'park1',
  //     data: {
  //       'about': 'Park #1',
  //     },
  //     polygon: <geofence.LatLng>[
  //       const geofence.LatLng(52.04304, -0.746968),
  //       const geofence.LatLng(52.04286, -0.747408),
  //       const geofence.LatLng(52.0429, -0.747454),
  //       const geofence.LatLng(52.04132, -0.751141),
  //       const geofence.LatLng(52.04004, -0.749702),
  //       const geofence.LatLng(52.04028, -0.749138),
  //       const geofence.LatLng(52.04065, -0.749569),
  //       const geofence.LatLng(52.04068, -0.749614),
  //       const geofence.LatLng(52.04069, -0.749940),
  //       const geofence.LatLng(52.04063, -0.750076),
  //       const geofence.LatLng(52.04089, -0.750373),
  //       const geofence.LatLng(52.04095, -0.750237),
  //       const geofence.LatLng(52.04114, -0.750153),
  //       const geofence.LatLng(52.04118, -0.750162),
  //       const geofence.LatLng(52.04148, -0.750496),
  //       const geofence.LatLng(52.04174, -0.749874),
  //       const geofence.LatLng(52.0417, -0.749826),
  //       const geofence.LatLng(52.04209, -0.748882),
  //       const geofence.LatLng(52.04219, -0.748504),
  //       const geofence.LatLng(52.04231, -0.747969),
  //       const geofence.LatLng(52.04236, -0.747617),
  //       const geofence.LatLng(52.0425, -0.746996),
  //       const geofence.LatLng(52.04268, -0.746566),
  //       const geofence.LatLng(52.04225, -0.746084),
  //       const geofence.LatLng(52.04212, -0.746400),
  //       const geofence.LatLng(52.04202, -0.746452),
  //       const geofence.LatLng(52.04186, -0.746694),
  //       const geofence.LatLng(52.04159, -0.747033),
  //       const geofence.LatLng(52.04145, -0.747203),
  //       const geofence.LatLng(52.04129, -0.747326),
  //       const geofence.LatLng(52.04109, -0.747755),
  //       const geofence.LatLng(52.04094, -0.747591),
  //       const geofence.LatLng(52.04179, -0.745637),
  //       const geofence.LatLng(52.04182, -0.745676),
  //       const geofence.LatLng(52.04185, -0.745624),
  //     ],
  //   ),
  //   PolyGeofence(
  //     id: 'park2',
  //     data: {
  //       'about': 'Park #2',
  //     },
  //     polygon: <geofence.LatLng>[
  //       const geofence.LatLng(52.04108, -0.751603),
  //       const geofence.LatLng(52.03987, -0.750246),
  //       const geofence.LatLng(52.0399, -0.750178),
  //       const geofence.LatLng(52.03987, -0.750136),
  //       const geofence.LatLng(52.04001, -0.749784),
  //       const geofence.LatLng(52.04005, -0.749828),
  //       const geofence.LatLng(52.03999, -0.749977),
  //       const geofence.LatLng(52.04126, -0.751373),
  //       const geofence.LatLng(52.04217, -0.749251),
  //       const geofence.LatLng(52.04246, -0.748582),
  //       const geofence.LatLng(52.04293, -0.747486),
  //       const geofence.LatLng(52.04301, -0.747581),
  //       const geofence.LatLng(52.04307, -0.747435),
  //       const geofence.LatLng(52.04311, -0.747485),
  //       const geofence.LatLng(52.04258, -0.748717),
  //       const geofence.LatLng(52.04246, -0.748586),
  //       const geofence.LatLng(52.04217, -0.749257),
  //       const geofence.LatLng(52.0423, -0.749399),
  //       const geofence.LatLng(52.04138, -0.751510),
  //       const geofence.LatLng(52.0412, -0.751316),
  //     ],
  //   ),
  // ];

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
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 42.0),
        bodyText2: TextStyle(fontSize: 42.0),
      )),
      // A widget used when you want to start a foreground task when trying to minimize or close the app.
      // Declare on top of the [Scaffold] widget.
      home: WillStartForegroundTask(
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
        child: Scaffold(
          // appBar: AppBar(
          //  title: const Text('Poly Geofence Demo for Colin'),
          //  centerTitle: true,
          //),
          body: _buildContentView(),
        ),
      ),
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

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
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
