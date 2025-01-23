import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_datePicker.dart';
import 'package:houstan_hot_pass/app_widgets/custom_dropdown.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/views/auth_screens/auth_widgets/auth_screen_background_decoration.dart';
import 'package:intl/intl.dart';

import '../../../app_widgets/alertbox.dart';
import '../sign_in/sign_in_screen.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  DateTime? selectedDate = DateTime.now();
  DateTime startDateTime = DateTime.now();
  Future _selectDate(BuildContext context) async {
    final ThemeData dialogTheme = ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.light(
        primary: Colors.black, // Text color
        onPrimary: Colors.white, // Background color
      ),
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: dialogTheme,
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {});
      return picked;
    }
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCustomBackGround(
          child: CustomHorizontalPadding(
              child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomScreenTitle(screenTitle: 'Add New Card'),
            AppSubtitleText(
              Text: "Enter the following details to add new card",
              color: Colors.white.withOpacity(0.7),
            ),
            SizedBox(height: 20),
            AppSubtitleText(Text: "Card Number", color: AppColors.whiteColor),
            spacing(),
            CustomTextField(
              hintText: "0000 0000 0000",
              keyboardType: TextInputType.number,
              hintTextColor: AppColors.whiteColor.withOpacity(0.7),
            ),
            spacing(),
            AppSubtitleText(Text: "Card Name", color: AppColors.whiteColor),
            spacing(),
            CustomTextField(
                hintText: "Card Name",
                hintTextColor: AppColors.whiteColor.withOpacity(0.7)),
            spacing(),
            AppSubtitleText(Text: "Expiry Date", color: AppColors.whiteColor),
            spacing(),
            GestureDetector(
              onTap: () async {
                selectedDate = await _selectDate(context);
                setState(() {});
              },
              child: DatePicker(
                  selectedDate: selectedDate,
                  text: selectedDate == null
                      ? "Enter Your Date Of Birth"
                      : DateFormat.yMMMd().format(selectedDate!)),
            ),
            spacing(),
            AppSubtitleText(Text: "CVV", color: AppColors.whiteColor),
            spacing(),
            CustomTextField(
              hintText: "000",
              hintTextColor: AppColors.whiteColor.withOpacity(0.7),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 130),
            CustomButton(Text: "Add Now",onTap: () {
              showDialog(

                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    height: 370,
                    heading: "Account created successfully",
                    subHeading: "Congratulations! Your account has been created successfully. ",
                    buttonName: "Continue",img: AppIcons.successIcon,onTapped: () {
                    Get.to(()=>SignInScreen());
                  },);
                },
              );
            }
            )
          ],
        ),
      ))),
    );
  }

  Widget spacing() {
    return SizedBox(height: 10);
  }
}
