import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/views/auth_screens/auth_widgets/auth_screen_background_decoration.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/forget_password_screen.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_up/sign_up_screeen.dart';
import 'package:houstan_hot_pass/views/intro_screens/on_boarding_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../../../constants/custom_validators.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/custom_dialog.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controller
  final AuthController _authController=Get.find();
  bool showPassword = true;
  Widget spacing() {
    return SizedBox(height: 17);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCustomBackGround(
        child:   CustomHorizontalPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomScreenTitle(screenTitle: 'Sign In',
              onTap: (){
                Get.offAll(()=>OnBoardingScreen());
              },
              ),
              Expanded(
                child: Form(
                  key: _authController.formKeySignInScreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSubtitleText(Text: "Sign in to your account",color: AppColors.whiteColor.withOpacity(0.7)),
                      SizedBox(height: 40),
                      CustomTextField(
                        prefixIcon: AppIcons.emailIcon,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email address",
                        scale: 3.5,
                        controller: _authController.emailController,
                        validator: (value) => CustomValidator.email(value),
                        // validator: (value) => CustomValidator.email(value),
                      ),
                      spacing(),
                      CustomTextField(
                        prefixIconColor: AppColors.whiteColor,scale: 3.5,
                        maxLines: 1,
                        hintText: "Password",
                        validator: (value) => CustomValidator.password(value),
                        controller: _authController.passwordController,
                        // validator: (value) => CustomValidator.password(value),
                        keyboardType: TextInputType.visiblePassword,
                        isObscure: showPassword,
                        prefixIcon: AppIcons.lockIcon,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              !showPassword
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ZoomTapAnimation(
                        onTap: () {
                          _authController.emailController.clear();
                          _authController.emailControllerForgetPassword.clear();
                          Get.to(()=>ForgetPasswordScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppSubtitleText(
                                Text: "Forgot Password?",
                                color: Colors.white,
                                fontSize: 14),
                          ],
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                          Text: "SIGN IN",
                          onTap: () {
                 if(_authController.formKeySignInScreen.currentState!.validate()){
                   _authController.loginUser(true);
                        // Get.to(()=>CustomBottomBarr());
                        }
                          },
                          buttonName: ""),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSubtitleText(
                              Text: "Don't have an account? ",color: AppColors.whiteColor.withOpacity(0.7)
                              ),
                          ZoomTapAnimation(
                              onTap: () {
                                //
                                _authController.emailController.clear();
                                _authController.passwordController.clear();
                                Get.off(()=>SignUpScreeen());
                              },
                              child: Text("Sign Up",
                                  style: TextStyle(
                                    fontFamily: 'medium',
                                    color: AppColors.blackColor,fontSize: 15
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )

    );
  }
}
