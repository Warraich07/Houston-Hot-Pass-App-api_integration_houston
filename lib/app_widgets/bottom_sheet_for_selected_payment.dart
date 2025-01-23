import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_up/widgets/payment_button.dart';
import 'package:sizer/sizer.dart';

class BottomSheetForSelectedPayment extends StatefulWidget {
  const BottomSheetForSelectedPayment({super.key});

  @override
  State<BottomSheetForSelectedPayment> createState() => _BottomSheetForSelectedPaymentState();
}

class _BottomSheetForSelectedPaymentState extends State<BottomSheetForSelectedPayment> {
  // Controllers


  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController locationTab = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        width: 100.w,
        height: 80.h,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 15.w,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const BoldText(
                      Text: "Proceed Payment With",color: Colors.black,
                      fontSize: 20,
                    ),
                    const SizedBox(height: 5),
                    AppSubtitleText(Text: "Choose your payment method"),
                    const SizedBox(height: 20),

                    CustomButton(Text: "Add Credit/debit Card",textColor: AppColors.whiteColor,buttonColor: AppColors.primaryColor,)

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget spacing(){
    return SizedBox(height: 10);
  }

}

