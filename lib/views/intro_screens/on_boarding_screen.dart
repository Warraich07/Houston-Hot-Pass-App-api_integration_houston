import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/sign_in_screen.dart';
import 'package:houstan_hot_pass/views/home/home_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  GeneralController _generalController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 57.h,
                width: 100.w,
                child: Image.asset(
                  AppImages.onBoardingImage,
                  fit: BoxFit.cover,
                )),
            const SizedBox(height: 25),
            SingleChildScrollView(
              child: CustomHorizontalPadding(
                child: Column(
                  children: [
                    Text(
                      'YOUR PASS TO THE BEST OF HOUSTON 🚀',
                      style: TextStyle(
                          fontFamily: "fontSpringExtraBold",
                          color: AppColors.primaryColor,
                          fontSize: 25,
                          height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Get exclusive perks and discounts at\nHouston's best restaurants, bars, coffee\nshops, and much more!",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "medium",
                          color: Colors.black.withOpacity(0.7)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      Text: "EXPLORE HOTPASS",
                      textColor: AppColors.whiteColor,
                      buttonColor: AppColors.primaryColor,
                      onTap: () {
                        _generalController.onBottomBarTapped(0);
                        Get.offAll(() => CustomBottomBarr());
                      },
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontFamily: "medium"),
                        ),
                        ZoomTapAnimation(
                            onTap: () {
                              Get.to(() => SignInScreen());
                            },
                            child: Text("Sign In",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: "medium"))),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
