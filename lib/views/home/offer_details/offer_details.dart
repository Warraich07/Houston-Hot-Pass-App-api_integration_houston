import 'dart:async';
import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:houstan_hot_pass/app_widgets/alertbox.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_listview.dart';
import 'package:houstan_hot_pass/app_widgets/locationButton.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/utils/custom_dialog.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_up/sign_up_screeen.dart';
import 'package:houstan_hot_pass/views/home/offer_details/widgets/custom_terms_and_conditions_points.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../../../app_widgets/shimmer_single_widget.dart';
import '../../auth_screens/sign_in/sign_in_screen.dart';
import '../../nearby_on_map_screen/nearby_on_map_screen.dart';
import '../redeem_offers_screen.dart';

class OfferDetails extends StatefulWidget {
   OfferDetails({super.key,this.foodTitle,this.saleOnFood,this.restaurantLocation,this.validTill,this.termsAndConditions,this.offerId,this.imagePath,this.tagsList,this.lat,this.long,this.restaurantId,required this.canRedeemAgain,required this.offerCreatedDate});
    String? restaurantId;
   String? imagePath;
   String? offerId;
  String? foodTitle;
  String? saleOnFood;
  String? restaurantLocation;
  String? validTill;
  String offerCreatedDate='';
  String? termsAndConditions;
   List<String>? tagsList;
   double? lat;
   double? long;
   bool canRedeemAgain;
  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  OffersController _offersController=Get.find();
  GeneralController _generalController=Get.find();
  AuthController _authController=Get.find();
  String? detailedAddress = "Fetching address..."; // State variable for the address

