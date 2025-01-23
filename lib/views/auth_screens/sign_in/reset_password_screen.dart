import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/views/auth_screens/auth_widgets/auth_screen_background_decoration.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/forget_password_screen.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/custom_validators.dart';
import '../../../controllers/auth_controller.dart';
import 'sign_in_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  AuthController _authController=Get.find();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = true;
  bool confirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCustomBackGround(
        child:
      CustomHorizontalPadding(
        child: Form(
          key: _authController.formKeyChangePasswordScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomScreenTitle(screenTitle: 'Reset Password',
                  onTap:(){
               Get.back();
               Get.back();
              }
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSubtitleText(Text: 'Create new password for your account ',color: AppColors.whiteColor.withOpacity(0.7)),
                      const SizedBox(height: 40),
                      CustomTextField(
                        maxLines: 1,
                        hintText: "Password",
                        prefixIcon: AppIcons.lockIcon,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _authController.changePasswordController,
                        isObscure: showPassword,
                        validator: (value) => CustomValidator.newPassword(value),
                        // prefixIcon: AppImages.lockImage,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(
                                showPassword
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // AppSubtitleText(Text: "Password must be 8 characters long"),
                      // const SizedBox(height: 15),
                      CustomTextField(
                        maxLines: 1,
                        hintText: "Confirm Password",
                        prefixIcon: AppIcons.lockIcon,
                        controller: _authController.confirmChangePasswordController,
                        isObscure: confirmPassword,
                        validator: (value) => CustomValidator.confirmPassword(value,_authController.changePasswordController.text),
                        // prefixIcon: AppImages.lockImage,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  confirmPassword = !confirmPassword;
                                });
                              },
                              icon: Icon(
                                confirmPassword
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              )),
                        ),
                      ),
                      SizedBox(height: 140),
                      CustomButton(Text: "Continue",onTap: () {
                        if(_authController.formKeyChangePasswordScreen.currentState!.validate()){
                          _authController.resetPassword();
                        }
                        // Get.to(()=>SignInScreen());

                      },),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
      )


    );
  }
}
