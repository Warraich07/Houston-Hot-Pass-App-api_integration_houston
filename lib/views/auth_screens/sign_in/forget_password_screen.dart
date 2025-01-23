import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/views/auth_screens/auth_widgets/auth_screen_background_decoration.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/otp_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/custom_validators.dart';
import '../../../controllers/auth_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final AuthController _authController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCustomBackGround(
          child: CustomHorizontalPadding(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomScreenTitle(screenTitle: "Forget Password?"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _authController.formKeyForgetPasswordScreen,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSubtitleText(Text: "Enter the email address to get verification code for reset password",color: AppColors.whiteColor.withOpacity(0.7)),
                          SizedBox(height: 50),
                          CustomTextField(
                            hintText: "Email address",
                            prefixIcon: AppIcons.emailIcon,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => CustomValidator.email(value),
                            controller: _authController.emailControllerForgetPassword,
                          ),
                          SizedBox(height: 25.h),
                          CustomButton(Text: "Send Code",onTap: () {

                            if(_authController.formKeyForgetPasswordScreen.currentState!.validate()){

                              _authController.sendOtpCode();
                              // Get.to(()=>OtpScreen(isFromForgotPassword: true,isFromLoginScreen: false,));
                            }

                          },),
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
      ),
    );
  }
}
