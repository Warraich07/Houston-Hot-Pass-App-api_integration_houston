import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.Text, this.width, this.height, this.textSize, this.maxlines, this.onTap, this.buttonColor, this.buttonName, this.textColor, this.fontFamily, this.decoration});
  final String Text;
  final String? fontFamily;
  final String? buttonName;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? textSize;
  final int? maxlines;
  final Function()? onTap;
  final Color? buttonColor;
  final Decoration? decoration;


  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(

      onTap: widget.onTap,
      child:
          Container(
            height: widget.height??54,
            width: widget.width,
            decoration: widget.decoration??BoxDecoration(
                color: widget.buttonColor??AppColors.whiteColor
               ),
            child: Center(
              child: Text(
                maxLines: widget.maxlines,
                widget.Text,
                style:  TextStyle(
                    color: widget.textColor??AppColors.primaryColor,
                    fontSize: widget.textSize??17,
                    fontFamily: widget.fontFamily??"bold"),
              ),
            ),
            
          ),

    );
  }
}
