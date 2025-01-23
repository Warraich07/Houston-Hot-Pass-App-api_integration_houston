import 'dart:async';
// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart' as ser;
import 'dart:ui' as ui;
import 'package:cron/cron.dart';
import 'package:cron/cron.dart' as cr;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/custom_listview.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/views/home/offer_details/offer_details.dart';
import 'package:houstan_hot_pass/views/home/widgets/custom_food_tile.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../controllers/offers_controller.dart';
import '../home/redeem_offers_screen.dart';
import 'package:flutter/services.dart' as services;
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
class NearbyOnMapScreen extends StatefulWidget {
  const NearbyOnMapScreen({super.key});

  @override
  State<NearbyOnMapScreen> createState() => _NearbyOnMapScreenState();
}

class _NearbyOnMapScreenState extends State<NearbyOnMapScreen> {
  Future<BitmapDescriptor> getMarkerIcon(String? imageUrl) async {
    final markerIcon = await createMarkerIcon( imageUrl);
    return BitmapDescriptor.fromBytes(markerIcon);
  }

// Function to create the marker icon as a Uint8List
  Future<Uint8List> createMarkerIcon(String? imageUrl) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    const size = Size(100, 100); // Adjust size as needed

    final paint = Paint();

    // Draw the outer transparent circle (halo effect)
    paint.color = Colors.red.withOpacity(0.3); // Adjust color and opacity as needed
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // Draw the white circle (border around the image)
    paint.color = Colors.white;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.5, paint);

    // Load the image from network or use the default asset image
    final image = await _loadImageFromNetworkOrAsset(imageUrl);

    // Define the area where the image will be drawn
    final imageRect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2.7, // Slightly smaller radius to fit within the white border
    );

    // Clip the canvas to a circle to ensure the image is circular
    canvas.clipPath(Path()..addOval(imageRect));

    // Draw the image on the canvas centered within the circular area
    paintImage(
      canvas: canvas,
      rect: imageRect,
      image: image,
      fit: BoxFit.cover,
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }


// Function to load image from network or asset
  Future<ui.Image> _loadImageFromNetworkOrAsset(String? url) async {
    if (url == null || url.isEmpty) {
      // Load the default asset image if URL is null or empty
      return _loadAssetImage('assets/app_icons/my_profile_icons/edit_personal_info_icon.png');
    } else {
      // Load the image from network
      return _loadImageFromNetwork(url);
    }
  }

// Function to load image from network
  Future<ui.Image> _loadImageFromNetwork(String url) async {
    final completer = Completer<ui.Image>();

    final imageStream = NetworkImage(url).resolve(const ImageConfiguration());
    imageStream.addListener(
      ImageStreamListener(
            (ImageInfo info, bool synchronousCall) {
          completer.complete(info.image);
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          completer.completeError(exception, stackTrace);
        },
      ),
    );

    return completer.future;
  }

