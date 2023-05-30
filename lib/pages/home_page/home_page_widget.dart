import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart' as geofence;
import 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Page Title',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: 750.0,
                child: custom_widgets.ExampleApp(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 750.0,
                  geofence1: <geofence.LatLng>[
                    const geofence.LatLng(52.04304, -0.746968),
                    const geofence.LatLng(52.04286, -0.747408),
                    const geofence.LatLng(52.0429, -0.747454),
                    const geofence.LatLng(52.04132, -0.751141),
                    const geofence.LatLng(52.04004, -0.749702),
                    const geofence.LatLng(52.04028, -0.749138),
                    const geofence.LatLng(52.04065, -0.749569),
                    const geofence.LatLng(52.04068, -0.749614),
                    const geofence.LatLng(52.04069, -0.749940),
                    const geofence.LatLng(52.04063, -0.750076),
                    const geofence.LatLng(52.04089, -0.750373),
                    const geofence.LatLng(52.04095, -0.750237),
                    const geofence.LatLng(52.04114, -0.750153),
                    const geofence.LatLng(52.04118, -0.750162),
                    const geofence.LatLng(52.04148, -0.750496),
                    const geofence.LatLng(52.04174, -0.749874),
                    const geofence.LatLng(52.0417, -0.749826),
                    const geofence.LatLng(52.04209, -0.748882),
                    const geofence.LatLng(52.04219, -0.748504),
                    const geofence.LatLng(52.04231, -0.747969),
                    const geofence.LatLng(52.04236, -0.747617),
                    const geofence.LatLng(52.0425, -0.746996),
                    const geofence.LatLng(52.04268, -0.746566),
                    const geofence.LatLng(52.04225, -0.746084),
                    const geofence.LatLng(52.04212, -0.746400),
                    const geofence.LatLng(52.04202, -0.746452),
                    const geofence.LatLng(52.04186, -0.746694),
                    const geofence.LatLng(52.04159, -0.747033),
                    const geofence.LatLng(52.04145, -0.747203),
                    const geofence.LatLng(52.04129, -0.747326),
                    const geofence.LatLng(52.04109, -0.747755),
                    const geofence.LatLng(52.04094, -0.747591),
                    const geofence.LatLng(52.04179, -0.745637),
                    const geofence.LatLng(52.04182, -0.745676),
                    const geofence.LatLng(52.04185, -0.745624),
                  ],
                  geofence2: <geofence.LatLng>[
                    const geofence.LatLng(52.04108, -0.751603),
                    const geofence.LatLng(52.03987, -0.750246),
                    const geofence.LatLng(52.0399, -0.750178),
                    const geofence.LatLng(52.03987, -0.750136),
                    const geofence.LatLng(52.04001, -0.749784),
                    const geofence.LatLng(52.04005, -0.749828),
                    const geofence.LatLng(52.03999, -0.749977),
                    const geofence.LatLng(52.04126, -0.751373),
                    const geofence.LatLng(52.04217, -0.749251),
                    const geofence.LatLng(52.04246, -0.748582),
                    const geofence.LatLng(52.04293, -0.747486),
                    const geofence.LatLng(52.04301, -0.747581),
                    const geofence.LatLng(52.04307, -0.747435),
                    const geofence.LatLng(52.04311, -0.747485),
                    const geofence.LatLng(52.04258, -0.748717),
                    const geofence.LatLng(52.04246, -0.748586),
                    const geofence.LatLng(52.04217, -0.749257),
                    const geofence.LatLng(52.0423, -0.749399),
                    const geofence.LatLng(52.04138, -0.751510),
                    const geofence.LatLng(52.0412, -0.751316),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
