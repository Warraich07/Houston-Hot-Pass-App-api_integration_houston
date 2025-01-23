import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:sizer/sizer.dart';

class Locationbutton extends StatefulWidget {
   Locationbutton({super.key,this.address});
    String? address;
  @override
  State<Locationbutton> createState() => _LocationbuttonState();
}

class _LocationbuttonState extends State<Locationbutton> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 57,
      width: 90.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
              color: AppColors.primaryColor, width: 1.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Image.asset(AppIcons.locationIcon,
                color: AppColors.primaryColor, scale: 3),
            const SizedBox(width: 10),
            Expanded(
                child: AppSubtitleText(
                  TextALign: TextAlign.center,
                  Text:widget.address?? "18420 FM 529 Road Suite 600 Cypress, TX 77s433",height: 1.1,
                  color: AppColors.primaryColor,
                  fontSize: 13,
                  maxLines: 3,
                )),
            SizedBox(width: 5),
            Image.asset(
              AppIcons.globLocationIcon,
              scale: 3.5,
            )
          ],
        ),
      ),
    );
  }
}
