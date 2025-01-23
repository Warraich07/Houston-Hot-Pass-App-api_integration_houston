import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:houstan_hot_pass/controllers/home_controller.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/views/home/search_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../views/home/widgets/filtersbottomsheet.dart';

class CustomAppBarBackGround extends StatefulWidget {
  final bool showTextField;
  final bool showFiltersIcon;
  final bool? showBackButton;
  final bool? showIcon;
  final Widget? child;
  final String? screenTitle;
  final String? screenSubtitle;
  final bool? showScreenTitle;
  final bool? showScreenSubtitle;
  final Widget? textFieldWidget;
  final Widget? filtersBottomSheet;
  const CustomAppBarBackGround(
      {super.key,
      required this.showTextField,
      required this.showFiltersIcon,
      this.showBackButton,
      this.child,
      this.showIcon = true,
      this.height,
      this.screenTitle,
      this.showScreenTitle,
      this.screenSubtitle,
      this.showScreenSubtitle,
      this.textFieldWidget,
        this.filtersBottomSheet
      });

  @override
  State<CustomAppBarBackGround> createState() => _CustomAppBarBackGroundState();
  final double? height;
}

class _CustomAppBarBackGroundState extends State<CustomAppBarBackGround> {
  GeneralController generalController = Get.find();
  HomeController homeController = HomeController();
  OffersController offersController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: widget.height,
              width: 100.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.homeAppBarBackgroundImage),
                      fit: BoxFit.fill)),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: widget.child != null
                      ? Column(
                          children: [
                            Center(
                                child: widget.showIcon == true
                                    ? Image.asset(AppIcons.splashScreenIcon,
                                        scale: 12)
                                    : SizedBox.shrink()),
                            SizedBox(height: 15),
                            widget.child ?? SizedBox.shrink()
                          ],
                        )

                      : Column(
                          children: [
                            Center(
                                child: widget.showIcon == true
                                    ? Image.asset(AppIcons.splashScreenIcon,
                                        scale: 13)
                                    : SizedBox.shrink()),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: widget.showTextField == true
                                          ? widget.textFieldWidget
                                          : SizedBox.shrink(),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  widget.showFiltersIcon == true
                                      ? ZoomTapAnimation(
                                          onTap: () {
                                            homeController.filterList.clear();
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(builder:
                                                    (BuildContext context, StateSetter setState) {
                                                  return WillPopScope(
                                                    onWillPop: () async {
                                                      if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
                                                        Navigator.pop(context);
                                                      }
                                                      return false;
                                                    },
                                                    child: SafeArea(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                                          top: 40,
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(context).unfocus();
                                                          },
                                                          child: SizedBox(
                                                            height: 360,
                                                            child: BackdropFilter(
                                                              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0),),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors.grey.withOpacity(0.2),
                                                                      blurRadius: 8.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Stack(
                                                                  alignment: Alignment.topCenter,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Container(
                                                                        height: 3,
                                                                        width: 60,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.grey,
                                                                            borderRadius: BorderRadius.circular(20)),
                                                                      ),
                                                                    ),
                                                                    widget.filtersBottomSheet??Container(),

                                                                    // DestinationDialog(
                                                                    //      tappedPoint: tappedPoint, currentPosition: currentPosition!,),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                            ).then((value) {
                                              setState(() {});
                                            });
                                          },
                                          child: Image.asset(AppIcons.filtersIcon,
                                              scale: 3.7),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 55,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        widget.showBackButton == true
                            ? ZoomTapAnimation(
                                onTap: () {
                                  offersController.focusNodeForHome.unfocus();
                                  // FocusScope.of(context).unfocus();
                                  Get.back();
                                },
                                child: Image.asset(
                                  'assets/app_icons/back_button.png',
                                  scale: 4,
                                ))
                            : SizedBox.shrink(),
                        SizedBox(width: 15),
                        widget.showScreenTitle == true
                            ? BoldText(
                                Text: widget.screenTitle.toString() ?? "",
                                color: Colors.black,
                                fontSize: 20,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 10),
                    widget.showScreenSubtitle == true
                        ? AppSubtitleText(
                            Text: widget.screenSubtitle.toString() ?? "",
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
