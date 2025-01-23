import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/bottom_sheet.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/app_subtitle_text.dart';

class BecomeAMemberSubscriptionScreen extends StatefulWidget {
  const BecomeAMemberSubscriptionScreen({super.key});

  @override
  State<BecomeAMemberSubscriptionScreen> createState() => _BecomeAMemberSubscriptionScreenState();
}

class _BecomeAMemberSubscriptionScreenState extends State<BecomeAMemberSubscriptionScreen> {
  GeneralController generalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(height: 400,
                  width: 100.w,
                  child: Image.asset(AppImages.subscriptionMainImg,fit: BoxFit.fill,)),
              Positioned(left: 10,
                  child: CustomScreenTitle(screenTitle: "",))
            ],
          ),
          SizedBox(height:22 ),
          Expanded(
            child: CustomHorizontalPadding(
              child: Column(
                children: [
                  Text('Become a Member',style: TextStyle(fontFamily: "black",fontSize: 30,color: AppColors.primaryColor)),
                  SizedBox(height: 11),
               Container(
                 height: 75,
                 width: 90.w,
                 decoration: customShadowedDecoration(),
                 child: CustomHorizontalPadding(
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       AppSubtitleText(Text: "Monthly",color: Colors.black,fontSize: 18,),
                       AppSubtitleText(Text: " \$9/month",color: Colors.black.withOpacity(0.7),)
                       
                     ],
                   ),
                 ),
              
               ),
                  SizedBox(height: 35),
                  AppSubtitleText(Text: 'Autorenewable, Cancel anytime',color: Colors.black,fontSize: 13),
                  SizedBox(height: 11),
                  CustomButton(Text: 'Continue',buttonColor: AppColors.primaryColor,textColor: AppColors.whiteColor,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return WillPopScope(
                              onWillPop: () async {
                                if (MediaQuery.of(context)
                                    .viewInsets
                                    .bottom ==
                                    0.0) {
                                  Navigator.pop(context);
                                }
                                return false;
                              },
                              child: SafeArea(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                    top: 40,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: SizedBox(
                                      height: 380,
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 1, sigmaY: 1),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              topRight: Radius.circular(5.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                blurRadius: 8.0,
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 3,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(20)),
                                                ),
                                              ),
              
                                              BottomSheetForSelectPaymentMethod(),
                                              // DestinationDialog(
                                              //      tappedPoint: tappedPoint, currentPosition: currentPosition!,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ).then((value) {
                        setState(() {});
                      });
                    },),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppSubtitleText(Text: "Privacy Policy",color: Colors.black,fontSize: 12),
                      verticleDivider(),
                      AppSubtitleText(Text: "Restore Purchase",color: Colors.black,fontSize: 12),
                      verticleDivider(),
                      AppSubtitleText(Text: "Terms Of Use",color: Colors.black,fontSize: 12),
                    ],
                  )
              
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
  Widget verticleDivider() {
    return   SizedBox(height: 15,
        child: VerticalDivider(color: Colors.black,thickness: 1));

  }
}
