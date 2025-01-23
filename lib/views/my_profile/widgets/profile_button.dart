import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfileButton extends StatefulWidget {
  const ProfileButton(
      {super.key,
        required this.title,
        required this.onTap,
        this.textColor,
        required this.image,
        this.scale});
  final String image;
  final String title;
  final Function() onTap;
  final Color? textColor;
  final double? scale;

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.onTap,
      child: Container(
        height: 55,
        width: 90.w,
        decoration: customShadowedDecoration(buttonColor: AppColors.whiteColor),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor, shape: BoxShape.circle),
                child: Center(
                  child: Image.asset(
                    widget.image,
                    scale: widget.scale??3.5,


                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(widget.title,
                  style: TextStyle(
                      color: widget.textColor ?? Colors.black,
                      fontSize: 15,
                      fontFamily: "medium")),
              const Spacer(),
              const Icon(CupertinoIcons.forward,size: 17,)
            ],
          ),
        ),
      ),
    );
  }
}
