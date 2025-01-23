import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/alertbox.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/utils/custom_dialog.dart';
import 'package:houstan_hot_pass/views/auth_screens/auth_widgets/auth_screen_background_decoration.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/sign_in_screen.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_up/complete_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../app_widgets/profile_picker.dart';
import '../../../constants/custom_validators.dart';

class SignUpScreeen extends StatefulWidget {
  const SignUpScreeen({super.key});

  @override
  State<SignUpScreeen> createState() => _SignUpScreeenState();
}

class _SignUpScreeenState extends State<SignUpScreeen> {
  // Controller
  final AuthController _authController=Get.find();
  // variables
  bool showPassword = true;
  bool confirmPassword = true;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _authController.emailController.clear();
  //   _authController.passwordController.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCustomBackGround(child:
      CustomHorizontalPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             CustomScreenTitle(screenTitle: 'Sign Up',onTap: (){
               _authController.emailController.clear();
               _authController.passwordController.clear();
               _authController.nameController.clear();
               _authController.confirmPasswordController.clear();
               Get.back();
             },),
             Expanded(
               child: SingleChildScrollView(
                 child: Form(
                   key: _authController.formKeySignUpScreen,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       AppSubtitleText(Text: "Enter the following details to sign up",color: AppColors.whiteColor.withOpacity(0.7),),
                       const SizedBox(height: 40),
                       // const ProfilePicker(forMyProfile: false,),
                       // const SizedBox(height: 30),
                       CustomTextField(

                         hintText: "First Name",prefixIcon: AppIcons.fullNameIcon,
                       controller: _authController.nameController,
                         validator: (value) => CustomValidator.isEmptyFirstName(value),
                       ),
                       spacing(),
                       CustomTextField(hintText: 'Email address',prefixIcon: AppIcons.emailIcon,
                       controller: _authController.emailController,
                         validator: (value) => CustomValidator.email(value),

                       ),
                       spacing(),
                       CustomTextField(
                         prefixIconColor: AppColors.whiteColor,scale: 3.5,
                         maxLines: 1,
                         hintText: "Password",

                         validator: (value) => CustomValidator.password(value),
                         keyboardType: TextInputType.visiblePassword,
                         controller: _authController.passwordController,
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
                       spacing(),
                       CustomTextField(
                         prefixIconColor: AppColors.whiteColor,scale: 3.5,
                         maxLines: 1,
                         hintText: "Confirm Password",
                         validator: (value) => CustomValidator.confirmPassword(value,_authController.passwordController.text),
                         keyboardType: TextInputType.visiblePassword,
                         controller: _authController.confirmPasswordController,
                         isObscure: confirmPassword,
                         prefixIcon: AppIcons.lockIcon,
                         suffixIcon: Padding(
                           padding: const EdgeInsets.only(right: 10),
                           child: GestureDetector(
                             onTap: () {
                               setState(() {
                                 confirmPassword = !confirmPassword;
                               });
                             },
                             child: Icon(
                               !confirmPassword
                                   ? CupertinoIcons.eye
                                   : CupertinoIcons.eye_slash,
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(height: 65),
                       CustomButton(Text: 'Sign Up',onTap: () {
                         if(_authController.formKeySignUpScreen.currentState!.validate()){
                           _authController.signUp(false);
                           // if(_authController.imagePath.value.isEmpty){
                           //   CustomDialog.showErrorDialog(description: "Please select image");
                           // }else{
                           //
                           // }
                           // Get.to(()=>const CompleteProfileScreen());
                         }

                       },),
                       const SizedBox(height: 30),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           AppSubtitleText(
                             Text: "Don't have an account? ",color: AppColors.whiteColor.withOpacity(0.7)
                           ),
                           ZoomTapAnimation(
                               onTap: () {
                                 _authController.emailController.clear();
                                 _authController.passwordController.clear();
                                 _authController.nameController.clear();
                                 _authController.confirmPasswordController.clear();
                                 Get.off(()=>const SignInScreen());
                               },
                               child: Text("Sign In",
                                   style: TextStyle(
                                     fontFamily: 'medium',
                                     color: AppColors.blackColor,
                                   )))
                         ],
                       ),
                       const SizedBox(
                         height: 20,
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ],
        ),
      )),
    );
  }
  Widget spacing() {
    return const SizedBox(height: 15);
  }

}
