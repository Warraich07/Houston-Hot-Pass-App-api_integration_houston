import 'package:flutter/cupertino.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';

BoxDecoration customShadowedDecoration({Color? buttonColor}) {
  return BoxDecoration(
    border: Border.all(color: AppColors.primaryColor, width: 2.3),
    color: buttonColor ?? AppColors.peachColor, // Use the provided color or fall back to default
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryColor, // Shadow color
        spreadRadius: 0, // The radius of the shadow
        blurRadius: 0, // The blur effect
        offset: Offset(3, 3), // Offset of the shadow
      ),
    ],
  );
}
