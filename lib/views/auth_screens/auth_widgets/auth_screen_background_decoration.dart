import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';

import '../../../constants/app_colors.dart';

class AuthCustomBackGround extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const AuthCustomBackGround({
    Key? key,
    required this.child,
    this.width = 100,
    this.height = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.primaryColor,
      body:Stack(
        children: [
          Positioned(right: 37,
            top: 50,
            child: Image.asset(
              AppImages.authBackgroundImage,scale: 3.5,
              fit: BoxFit.fill,
            ),
          ),
          child,
        ],
      ),
    );

  }
}