// Function to load image from asset
  Future<ui.Image> _loadAssetImage(String assetPath) async {
    final completer = Completer<ui.Image>();
    final data = await services.rootBundle.load(assetPath);
    final image = await decodeImageFromList(data.buffer.asUint8List());

    completer.complete(image);
    return completer.future;
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission;

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, ask the user to enable them.
      print('Location services are disabled.');
      return;
    }

    // Check if permission is granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if it is denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, exit the function
        openAppSettings();
        print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle appropriately.
      openAppSettings();
      print('Location permissions are permanently denied.');
      return;
    }

    // If permissions are granted, get the current location

    getCurrentLocation();
  }

  void animateToCamera(double lat,double long)async{
    final GoogleMapController mapController=await _controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 16,  // Adjust the zoom level as needed
        ),
      ),
    );
    // _markers[restaurantId].showInfoWindow();
  }

  void _addUniqueMarkers() {
    Future.microtask(() async {
      double? lastLatitude;
      double? lastLongitude;

      for (var offer in _offersController.nearbyOffersList) {
        final restaurant = offer.restuarant;
        double currentLatitude = double.parse(restaurant.location.latitude);
        double currentLongitude = double.parse(restaurant.location.longitude);

        // Check if the current latitude and longitude are different from the last one
        if (lastLatitude != currentLatitude || lastLongitude != currentLongitude) {
          _markers.add(
            Marker(
              onTap: ()async{
                _offersController.filterNearByOffersForRestaurant(
                    currentLatitude.toStringAsFixed(5),
                    currentLongitude.toStringAsFixed(5),
                    restaurant.id.toString()
                );
                if (_offersController.lattitude.value.toString() == 'null') {
                  animateToCamera(currentLatitude,currentLongitude);
                }

              },
              markerId: MarkerId(restaurant.id.toString()),
              position: LatLng(currentLatitude, currentLongitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Red marker icon
              infoWindow: InfoWindow(
                title: restaurant.name, // Title for the location
                // Note: You cannot attach onTap directly to infoWindow
              ),
            ),
          );
          // Update the last latitude and longitude
          lastLatitude = currentLatitude;
          lastLongitude = currentLongitude;
        }
      }

      setState(() {
        // Refresh the map to display new markers
      });
    });

  }


  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final markerIcon = await getMarkerIcon(_authController.userLoginData.value?.image ?? "");
      setState(() {
        _offersController.currentPosition = position;
        _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId(_offersController.currentPosition.toString()),
              position: LatLng(_offersController.currentPosition!.latitude,_offersController.currentPosition!.longitude),
              // infoWindow: InfoWindow(title: "Your Location"),
              icon: markerIcon,
              // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          );
      });
      if (_offersController.lattitude.value.toString() == 'null') {
        _offersController.getNearByOffers(
          _offersController.currentPosition!.latitude.toStringAsFixed(5),
          _offersController.currentPosition!.longitude.toStringAsFixed(5),
        );
      }
      if (_offersController.lattitude.value.toString() == 'null') {
        Future.delayed(Duration(seconds: 3), () {
          _addUniqueMarkers();
        });
      }
      // Future.delayed(Duration(seconds: 3), () {
      //   _addUniqueMarkers();
      // });


    } catch (e) {
      print('Error fetching location: $e');
    }
  }
  // late final markerIcon;
  //
  // Future<void> _loadMarkerIcon() async {
  //  final markerIcon = await getMarkerIcon(_authController.userLoginData.value?.image ?? "");
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _offersController.nearbyOffersList.clear();
      _offersController.nearbyOffersCurrentPage.value=0;
      _offersController.nearbyOffersLastPage.value=0;
      _offersController.filteredOffersOfRestaurantList.clear();
      _offersController.nearbyOffersCurrentPage.value=0;
      _offersController.nearbyOffersLastPage.value=0;
      _checkLocationPermission();
      // _loadMarkerIcon();
      _authController.showPopUps();
