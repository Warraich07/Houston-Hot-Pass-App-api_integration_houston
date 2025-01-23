import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../app_widgets/app_subtitle_text.dart';
import '../../../../constants/app_colors.dart';

class CustomerServiceButton extends StatefulWidget {
  const CustomerServiceButton(
      {super.key,
        required this.title,
        required this.onTap,
        this.textColor,
        required this.image,
        this.scale, required this.subTitle});
  final String image;
  final String title;
  final String subTitle;
  final Function() onTap;
  final Color? textColor;
  final double? scale;

  @override
  State<CustomerServiceButton> createState() => _CustomerServiceButtonState();
}

class _CustomerServiceButtonState extends State<CustomerServiceButton> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          height: 59,
          width: 90.w,
          decoration:       BoxDecoration(
            color: AppColors.primaryColor,


          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      scale: widget.scale??4,


                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSubtitleText(Text: widget.subTitle,fontSize: 10,color: AppColors.whiteColor,),
                    Text(widget.title,
                        style: TextStyle(
                            color: widget.textColor ?? Colors.white,
                            fontSize: 14,
                            fontFamily: "medium")),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
