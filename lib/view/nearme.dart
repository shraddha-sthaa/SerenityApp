import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PsychologistsNearMe extends StatefulWidget {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.209721463642527, 83.98532074060667),
    zoom: 14.4746,
  );
  @override
  _PsychologistsNearMeState createState() => _PsychologistsNearMeState();
}

class _PsychologistsNearMeState extends State<PsychologistsNearMe> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = <Marker>{
    const Marker(
      markerId: MarkerId('Nepal Psychological Center'),
      position: LatLng(28.20717539366494, 83.99761888770054),
      infoWindow: InfoWindow(title: "Nepal Psychological Center"),
    ),
    const Marker(
      markerId: MarkerId('Family Counsellor'),
      position: LatLng(28.211345073422546, 83.98576842535535),
      infoWindow: InfoWindow(title: "Family Counsellor"),
    ),
    const Marker(
      markerId: MarkerId('Pokhara Accupressure Therapy'),
      position: LatLng(28.21792124898013, 83.98610010965022),
      infoWindow: InfoWindow(title: "Pokhara Accupressure Therapy"),
    ),
    const Marker(
      markerId: MarkerId('Fast Track Education Counsellor'),
      position: LatLng(28.220259347139027, 83.98626595179763),
      infoWindow: InfoWindow(title: "Fast Track Education Counsellor"),
    ),
    const Marker(
      markerId: MarkerId('Shuba Vivah Counselling'),
      position: LatLng(28.21865191015482, 83.98941695259883),
      infoWindow: InfoWindow(title: "Shuba Vivah Counselling"),
    ),
  };

  @override
  void initState() {
    super.initState();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: PsychologistsNearMe._kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
  }
}
