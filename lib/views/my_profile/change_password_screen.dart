import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';

import '../../app_widgets/custom_field .dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/custom_validators.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // TextEditingController oldPasswordController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();
  AuthController _authController=Get.find();
  bool oldPassword = true;
  bool password = true;
  bool confirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CustomAppBarBackGround(
            showTextField: false,
            showFiltersIcon: false,
            showIcon: false,
            screenTitle: "Change Password",
            showScreenTitle: true,
            showBackButton: true,
            height: 125,
            screenSubtitle: "create new password for your account",
            showScreenSubtitle: true,
          ),
          CustomHorizontalPadding(
            child: Form(
              key: _authController.formKeyResetPasswordScreen,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  CustomTextField(
                    isEditProfileInfoScreen:true,
                    prefixIcon: AppIcons.lockIcon,
                    prefixIconColor: Colors.black.withOpacity(0.6),
                    hintText: "Old Password",
                    hintTextColor: Colors.black.withOpacity(0.6),
                    fillColor: Colors.white,
                    fieldBorderColor: AppColors.primaryColor,
                    fieldName: "First Name",
                    inputTextColor: Colors.black,
                    validator: (value) => CustomValidator.oldPassword(value),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _authController.oldPasswordController,
                    isObscure: oldPassword,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              oldPassword = !oldPassword;
                            });
                          },
                          icon: Icon(
                            oldPassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                          )),
                    ),
                    suffixIconColor: Colors.black.withOpacity(0.5),

                  ),
                  spacing(),
                  CustomTextField(
                    isEditProfileInfoScreen:true,
                    prefixIcon: AppIcons.lockIcon,
                    prefixIconColor: Colors.black.withOpacity(0.6),
                    hintText: "New Password",
                    hintTextColor: Colors.black.withOpacity(0.6),
                    fillColor: Colors.white,
                    fieldBorderColor: AppColors.primaryColor,
                    inputTextColor: Colors.black,
                    validator: (value) => CustomValidator.newPassword(value),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _authController.passwordController,
                    isObscure: password,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              password = !password;
                            });
                          },
                          icon: Icon(
                            password
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                          )),
                    ),
                    suffixIconColor: Colors.black.withOpacity(0.5),
                  ),
                  spacing(),
                  CustomTextField(
                    isEditProfileInfoScreen:true,
                    prefixIcon: AppIcons.lockIcon,
                    prefixIconColor: Colors.black.withOpacity(0.6),
                    hintText: "Confirm New Password",
                    hintTextColor: Colors.black.withOpacity(0.6),

                    fillColor: Colors.white,
                    fieldBorderColor: AppColors.primaryColor,
                    inputTextColor: Colors.black,
                    validator: (value) => CustomValidator.confirmPassword(value,_authController.passwordController.text),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _authController.confirmPasswordController,
                    isObscure: confirmPassword,
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
                    suffixIconColor: Colors.black.withOpacity(0.5),

                  ),
                  SizedBox(height: 100),
                  CustomButton(Text: "Save Changes",buttonColor: AppColors.primaryColor,textColor: AppColors.whiteColor,
                    onTap: () {
                    if(_authController.formKeyResetPasswordScreen.currentState!.validate()){
                      _authController.changePassword();

                    }

                  },)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget spacing() {
    return SizedBox(height: 17);
  }
}