  // Future<void> getAddressFromLatLng(double latitude, double longitude) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
  //     Placemark place = placemarks[0];
  //
  //     // Construct the address from the placemark details
  //
  //     return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  //
  //   } catch (e) {
  //     print('Error: $e');
  //     print(detailedAddress);
  //     setState(() {
  //       detailedAddress = 'Address not found';
  //     });
  //   }
  // }
  String address='';
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address="${place.name}, ${place.locality}, ${place.administrativeArea}";
        setState(() {

        });
        return "${place.street}, ${place.locality}, ${place.administrativeArea}";
      } else {
        return "No place marks found";
      }
    } catch (e) {
      print("Error fetching address: $e");
      return "Address not found";
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAddressFromLatLng(widget.lat!, widget.long!).then((value){
        print(value.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  height: 170,
                  width: 100.w,
                  decoration: BoxDecoration(
                    image:DecorationImage(
                        image: AssetImage(AppImages.homeAppBarBackgroundImage),
                        fit: BoxFit.cover),
                  )),
              Positioned(
                  // left: 10,
                  // top: 47,
                  child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      children: [
                        ZoomTapAnimation(onTap: () {
                          Get.back();
                        },
                            child: Image.asset('assets/app_icons/back_button.png',scale: 4,)),
                        const Spacer(),
                        AppSubtitleText(
                          Text: "Valid Until: ${widget.validTill!}",
                          color: AppColors.primaryColor,fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              Positioned(
                bottom: 5,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 90.w,
                      child:  AppSubtitleText(
                          Text:widget.foodTitle??"The Curry Pizza guy", color: Colors.black,fontSize: 17,maxLines: 2,height: 1.1,),
                    ),
                    // const SizedBox(height: 5),
                    Container(

                      // color: Colors.green,
                      width: 80.w,
                      child:  Tooltip(
                        // waitDuration: Duration(milliseconds: 900),
                        showDuration: const Duration(seconds: 5),
                        message:  widget.saleOnFood,
                        child: Text(maxLines: 2,
                          widget.saleOnFood??"",
                          style: const TextStyle(
                              fontSize: 24,
                              fontFamily: "swear-banner-regular",height: 1.1,
                              color: Colors.black,),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: 276,
                width: 100.w,
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //     image:widget.imagePath != null && widget.imagePath!.isNotEmpty
                    //         ? NetworkImage(widget.imagePath!) // Use NetworkImage if the path is a URL
                    //         : AssetImage(widget.imagePath ?? AppImages.foodTileImg)
                    //     as ImageProvider,
                    //     // AssetImage(AppImages.homeAppBarBackgroundImage),
                    //     fit: BoxFit.cover),
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.primaryColor, width: 7))),
                child: CachedNetworkImage(
                  // memCacheWidth: 250,
                  // memCacheHeight: 250,
                  // maxHeightDiskCache: 250,
                  // maxWidthDiskCache: 250,
                  imageUrl:widget.imagePath??'',
                  placeholder: (context, url) =>
                      Center(
                          child: ShimmerSingleWidget(shimmerWidth: 100.w,)),
                  errorWidget: (context, url,
                      error) =>
                      Image.asset(
                        "assets/app_images/upload_image.png",scale: 5.3,
                        // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,

                      ),
                  fit: BoxFit.cover,
                  scale:20 ,
                  // width: double.infinity,
                  // height: 250,
                ),
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(


                      decoration: BoxDecoration(color: AppColors.whiteColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              AppIcons.locationIcon,
                              color: AppColors.primaryColor,
                              scale: 4.5,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              child: Text(
                                widget.restaurantLocation??"Cypress",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: "fontSpringExtraBold",
                                    fontSize: 14,overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              // widget.tagsList!.isNotEmpty||widget.tagsList!=null|| widget.tagsList![0] != ''?
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    width: Get.width,
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomListview(
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.tagsList!.length,
                        // height: 70,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:widget.tagsList![index].isNotEmpty? Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(45)),
                              // height: 30,
                              child: Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      // _offersController.offersList[widget.index],
                                      widget.tagsList![index].toString(),
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900, // For ExtraBold weight
                                      ),
                                    ),
                                  )),
                            ):Container(),
                          );
                        },
                        scrollDirection: Axis.horizontal,

                      ),
                    ),
                  ))
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CustomHorizontalPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        BoldText(
                            Text: "Date: "+widget.offerCreatedDate,
                            color: AppColors.primaryColor),
                        const Spacer(),
                        Image.asset(
                          AppIcons.tiktokIcon,
                          scale: 3,
                        ),
                        spacingBetweenPlatforms(),
                        Image.asset(
                          AppIcons.instagramIcon,
                          scale: 3,
                        ),
                        const SizedBox(width: 5,),
                        spacingBetweenPlatforms(),
                        Image.asset(
                          AppIcons.faceBookIcon,
                          scale: 3,
                        ),
                        spacingBetweenPlatforms(),
                        Image.asset(
                          AppIcons.fileIcon,
                          scale: 3,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BoldText(
                        Text: "Terms & Conditions:",
                        color: AppColors.primaryColor),
                    const SizedBox(height: 5),
                    const AppSubtitleText(
                      Text:
                          "Followings Are the terms and conditions to avail this offer: ",
                      color: Colors.black,
                      fontFamily: 'regular',
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        padding: EdgeInsets.only(bottom: 5),
                        itemBuilder: (context,index){
                      return CustomTermsAndConditionsPoints(
                          text: widget.termsAndConditions??'');
                    }),

                    // const CustomTermsAndConditionsPoints(
                    //     text:
                    //         "The offer must be used in a single Visit and cannot be split between multiple bills "),
                    // const CustomTermsAndConditionsPoints(
                    //     text:
                    //         "The offer does not apply to special events menus or holiday menus"),
                    // const CustomTermsAndConditionsPoints(
                    //     text:
                    //         "Please mention the offer at the time of booking to ensure eligibilty"),
                    const SizedBox(height: 20),
                  GestureDetector(
                      onTap: ()async{
                        _offersController.updateLatLongForNavigatingCamera(widget.lat!,widget.long!);
                        _generalController.onBottomBarTapped(1);
                        Get.offAll(()=>const CustomBottomBarr());
                        _offersController.filterNearByOffersForRestaurant(widget.lat!.toStringAsFixed(5),widget.long!.toStringAsFixed(5),widget.restaurantId.toString());
                        print(_offersController.lattitude!.value);
                        print(_offersController.longitude!.value);
                        print("object");

                      },
                      child: Locationbutton(address:address.isEmpty?"Loading...":  address,)),
                    const SizedBox(height: 20),
                    CustomButton(
                      Text: 'Redeem Now',
                      buttonColor: AppColors.primaryColor,
                      textColor: AppColors.whiteColor,
                        onTap: () {
                          // print(widget.tagsList![0].toString()+"asjh");
                          if(_authController.userStatusForShowingPopups.value=='false'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  height: 370,
                                  heading: "Want to Redeem Offers?",
                                  subHeading: "You need to sign in to redeem this offer.",
                                  buttonName: "Continue",img: AppIcons.questionMarkIcon,onTapped: () {

                                  Get.back();
                                  Get.back();
                                  // _generalController.onBottomBarTapped(0);
                                  // Get.off(() => const CustomBottomBarr());
                                  Get.to(()=>const SignInScreen());
                                },);
                              },
                            );
                          }else if(_authController.userStatusForShowingPopups.value==''){
                            showDialog(

                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  height: 370,
                                  heading: "Want to Redeem Offers?",
                                  subHeading: "You need to sign up in to redeem this offer.",
                                  buttonName: "Continue",img: AppIcons.questionMarkIcon,onTapped: () {
                                  Get.back();
                                  Get.back();
                                  // _generalController.onBottomBarTapped(0);
                                  // Get.off(() => const CustomBottomBarr());
                                  Get.to(()=>const SignUpScreeen());

                                },);
                              },
                            );
                          }else{
                            if(widget.canRedeemAgain==true){
                              Get.to(()=>RedeemOffersScreen(
                                  offerId:widget.offerId,
                                  imagePath: widget.imagePath,
                                  title: widget.foodTitle,
                                  description:widget.saleOnFood ,
                                  validTill:widget.validTill
                              ));
                            }else{
                              CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: "You cannot redeem this offer again");
                            }


                            // _offersController.redeemOffer(widget.offerId??'',context);
                            // setState(() {
                            //   _offersController.showQrCode.value = !_offersController.showQrCode.value;
                            // });
                          }
                        }
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget spacingBetweenPlatforms() {
    return const SizedBox(width: 10);
  }
}
