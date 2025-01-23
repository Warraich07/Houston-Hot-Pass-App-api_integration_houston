import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/app_subtitle_text.dart';
import '../../app_widgets/bold_text.dart';
import '../../constants/app_colors.dart';
import '../../utils/shared_preference.dart';
import '../auth_screens/sign_in/sign_in_screen.dart';



class LogOutBottomSheet extends StatefulWidget {
  const LogOutBottomSheet({super.key});

  @override
  State<LogOutBottomSheet> createState() => _LogOutBottomSheetState();
}

class _LogOutBottomSheetState extends State<LogOutBottomSheet> {
  final AuthPreference _authPreference = AuthPreference.instance;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child:  Container(
        width: 100.w,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: AppColors.primaryColor, // Top border color
              width: 3.5, // Adjust width as needed
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 10.w,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              SizedBox(height: 15),
              BoldText(
                Text: "Log out",
                fontSize: 20,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
          SizedBox(height: 10),
              SizedBox(
                width: 70.w,
                child: AppSubtitleText(fontSize: 17,
                  Text: "Are you sure you want to log out from your account?",
                  TextALign: TextAlign.center,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 55,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffF1F1F1),
                        ),
                        child: const Center(
                          child: BoldText(
                            Text: 'No',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _authPreference.setUserLoggedIn(false);
                        Navigator.of(context).pop();
                        Get.offAll(() => const SignInScreen());
                      },
                      child: Container(
                        height: 55,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        child: const Center(
                          child: BoldText(
                            Text: "Yes, Log out",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
