import 'package:flutter/material.dart';

///---------App Colors

// class AppColors {
//   static const Color primaryColor = Color(0xff008F39);
//   static const Color secondaryColor = Color(0xff000000);
//   static const Color secondaryColorLight = Color(0xffFCBC09);
//   static const Color scaffoldColor = Color(0xffffffff);
//   static const Color buttonColor = Color(0xff008F39);
//   static const Color textFieldColor = Color(0xffE6E6E6);
//   static const Color greyText = Color(0xff6F767E);
// }

///---------App Texts
TextStyle headingLarge = const TextStyle(
    fontSize: 30,
    color: Colors.black,
    fontFamily: 'InterBold',
    fontWeight: FontWeight.w700);
TextStyle headingMedium = const TextStyle(
    fontSize: 18, color: Colors.black, fontFamily: 'InterSemiBold');
TextStyle headingSmall = const TextStyle(
    fontSize: 15, color: Colors.black, fontFamily: 'InterSemiBold');
TextStyle bodyLarge = const TextStyle(
    fontSize: 16, color: Colors.black, fontFamily: 'InterRegular');
TextStyle bodyNormal = const TextStyle(
    fontSize: 15, color: Colors.black, fontFamily: 'InterRegular');
TextStyle authSubHeading = const TextStyle(
    fontSize: 15, color: Colors.black54, fontFamily: 'InterMedium');
TextStyle bodySmall = const TextStyle(
    fontSize: 12, color: Colors.black, fontFamily: 'InterRegular');

TextStyle title = const TextStyle(
    fontSize: 12, color: Colors.black12, fontFamily: 'InterRegular');
TextStyle hintText = const TextStyle(
    fontSize: 12, color: Colors.black26, fontFamily: 'InterRegular');

final LANG_CODE = ValueNotifier("en");