print(_offersController.lattitude.value.toString()+"hasjdjh");

        if (_offersController.lattitude.value.toString() != 'null') {
          Future.delayed(Duration(seconds: 3), () {
            double currentLatitude = double.parse(_offersController.lattitude.value.toString());
            double currentLongitude = double.parse(_offersController.longitude.value.toString());
            print(currentLatitude.toString()+"this is current lat???>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            animateToCamera(
              currentLatitude,
              currentLongitude,
            );
          });
          Future.delayed(Duration(seconds: 5), () {
            _addUniqueMarkers();
          });
        }else{

        }



    });

  }

  Set<Marker> _markers = {};
  List<LatLng> zoneCoordinates = [
    const LatLng(31.41350455929102, 73.08928072451278),
  ];
  bool _isMapInitialized = false;
  AuthController _authController=Get.find();
  OffersController _offersController=Get.find();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  String searchQuery='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          ()=> Stack(
          children: [
            // SizedBox(height: 100.h, width: 100.w, child: const MapSample()),
          GoogleMap(
                polygons: {
                  Polygon(
                    polygonId: const PolygonId('zone'),
                    points: zoneCoordinates,
                    strokeWidth: 2,
                    strokeColor: Colors.red,
                    fillColor: Colors.red.withOpacity(0.5),
                  ),
                },
                scrollGesturesEnabled: true,
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
                },
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                // polylines:polylines ,
                rotateGesturesEnabled: true,
                trafficEnabled: true,
                buildingsEnabled: true,
                myLocationEnabled: false,

                myLocationButtonEnabled: false,
                compassEnabled: false,
                zoomGesturesEnabled: true,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(31.41350455929102, 73.08928072451278),
                  zoom: 10,
                ),
                //initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left:  15.0,right: 15,top: 30),
                child: CustomTextField(inputTextColor: Colors.black,
                  onFieldSubmitted: (value)async{
                   await _offersController.getSearchOffersOnMapScreen(false, value.toString());
                   await Future.delayed(Duration(seconds: 2));
                   if(_offersController.filteredOffersOfRestaurantList.isNotEmpty){
                     print('animated camera');
                     animateToCamera(double.parse(_offersController.filteredOffersOfRestaurantList[0].restuarant.location.latitude), double.parse(_offersController.filteredOffersOfRestaurantList[0].restuarant.location.longitude));

                   }else{
                     print('empty list');
                   }

                  },
                  onChanged: (String value) {
                    searchQuery=value.toString();
                    if(searchQuery.isEmpty){
                      _offersController.filteredOffersOfRestaurantList.clear();
                      setState(() {});
                    }
                  },
                  onTap: () async{
                    if(searchQuery.isNotEmpty){
                      await _offersController.getSearchOffersOnMapScreen(false,searchQuery);
                      await Future.delayed(Duration(seconds: 2));
                      if(_offersController.filteredOffersOfRestaurantList.isNotEmpty){
                        print('animated camera');
                        animateToCamera(double.parse(_offersController.filteredOffersOfRestaurantList[0].restuarant.location.latitude), double.parse(_offersController.filteredOffersOfRestaurantList[0].restuarant.location.longitude));

                      }else{
                        print('empty list');
                      }
                    }
                  },
                  fillColor: AppColors.whiteColor,
                  hintText: "Search here...",
                  hintTextColor:
                  Colors.black.withOpacity(0.5),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0),
                    child: Image.asset(
                      AppIcons.searchIcon,
                      scale: 3.5,
                    ),
                  ),)
              ),

            ),
            Positioned(
                bottom: -15,
                left: 10,
                child: SizedBox(
                  height: 260,
                  width: Get.width,
                  child:_offersController.isLoadingFilteredNearbyOffers.value==true?Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ): _offersController.filteredOffersOfRestaurantList.isEmpty?Container(): CustomListview(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: _offersController.filteredOffersOfRestaurantList.length,
                    itemBuilder: (context, index) {
                      // _markers.add(
                      //     Marker(
                      //       onTap: (){
                      //         _offersController.filterNearByOffersForRestaurant(
                      //           double.parse(_offersController.nearbyOffersList[index].restuarant.location.latitude).toStringAsFixed(5),
                      //           double.parse(_offersController.nearbyOffersList[index].restuarant.location.longitude).toStringAsFixed(5),
                      //             _offersController.nearbyOffersList[index].restuarant.id.toString()
                      //         );
                      //
                      //       },
                      //       markerId: MarkerId(_offersController.nearbyOffersList[index].id.toString()),
                      //       position: LatLng(double.parse(_offersController.nearbyOffersList[index].restuarant.location.latitude),double.parse(_offersController.nearbyOffersList[index].restuarant.location.longitude)),
                      //       // infoWindow: InfoWindow(title: "Your Location"),
                      //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),  // Red marker icon
                      //       infoWindow: InfoWindow(
                      //         title: _offersController.nearbyOffersList[index].restuarant.location.title, // Title for the location
                      //         onTap: (){
                      //           print(_offersController.nearbyOffersList[index].restuarant.name);
                      //         }
                      //       ),
                      //       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                      //     )
                      // );
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(()=>OfferDetails(
                              offerCreatedDate: _offersController.formatDate(_offersController.filteredOffersOfRestaurantList[index].createdAt.toString()),
                              restaurantId: _offersController.filteredOffersOfRestaurantList[index].restuarant.id.toString(),
                              canRedeemAgain: true,
                              offerId: _offersController.filteredOffersOfRestaurantList[index].id.toString(),
                              imagePath: _offersController.filteredOffersOfRestaurantList[index].image.toString(),
                              validTill: _offersController.formatDate(_offersController.filteredOffersOfRestaurantList[index].expirationDate.toString()),
                              foodTitle: _offersController.filteredOffersOfRestaurantList[index].title,
                              saleOnFood: _offersController.filteredOffersOfRestaurantList[index].description,
                              restaurantLocation: _offersController.filteredOffersOfRestaurantList[index].restuarant.location.title.toString(),
                              termsAndConditions: _offersController.filteredOffersOfRestaurantList[index].termsConditions.toString(),
                              tagsList: _offersController.filteredOffersOfRestaurantList[index].tags,
                              lat: double.parse(_offersController.filteredOffersOfRestaurantList[index].restuarant.location.latitude),
                              long: double.parse(_offersController.filteredOffersOfRestaurantList[index].restuarant.location.longitude),));
                          },
                          child: Container(
                            // height: 200,
                            width: 46.w,
                            child: CustomFoodTile(
                              onTapRedeemNow: () {
                                Get.to(()=>RedeemOffersScreen(

                                    offerId:_offersController.filteredOffersOfRestaurantList[index].id.toString() ,
                                    imagePath: _offersController.filteredOffersOfRestaurantList[index].image.toString(),
                                    title: _offersController.filteredOffersOfRestaurantList[index].title.toString(),
                                    description:_offersController.filteredOffersOfRestaurantList[index].description.toString() ,
                                    validTill:"Valid till ${_offersController.formatDate(_offersController.filteredOffersOfRestaurantList[index].expirationDate.toString())}"));
                              },
                              foodTileHeading: "Redeem Now",
                              restaurantName: _offersController.filteredOffersOfRestaurantList[index].title,
                              saleOnFood: _offersController.filteredOffersOfRestaurantList[index].description,
                              imagePath: _offersController.filteredOffersOfRestaurantList[index].image,

                            ),
                          ),
                        ),
                      );
                    },
                    // child: SizedBox(
                    //     width:190,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(right: 8.0),
                    //       child: GestureDetector(onTap: () {
                    //         Get.to(()=>OfferDetails());
                    //       },
                    //           child: CustomFoodTile()),
                    //     )),

                  ),
                ))


          ],
        ),
      ),
      // bottomSheet: BottomSheet(
      //     builder: (context) {
      //       return SingleChildScrollView(
      //         child: Container(
      //           width: 100.w,
      //           height: 300,
      //           decoration: const BoxDecoration(color: Colors.white,
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(30),
      //                   topRight: Radius.circular(30))),
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(
      //                 horizontal: 20.0, vertical: 20),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const BoldText(
      //                   Text: "The rider has left to pick order.",
      //                   fontSize: 16,
      //                 ),
      //                 const SizedBox(height: 5),
      //                 Divider(
      //                   color: Colors.grey.withOpacity(0.4),
      //                 ),
      //                  BoldText(Text: "Delivery Details:"),
      //                  SizedBox(height: 20),
      //                  Row(
      //                   children: [
      //                     AppSubtitleText(Text: "Status:"),
      //                     Spacer(),
      //                     CustomButton(
      //                       Text: "Pending",
      //                       height: 29,
      //                       width: 82,
      //                       textSize: 8,
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 20),
      //                 Row(
      //                   children: [
      //                     const BoldText(Text: "Delivery Time"),
      //                     const Spacer(),
      //
      //                     const SizedBox(width: 10),
      //                     const BoldText(Text: "15 minutes Left"),
      //                   ],
      //                 ),
      //                 const Spacer(),
      //                 Center(
      //                     child: GestureDetector(
      //                         onTap: () {
      //                           Get.to(());
      //                         },
      //                         child: const CustomButton(
      //                           Text: "Chat With Driver",
      //                           height: 56,
      //                           width: 340,
      //                         )))
      //               ],
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //     onClosing: () {}),
    );
  }
  Marker customMarker(String markerId, LatLng position) {
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      // icon: customMarkerIcon!,
      onTap: () {
        // Handle marker tap
        // print('$markerId tapped!');
      },
    );
  }
}
