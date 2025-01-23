import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/alertbox.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/app_widgets/shimmer_single_widget.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/controllers/timer_controller.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/sign_in_screen.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../../app_widgets/QR_scanner.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../auth_screens/sign_up/sign_up_screeen.dart';
import 'package:dotted_border/dotted_border.dart';
class RedeemOffersScreen extends StatefulWidget {
  RedeemOffersScreen({super.key,this.offerId,this.imagePath,this.title,this.description,this.validTill});
  String? offerId;
  String? imagePath;
  String? title;
  String? description;
  String? validTill;


  @override
  State<RedeemOffersScreen> createState() => _RedeemOffersScreenState();
}

class _RedeemOffersScreenState extends State<RedeemOffersScreen> {

  // void initState() {
  //   super.initState();
  //
  //   // Show popup after 10 seconds
  //   Future.delayed(const Duration(seconds: 10), () {
  //     // Show dialog
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CustomAlertDialog(
  //           heading: "Driver Has Arrived",
  //           subHeading: "Enjoy your meal! See you in next order :)",
  //           buttonName: "Complete Order",img: AppIcons.successIcon,onTapped: () {
  //           Get.to(());
  //         },);
  //       },
  //     );
  //   });
  // }

  // bool showQrCode = false;
  bool showMessage = false;
  // late Timer _timer;
  // int _countdown = 60;
  // bool _resendVisible = false;
  // bool _regenerateVisible = false;
  // bool _showTimerValues = false;

  @override
  void initState() {
    super.initState();
    _offersController.showQrCode.value=false;

    _timerControlle.regenerateVisible.value=false;
    _offersController.getData(widget.offerId!);
  // Future.delayed(Duration(seconds: 5));

    // Future.delayed(const Duration(seconds: 10), () {
    //   // Show dialog
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return CustomAlertDialog(
    //         heading: "Offer Redeemed successfully",
    //         subHeading: "Congratulations! Discount Offer has been redemmed successfully.enjoy your meal ☺️!",
    //         buttonName: "Great",img: AppIcons.successIcon,onTapped: () {
    //         Get.back();
    //       },);
    //     },
    //   );
    // });

    showMessage = false;
    // startTimer();
  }

  @override
  void dispose() {
    _timerControlle.timer.cancel();
    super.dispose();
  }

  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (_countdown > 0) {
  //         _countdown--;
  //       } else {
  //         _timer.cancel();
  //         _resendVisible = true;
  //         _regenerateVisible = true; // Show regenerate text
  //       }
  //     });
  //   });
  // }

  // void resendOtp() {
  //   // Logic to resend OTP, e.g., make API call
  //   setState(() {
  //     _countdown = 60; // Reset countdown
  //     _resendVisible = false; // Hide resend button
  //     _regenerateVisible = false; // Hide regenerate text
  //   });
  //   startTimer(); // Start
  //   // the timer again
  // }
GeneralController _generalController=Get.find();
OffersController _offersController=Get.find();
AuthController _authController=Get.find();
TimerController _timerControlle=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=> Column(
          children: [
            const CustomAppBarBackGround(
              showTextField: false,
              showFiltersIcon: false,
              showBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CustomHorizontalPadding(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppSubtitleText(
                              Text: 'Offer', color: Colors.black, fontSize: 20),
                          AppSubtitleText(
                            Text:widget.validTill?? "Valid Until: 7/26/2024",
                            color: AppColors.primaryColor,
                            fontSize: 13,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 190,
                        width: 90.w,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              // memCacheWidth: 150,
                              // memCacheHeight: 150,
                              // maxHeightDiskCache: 150,
                              // maxWidthDiskCache: 150,
                              imageUrl:widget.imagePath??AppImages.foodTileImg,
                              placeholder: (context, url) =>
                                  Center(
                                      child: ShimmerSingleWidget(shimmerWidth: 90.w)),
                              errorWidget: (context, url,
                                  error) =>
                                  Image.asset(
                                    AppImages.foodTileImg,scale: 5.3,
                                    // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,

                                  ),
                              fit: BoxFit.cover,
                              scale:20 ,
                              // width: double.infinity,
                              // height: 250,
                            ),
                            // Image.asset(AppImages.foodTileImg, fit: BoxFit.cover),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                width: 85.w,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryColor, // Shadow color
                                      spreadRadius: 1, // The radius of the shadow
                                      blurRadius: 0, // The blur effect
                                      offset: const Offset(0, -5), // Offset of the shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 17),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppSubtitleText(
                                        Text: widget.title??'curry pizza guys',
                                        color: Colors.black,
                                        height: 1,
                                        maxLines: 3,
                                      ),
                                      const SizedBox(height: 4),
                                       Text(
                                        widget.description??'30% Off On All-You-Can-Eat',
                                         overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontFamily: "regular",
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (_offersController.showQrCode.value) ...[
                        _offersController.codeType.value=='code'?
                        Column(
                          children: [
                            Text(
                              "Ask staff to use this code to redeem offer.",
                              textAlign: TextAlign.center,
                              style: TextStyle(

                                  fontFamily: "fontspring-semibold",
                                  fontSize: 18,
                                  color: AppColors.blackColor),
                            ),
                            SizedBox(height: 10.h),
                            const SizedBox(height: 10),
                            Text(
                             "OFFER CODE",
                              style: TextStyle(
                                fontSize: 22,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            DottedBorder(
                              borderType: BorderType.RRect, // Rounded rectangle
                              radius: Radius.circular(20), // Corner radius
                              dashPattern: [6, 3], // Length and spacing of dashes
                              color: AppColors.primaryColor, // Dotted line color
                              strokeWidth: 3, // Width of the dotted line
                              child: Container(
                                height: 60,
                                width: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  _offersController.qrCodeDataForRedeemingOffer.value,
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                            _offersController.codeType.value=='code'?SizedBox(height: 10.h):Container(),

                          ],
                        ) : Column(
                          children: [
                            Text(
                              "Offer QR code",
                              style: TextStyle(
                                  fontFamily: "fontspring-semibold",
                                  fontSize: 20,
                                  color: AppColors.primaryColor),
                            ),
                            const SizedBox(height: 10),
                            // customQrScanner(),
                            SizedBox(
                              height: 280,
                              width: 280,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
                                child: QrImageView(
                                  data: _offersController.qrCodeDataForRedeemingOffer.value,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                            )
                          ],
                        ),

                      ] else
                        const SizedBox(height: 80),

                      if (!_offersController.showQrCode.value)
                        CustomButton(
                          Text: "REDEEM",
                          buttonColor: AppColors.primaryColor,
                          textColor: Colors.white,
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
                                    _generalController.onBottomBarTapped(0);
                                    Get.off(() => const CustomBottomBarr());
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
                                    _generalController.onBottomBarTapped(0);
                                    Get.off(() => const CustomBottomBarr());
                                    Get.to(()=>const SignUpScreeen());
                                  },);
                                },
                              );
                            }else{
                              // _timerControlle.startTimer();
                              _offersController.redeemOffer(widget.offerId??'',context);
                              // setState(() {
                              //   _offersController.showQrCode.value = !_offersController.showQrCode.value;
                              // });
                            }

                          },
                        ),
                      // const SizedBox(height: 10),
                      if (_timerControlle.regenerateVisible.value)
                        GestureDetector(
                          onTap: () {
                          // _offersController.showQrCode.value=!_offersController.showQrCode.value;
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
                                    _generalController.onBottomBarTapped(0);
                                    Get.off(() => const CustomBottomBarr());
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
                                    _generalController.onBottomBarTapped(0);
                                    Get.off(() => const CustomBottomBarr());
                                    Get.to(()=>const SignUpScreeen());
                                  },);
                                },
                              );
                            }else{
                              // resendOtp();
                              // _offersController.showQrCode.value=true;
                              _offersController.redeemOffer(widget.offerId??'',context);

                              // setState(() {
                              //   _showTimerValues=true;
                              // });

                              // setState(() {
                              //   _offersController.showQrCode.value = !_offersController.showQrCode.value;
                              // });
                            }

                          },
                          child: Text(
                            "Regenerate",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 20,
                                fontFamily: "bold"),
                          ),
                        ),
                      // const SizedBox(height: 13,),
                       Text(
                         _timerControlle.resendVisible.value ? '' :_offersController.showQrCode.value==true? ' 00:${_timerControlle.countdown.toString().padLeft(2, '0')}':'', // Use padLeft to format
                        // _resendVisible ? '' : ' 00:$_countdown',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontFamily: "bold"),
                      ),
                      _timerControlle.regenerateVisible.value?Container():_offersController.showQrCode.value==true?  AppSubtitleText(
                        Text: "Seconds left",
                        fontSize: 15,
                      ):Container(),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
