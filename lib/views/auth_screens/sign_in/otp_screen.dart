import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/utils/custom_dialog.dart';
import 'package:houstan_hot_pass/views/auth_screens/auth_widgets/auth_screen_background_decoration.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/sign_in_screen.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_up/complete_profile.dart';

import 'package:sizer/sizer.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/base_controller.dart';
import '../sign_up/sign_up_screeen.dart';
import 'reset_password_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';




class OtpScreen extends StatefulWidget {
  OtpScreen({super.key,required this.isFromForgotPassword,required this.isFromLoginScreen});

bool isFromForgotPassword;
bool isFromLoginScreen;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";
  String errorMessage = "Please Enter Otp field";
  bool showMessage = false;
  late Timer _timer;
  int _countdown = 60;
  bool _resendVisible = false;
  final AuthController _authController=Get.find();


  @override
  void initState() {
    super.initState();
    showMessage = false;
    startTimer();
  }
  final FocusNode _otpFocusNode = FocusNode();


  @override
  void dispose() {
    _timer.cancel();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // Timer reached zero, enable resend button
          _timer.cancel();
          _resendVisible = true;
        }
      });
    });
  }

  void resendOtp() {
    // Logic to resend OTP, e.g., make API call
    setState(() {
      _countdown = 60; // Reset countdown
      _resendVisible = false; // Hide resend button
    });
    startTimer(); // Start the timer again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCustomBackGround(
        child: CustomHorizontalPadding(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          // if(widget.isFromForgotPassword==true){
                          //   Get.back();
                          // }else if(widget.isFromForgotPassword==false){
                          //   // Get.back();
                          //   Get.off(()=>SignUpScreeen());
                          //   // Get.to(()=>SignUpScreeen());
                          // }else if(widget.isFromLoginScreen==true){
                          //   Get.off(()=>SignInScreen());
                          // }

                        },
                        child:  const Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Icon(
                              Icons.arrow_back,color: Colors.white,
                              size: 25,
                
                
                            )),
                      ),
                      const SizedBox(width: 10),
                      const BoldText(Text: "OTP Verification",fontSize: 20,color: Colors.white),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppSubtitleText(Text: "Enter the verification code sent to your email address",color: AppColors.whiteColor.withOpacity(0.7)),
                      SizedBox(height: 100),
                      // Center(
                      //   child: OtpTextField(
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      //
                      //     fieldWidth: 55,
                      //     fieldHeight: 67,
                      //     numberOfFields: 4,
                      //     borderColor: Colors.yellow,
                      //     // borderRadius: BorderRadius.circular(10),
                      //     cursorColor: Colors.black,
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     obscureText: false,
                      //     textStyle:  TextStyle(fontFamily: "bold",fontSize: 22,color: Colors.white),
                      //     borderWidth: 1.5,
                      //     enabledBorderColor: Colors.white,
                      //     filled: true,
                      //     focusedBorderColor: AppColors.whiteColor,
                      //     fillColor:AppColors.primaryColor,
                      //     showFieldAsBox: true,
                      //     onCodeChanged: (String code) {
                      //       print(code);
                      //       setState(() {
                      //         otp = code;
                      //         // print(otp);
                      //
                      //
                      //       });
                      //     },
                      //     onSubmit: (value) {
                      //       setState(() {
                      //         otp = value;
                      //         print(otp);
                      //       });
                      //     },
                      //   ),
                      // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.none,
                          cursorColor: Colors.black,
                          textStyle: const TextStyle(
                            fontFamily: "bold",
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(1),
                            fieldHeight: 67,
                            fieldWidth: 55,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white,
                            selectedColor: AppColors.whiteColor,
                            activeFillColor: AppColors.primaryColor,
                            inactiveFillColor: AppColors.primaryColor,
                            selectedFillColor: AppColors.primaryColor,
                          ),
                          enableActiveFill: true,
                          onChanged: (String value) {
                            setState(() {
                              otp = value;
                            });
                          },
                          onCompleted: (String value) {
                            setState(() {
                              otp = value;
                              print("Completed OTP: $otp");
                              _otpFocusNode.unfocus();
                            });
                          },
                        ),
                      ),
                    ),
                      SizedBox(height: 120),
                  
                      showMessage == true
                          ? const Text(
                        "Please Enter OTP",
                        style: TextStyle(color: Colors.red),
                      )
                          : const SizedBox.shrink(),
                          
                          
                      _resendVisible
                          ? GestureDetector(
                          onTap: () {
                            if(widget.isFromForgotPassword){
                              _authController.sendOtpCode();
                              resendOtp();
                            }else{
                              _authController.sendOtpToVerifyUser(false,false);
                              resendOtp();
                            }


                            // _authController.sendOtpToVerifyUser(true,widget.isFromLoginScreen);
                          },
                          child: Center(child: AppSubtitleText(Text: "Resend",fontSize: 15,TextALign: TextAlign.center,color: Colors.white,))
                      )
                          :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSubtitleText(
                            Text: "Resend Code in",
                            fontSize: 15,
                            color: AppColors.whiteColor.withOpacity(0.7),
                          ),
                          Text(
                            _resendVisible ? '' : ' 00:${_countdown.toString().padLeft(2, '0')}', // Use padLeft to format
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontFamily: "medium",
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //      AppSubtitleText(
                      //       Text: "Resend Code in",fontSize: 15,color: AppColors.whiteColor.withOpacity(0.7)),
                      //     Text(
                      //       _resendVisible ? '' : ' 00:$_countdown',
                      //       style: TextStyle(color: AppColors.blackColor,fontSize: 16,fontFamily: "medium"),
                      //     ),
                      //   ],
                      // ),
                          
                      SizedBox(height: 30),
                      CustomButton(Text: "Verify",onTap: () {
                        if(otp.isEmpty){
                          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: "Please enter OTP.");
                        }else if(otp.length<4){
                          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: "Please enter valid OTP code.");
                        }else if(widget.isFromForgotPassword){
                          _authController.verifyOtpToResetPassword(otp);
                        }else{
                          _authController.verifyOtpToVerifyUser(otp);
                        }
                        // Get.to(()=>ResetPasswordScreen());
                      },buttonName: ""),
                    ],
                  ),
                ),
              ),
            ]),
        ),
        )

    );
  }
}
