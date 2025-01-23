// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// class MapSample extends StatefulWidget {
//   const MapSample({super.key});
//
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//    // BitmapDescriptor? customMarkerIcon;
//
//
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     // loadCustomMarker();
//
//   }
//
//
//   // Future<void> loadCustomMarker() async {
//   //   customMarkerIcon = await BitmapDescriptor.fromAssetImage(
//   //     const ImageConfiguration(size: Size(2, 2)),
//   //     Platform.isAndroid
//   //         ? 'assets/Images/driver_marker.png'
//   //         : "assets/Images/driver_marker.png",
//   //   );
//   //   setState(() {}); // Ensure the widget is rebuilt after initialization
//   // }
//
//   final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
//
//   // static const CameraPosition _kGooglePlex = CameraPosition(
//   //   target: LatLng(31.41350455929102, 73.08928072451278),
//   //   zoom: 14.4746,
//   // );
//    List<LatLng> zoneCoordinates = [
//      const LatLng(31.41350455929102, 73.08928072451278),
//
//    ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     Set<Polyline> polylines = {};
//     polylines.add(
//       Polyline(
//         polylineId: const PolylineId('route'),
//         color: Colors.red,
//         points: zoneCoordinates,
//         width: 5,
//       ),
//     );
//     // if (!kIsWeb && customMarkerIcon == null) {
//     //   return const Center(child: CircularProgressIndicator());
//     // }
//     return Scaffold(
//       body:
//       // customMarkerIcon==null?const CircularProgressIndicator():
//       GoogleMap(
//         polygons: {
//       Polygon(
//       polygonId: const PolygonId('zone'),
//       points: zoneCoordinates,
//       strokeWidth: 2,
//       strokeColor: Colors.red,
//       fillColor: Colors.red.withOpacity(0.5),
//       ),
//       },
//           scrollGesturesEnabled: true,
//           gestureRecognizers: {
//             Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
//           },
//           zoomControlsEnabled: false,
//           mapType: MapType.normal,
//           polylines:polylines ,
//           rotateGesturesEnabled: true,
//           trafficEnabled: true,
//           buildingsEnabled: true,
//           myLocationEnabled: true,
//
//          myLocationButtonEnabled: false,
//           compassEnabled: false,
//           zoomGesturesEnabled: true,
//           initialCameraPosition: const CameraPosition(
//             target: LatLng(31.41350455929102, 73.08928072451278),
//             zoom: 10,
//           ),
//           //initialCameraPosition: _kGooglePlex,
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//           markers: {
//             customMarker(
//                 'Marker 1', const LatLng(31.41350455929102, 73.08928072451278)),
//             customMarker(
//                 'Marker 2', const LatLng(31.41350455929102, 73.08928072451278)),
//             // Add more custom markers as needed
//           }),
//     );
//   }
//
//   Marker customMarker(String markerId, LatLng position) {
//     return Marker(
//       markerId: MarkerId(markerId),
//       position: position,
//       // icon: customMarkerIcon!,
//       onTap: () {
//         // Handle marker tap
//        // print('$markerId tapped!');
//       },
//     );
//   }
// }