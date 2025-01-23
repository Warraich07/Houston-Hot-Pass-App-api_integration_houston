import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';



class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog(
      {super.key,
      this.img,
      this.heading,
       this.subHeading,
       this.buttonName,
       this.onTapped,

        this.height, this.newButton, this.secondButtonName,
      });

  final String?img;
  final String?heading;
  final String?subHeading;
  final String? buttonName;
  final String? secondButtonName;
  final double? height;
  final Function()? onTapped;
  final bool? newButton;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}


class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        child: Container(
          height:widget.height ??380,
          width: 100.w,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.primaryColor,
            border: Border.all(color: AppColors.whiteColor,width: 2.7),

          ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.white,
                        ))),
                const Spacer(),
                Image.asset(
                   widget.img.toString(),
                  scale: 4.6,
                ),
                const Spacer(),
                Text(
                  widget.heading.toString(),
                  style:  TextStyle(fontSize: 22,height: 1.2, fontFamily: "bold",color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.subHeading.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.4,
                      fontSize: 12,
                      fontFamily: "Bold",
                      color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),

                const Spacer(),
               ZoomTapAnimation(
                      onTap: widget.onTapped,
                      enableLongTapRepeatEvent: false,
                      longTapRepeatDuration: const Duration(milliseconds: 100),
                      begin: 1.0,
                      end: 0.93,
                      beginDuration: const Duration(milliseconds: 20),
                      endDuration: const Duration(milliseconds: 120),
                      beginCurve: Curves.decelerate,
                      endCurve: Curves.fastOutSlowIn,
                      child: Container(
                        height: 55,
                        width: 90.w,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                        ),
                        child: Center(
                            child: Text(widget.buttonName.toString(),
                                style:  TextStyle(
                                  color: AppColors.primaryColor,


                                    fontSize: 16,
                                    fontFamily: "Bold"))),
                      )),
                SizedBox(height: 15),
           widget.newButton==true?GestureDetector(
             onTap: () {
               Get.to(());
             },
             child: Container(
                    height: 55,
                    width: 90.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.whiteColor,
                    ),
                    child: Center(
                        child: Text(widget.secondButtonName.toString(),
                            style:  TextStyle(
                                color: AppColors.primaryColor,


                                fontSize: 16,
                                fontFamily: "Bold"))),
                  ),
           ):SizedBox.shrink(),






              ],
            ),

        ),
      ),
    );
  }
}


class CustomAlertDialogForExiting extends StatefulWidget {
  const CustomAlertDialogForExiting(
      {super.key,
        this.img,
        this.heading,
        this.subHeading,
        this.buttonName,
        this.onTapped,

        this.height, this.newButton, this.secondButtonName,
      });

  final String?img;
  final String?heading;
  final String?subHeading;
  final String? buttonName;
  final String? secondButtonName;
  final double? height;
  final Function()? onTapped;
  final bool? newButton;

  @override
  State<CustomAlertDialogForExiting> createState() => _CustomAlertDialogForExitingState();
}


class _CustomAlertDialogForExitingState extends State<CustomAlertDialogForExiting> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        child: Container(
          height:widget.height ??380,
          width: 100.w,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.primaryColor,
            border: Border.all(color: AppColors.whiteColor,width: 2.7),

          ),
          child: Column(
            children: [

              const Spacer(),
              Image.asset(
                widget.img.toString(),
                scale: 4.6,
              ),
              const Spacer(),
              Text(
                widget.heading.toString(),
                style:  TextStyle(fontSize: 22,height: 1.2, fontFamily: "bold",color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                widget.subHeading.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 12,
                  fontFamily: "Bold",
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZoomTapAnimation(
                      onTap: widget.onTapped,
                      enableLongTapRepeatEvent: false,
                      longTapRepeatDuration: const Duration(milliseconds: 100),
                      begin: 1.0,
                      end: 0.93,
                      beginDuration: const Duration(milliseconds: 20),
                      endDuration: const Duration(milliseconds: 120),
                      beginCurve: Curves.decelerate,
                      endCurve: Curves.fastOutSlowIn,
                      child: Container(
                        height: 55,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                        child: Center(
                            child: Text(widget.buttonName.toString(),
                                style:  TextStyle(
                                    color: AppColors.primaryColor,


                                    fontSize: 16,
                                    fontFamily: "Bold"))),
                      )),
                  ZoomTapAnimation(
                      onTap: () {
                      Get.back();
                      },
                      enableLongTapRepeatEvent: false,
                      longTapRepeatDuration: const Duration(milliseconds: 100),
                      begin: 1.0,
                      end: 0.93,
                      beginDuration: const Duration(milliseconds: 20),
                      endDuration: const Duration(milliseconds: 120),
                      beginCurve: Curves.decelerate,
                      endCurve: Curves.fastOutSlowIn,
                      child: Container(
                        height: 55,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                        child: Center(
                            child: Text("No",
                                style:  TextStyle(
                                    color: AppColors.primaryColor,


                                    fontSize: 16,
                                    fontFamily: "Bold"))),
                      )),

                ],
              ),
              SizedBox(height: 15),
              widget.newButton==true?GestureDetector(
                onTap: () {
                  Get.to(());
                },
                child: Container(
                  height: 55,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.whiteColor,
                  ),
                  child: Center(
                      child: Text(widget.secondButtonName.toString(),
                          style:  TextStyle(
                              color: AppColors.primaryColor,


                              fontSize: 16,
                              fontFamily: "Bold"))),
                ),
              ):SizedBox.shrink(),






            ],
          ),

        ),
      ),
    );
  }
}