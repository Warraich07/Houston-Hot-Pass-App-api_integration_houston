import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/locationButton.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/views/blogs/widgets/crousal_slider.dart';
import 'package:houstan_hot_pass/views/home/redeem_offers_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../../app_widgets/alertbox.dart';
import '../../app_widgets/app_button.dart';
import '../../app_widgets/bold_text.dart';
import '../../app_widgets/custom_listview.dart';
import '../../app_widgets/scaffold_symmetric_padding.dart';
import '../../app_widgets/shimmer_single_widget.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/offers_controller.dart';
import '../../utils/custom_dialog.dart';
import '../auth_screens/sign_in/sign_in_screen.dart';
import '../auth_screens/sign_up/sign_up_screeen.dart';
import 'package:google_fonts/google_fonts.dart';
class BlogDetailsScreen extends StatefulWidget {
  // const BlogDetailsScreen({super.key});
  BlogDetailsScreen({super.key,this.foodTitle,this.saleOnFood,this.restaurantLocation,this.tagsList,this.validTill,this.termsAndConditions,this.offerId,this.imagePath,this.featuredImagesList,this.lat,this.long,this.restaurantId,required this.canRedeemAgain,this.htmWidgetDescription,required this.offerCreatedAt,this.foodTitleToRedeem,this.foodDescriptionToRedeem,this.offer});
  String? restaurantId;
  String? imagePath;
  String? offerId;
  String? foodTitle;
  String? saleOnFood;
  String? restaurantLocation;
  String? validTill;
  String? termsAndConditions;
  List<String>? featuredImagesList;
  List<String>? tagsList;
  double? lat;
  double? long;
  bool canRedeemAgain;
  String? htmWidgetDescription;
  String offerCreatedAt='';
  String? foodTitleToRedeem;
  String? foodDescriptionToRedeem;
  String? offer;
  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  // Arrays
  List<String> imagePaths = [
    AppImages.foodTileImg,
    'assets/app_images/food_img2.png',
    'assets/app_images/food_img.png'
  ];
  List<String> image = [
    "assets/app_images/food_img.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
  ];
  OffersController _offersController=Get.find();
  GeneralController _generalController=Get.find();
  AuthController _authController=Get.find();
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
  // Variables
  String selectedImage = "";
  void initState() {
    super.initState();
    selectedImage = imagePaths[0];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAddressFromLatLng(widget.lat!, widget.long!).then((value){
        print(value.toString());
      });
    });
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(builder: (context, setState) {
            return Stack(
              children: [
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ZoomTapAnimation(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                CupertinoIcons.xmark,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Container(
                          width: 100.w,
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                selectedImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(

                              itemCount: imagePaths.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var img = imagePaths[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: ZoomTapAnimation(
                                    onTap: () {
                                      print(selectedImage);
                                      setState(() {
                                        selectedImage = img;
                                      });
                                    },
                                    child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: selectedImage == img
                                                    ? AppColors.whiteColor
                                                    : Colors.transparent),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(img),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                );
                              }),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
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
                  height: 165,
                  width: 100.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage(AppImages.homeAppBarBackgroundImage),
                          fit: BoxFit.cover))),
              Positioned(
                  child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      children: [
                        ZoomTapAnimation(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              'assets/app_icons/back_button.png',
                              scale: 4,
                            )),
                        const Spacer(),
                       widget.offer.toString()=='null'?Container(): ZoomTapAnimation(
                          onTap: () {
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
                                    title: widget.foodTitleToRedeem,
                                    description:widget.foodDescriptionToRedeem ,
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
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration:
                                BoxDecoration(color: AppColors.primaryColor),
                            child: Center(
                              child: Text(
                                "Redeem Now",
                                style: TextStyle(
                                    fontFamily: 'fontSpringExtraBold',
                                    color: AppColors.whiteColor,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              Positioned(
                  child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Row(
                      children: [
                        AppSubtitleText(
                          Text: widget.foodTitle!,
                          color: AppColors.blackColor,
                          fontSize: 11,
                        ),
                        const Spacer(),
                        widget.offer.toString()=='null'?Container(): AppSubtitleText(
                          Text: "Valid Until: "+widget.validTill!,
                          color: AppColors.primaryColor,
                          fontSize: 13,
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

                    SizedBox(width: 80.w,
                      child: Tooltip(
                        message:  widget.saleOnFood!,
                        child: Text(
                          maxLines: 2,
                          widget.saleOnFood!,
                          style: const TextStyle(
                              fontSize: 24,
                              fontFamily: "swear-banner-regular",
                              color: Colors.black,
                              height: 1.1,overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 276,
                        width: 100.w,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: ,
                        //         fit: BoxFit.cover),
                        //     border: Border(
                        //         bottom: BorderSide(
                        //             color: AppColors.primaryColor, width: 7))),
                        child: CachedNetworkImage(
                          // memCacheWidth: 150,
                          // memCacheHeight: 150,
                          // maxHeightDiskCache: 150,
                          // maxWidthDiskCache: 150,
                          imageUrl:widget.imagePath??'',
                          placeholder: (context, url) =>
                              Center(
                                  child: ShimmerSingleWidget(shimmerWidth: 100.w,)),
                          errorWidget: (context, url,
                              error) =>
                              Image.asset(
                                AppImages.foodTileImg,
                                // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
                                fit: BoxFit.cover,
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
                          child: Container(
                            // height: 40,
                            // width: 100,
                            decoration:
                                BoxDecoration(color: AppColors.whiteColor),
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
                                  Text(
                                    widget.restaurantLocation!,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: "bold",
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      // Positioned(
                      //     bottom: 15,
                      //     left: 20,
                      //     child:
                      //   SizedBox(
                      //     height: 100,
                      //     child: ListView.builder(
                      //       shrinkWrap: true,
                      //         itemCount: widget.tagsList!.length,
                      //         itemBuilder: (context,index){
                      //       return SizedBox(
                      //         height: 34,
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(right: 8.0),
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(45)),
                      //             // height: 30,
                      //             child: Center(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                       horizontal: 10.0),
                      //                   child: Text(
                      //                     "Indian",
                      //                     style: TextStyle(
                      //                         fontFamily: 'fontSpringExtraBold'),
                      //                   ),
                      //                 )),
                      //           ),
                      //         ),
                      //       );
                      //     }),
                      //   )
                      // ),
                      Positioned(
                          bottom: 0,
                          left: 10,
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
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(
                                              // _offersController.offersList[widget.index],
                                              widget.tagsList![index].toString(),
                                              style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900, /// For ExtraBold weight
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
                      // Positioned(
                      //     bottom: 15,
                      //     left: 20,
                      //     child: SizedBox(
                      //       height: 34,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(right: 8.0),
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(45)),
                      //           // height: 30,
                      //           child: Center(
                      //               child: Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10.0),
                      //             child: Text(
                      //               "Indian",
                      //               style: TextStyle(
                      //                   fontFamily: 'fontSpringExtraBold'),
                      //             ),
                      //           )),
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                  CustomHorizontalPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spacing(),
                        Row(
                          children: [
                            // widget.offer.toString()=='null'?Container():
                            BoldText(
                                Text: "Date: "+widget.offerCreatedAt,
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
                        spacing(),
                        // CustomListview(
                        //   itemBuilder: (context, index) {
                        //     return Column(
                        //       children: [
                        //         const SizedBox(height: 5),
                        //         RichText(
                        //           text: TextSpan(
                        //             children: <TextSpan>[
                        //               TextSpan(
                        //                 text: 'Handam BBQ ',
                        //                 style: TextStyle(
                        //                   fontFamily: "regular",
                        //                   color: AppColors
                        //                       .primaryColor, // Color for the underlined text
                        //                   fontSize: 13.0,
                        //                   decoration: TextDecoration
                        //                       .underline, // Underline the text
                        //                 ),
                        //               ),
                        //               const TextSpan(
                        //                 text:
                        //                     'is always one of our top\nrecommendations for AYCE KBBQ in Houston. Nestled in the heart of Chinatown, they’re always consistent in delivering tender meats, sizeable banchan, and tasty traditional Korean dishes.',
                        //                 style: TextStyle(
                        //                   color: Colors
                        //                       .black, // Color for the second part
                        //                   fontFamily: "regular",
                        //                   fontSize: 13.0,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         spacing(),
                        //         GestureDetector(
                        //           onTap: () {
                        //             _showImageDialog(context, image[index]);
                        //           },
                        //           child: SizedBox(
                        //               height: 400,
                        //               width: 90.w,
                        //               child: Image.asset(
                        //                   "assets/app_images/food_img2.png",
                        //                   fit: BoxFit.cover)),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        //   scrollDirection: Axis.vertical,
                        //   itemCount: 2,
                        //   physics: const NeverScrollableScrollPhysics(),
                        // ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: HtmlWidget(
                            widget.htmWidgetDescription!,
                            textStyle: const TextStyle(
                              fontSize: 15, fontFamily: 'regular',  color: Colors.black,),
                            // overflow: TextOverflow.ellipsis,maxLines: 3,
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            _offersController.updateLatLongForNavigatingCamera(widget.lat!,widget.long!);
                            _generalController.onBottomBarTapped(1);
                            Get.offAll(()=>const CustomBottomBarr());
                            _offersController.filterNearByOffersForRestaurant(widget.lat!.toStringAsFixed(5),widget.long!.toStringAsFixed(5),widget.restaurantId.toString());

                          },
                          child: Locationbutton(
                            address:address.isEmpty?"Loading...": address,
                          ),
                        ),
                        spacing(),
                        spacing(),
                        CrousalSlider(
                          isFeaturedBlogs: false,
                          showHeadingWidgets: false,
                          height: 250,
                          showGestureButtons: true,
                          featuredImagesList: widget.featuredImagesList,
                          imagesHeadingList: [],
                        ),
                        spacing(),
                        spacing(),
                        widget.offer.toString()=='null'?Container(): CustomButton(
                          Text: "Redeem Now",

                          textColor: Colors.white,
                          buttonColor: AppColors.primaryColor,
                            onTap: () {
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
                                      title: widget.foodTitleToRedeem,
                                      description:widget.foodDescriptionToRedeem ,
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
                              // showDialog(
                              //
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return CustomAlertDialog(
                              //       height: 370,
                              //       heading: "Want to Redeem Offers?",
                              //       subHeading: "You need to sign up/sign in to redeem this offer.",
                              //       buttonName: "Continue",img: AppIcons.questionMarkIcon,onTapped: () {
                              //       Get.to(()=>SignUpScreeen());
                              //     },);
                              //   },
                              // );
                            }

                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
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

  Widget spacing() {
    return const SizedBox(height: 10);
  }
}
