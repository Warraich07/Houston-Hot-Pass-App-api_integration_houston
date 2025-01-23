import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../constants/app_colors.dart';

class CustomDialogBox extends StatefulWidget {

  final String titleText;
  final String text;
  final double height;
  final String image;
  final String buttonText;
  final Function()? onTap;
  final Function()? onCloseTap;
  final double width;
  final double buttonWidth;
  final Color? backGroundColor;
  final Color? buttonColor;
  final Color? borderClr;

  const CustomDialogBox(
      {super.key,
        required this.text,
        required this.buttonText,
        required this.onTap,
        required this.width,
        required this.titleText,
        required this.height,
        required this.image,
        this.backGroundColor,
        this.buttonColor,
        this.borderClr,
        required this.buttonWidth, this.onCloseTap,
      });

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 26),
      backgroundColor:widget.backGroundColor?? const Color(0xffFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //this right here
      child: Stack(
        children: [
          SizedBox(
            height: widget.height,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.image,
                      height: 119,
                      width: 125,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.titleText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Regular",
                          fontWeight: FontWeight.w800,
                          fontSize: 35,
                          height: 1,
                          color: Color(0xff333333)),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 75.w,
                      child: Text(
                        widget.text,
                        maxLines: 20,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.grey.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                        height: 10
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: CustomFilledButton(
                    //     onTap: widget.onTap,
                    //     buttonText: widget.buttonText,
                    //     width: widget.buttonWidth,
                    //     height: 50,
                    //     buttonClr: widget.buttonColor,
                    //     borderClr: widget.borderClr,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap:widget.onCloseTap?? () {
                Get.back();
              },
              child: Image.asset("assets/icons/Cancel.png",scale: 4.0,),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog {
  static Future<dynamic> confirmationDialog(
      {required BuildContext context,
        required String title,
        required String description,
        required VoidCallback? btnYesPressed,
        required VoidCallback? btnNoPressed}) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0)), //this right here
          child: Container(
            height: 180,
            width: 300,

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child:  Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15),
                  child: Text(
                      description,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15)),
                ),
                Spacer(),
                Divider(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:btnYesPressed??  () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 138,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0), // Adjust as needed
                              bottomRight: Radius.circular(20.0), // Adjust as needed
                            ),
                            color: Colors.white
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap:btnNoPressed??  () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 138,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0), // Adjust as needed
                              bottomRight: Radius.circular(20.0), // Adjust as needed
                            ),
                            color: Colors.white
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "No",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  // static Future<dynamic> requiredPasswordDialog({
  //   required BuildContext context,
  //   required VoidCallback? btnYesPressed,
  // }) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           final TextEditingController requiredPasswordController =
  //           TextEditingController();
  //
  //           return AlertDialog(
  //             content: SizedBox(
  //               height: 25.h,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     decoration:  BoxDecoration(
  //                       borderRadius: BorderRadius.only(
  //                           topRight: Radius.circular(10),
  //                           topLeft: Radius.circular(10)),
  //                       color: AppColors.primaryColor,
  //                     ),
  //                     height: 5.h,
  //                   ),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 4),
  //                           child: FittedBox(
  //                             fit: BoxFit.contain,
  //                             child: Text(
  //                               'Please enter your password',
  //                               // 'Are you sure you want to apply this class',
  //                               style: const TextStyle(
  //                                   fontSize: 12, fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         Container(
  //                           height: 5.h,
  //                           width: 64.w,
  //                           decoration: const BoxDecoration(),
  //                           child: Center(
  //                             child: Padding(
  //                               padding: const EdgeInsets.only(
  //                                   left: 15, right: 5, top: 3, bottom: 3),
  //                               child: TextField(
  //                                 style: const TextStyle(
  //                                   fontSize: 17,
  //                                 ),
  //                                 controller: requiredPasswordController,
  //                                 cursorColor:Colors.black,
  //                                 decoration: InputDecoration(
  //                                   focusedBorder: OutlineInputBorder(
  //                                       borderSide:
  //                                       BorderSide(color: Colors.black)),
  //                                   hintText: 'Password',
  //                                   hintStyle: const TextStyle(
  //                                       color: Colors.black, fontSize: 13),
  //                                   enabledBorder: OutlineInputBorder(
  //                                       borderSide: BorderSide(
  //                                           color:
  //                                           Colors.grey.withOpacity(0.3))),
  //                                   contentPadding: const EdgeInsets.only(
  //                                       left: 8.0, bottom: 12.0, top: 5.0),
  //                                   border: InputBorder.none,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Expanded(
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 8.0),
  //                                 child: ElevatedButton(
  //                                   style: ElevatedButton.styleFrom(
  //                                     elevation: 2,
  //                                     fixedSize: Size(100.w, 5.h),
  //                                   ),
  //                                   onPressed: btnYesPressed,
  //                                   child: const Center(
  //                                     child: Text(
  //                                       'oK',
  //                                       style: TextStyle(
  //                                         fontSize: 15,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             backgroundColor: Colors.white,
  //             elevation: 0,
  //             contentPadding: EdgeInsets.zero,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //           );
  //         });
  //       });
  // }

  // TODO: show success dialog

  static Future<dynamic> showErrorDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
    int? maxLine,
    dynamic Function()? onTap,
    String? buttonText,
    bool showTitle=false,
    String? iconPath
  }) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0)), //this right here
          child: Container(
            height:380,
            width: 100.w,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.whiteColor,width: 2.7),

            ),
            child: Column(
              children: [

               SizedBox(height: 50,),
                Image.asset(
                 iconPath?? AppIcons.errorIcon,
                  scale: 4.6,
                ),
                SizedBox(height: 10,),
                // const Spacer(),
                showTitle? Text(
                  title,
                  style:  TextStyle(fontSize: 22,height: 1.2, fontFamily: "bold",color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ):Container(),
                showTitle? SizedBox(height: 10):Container(),
                SizedBox(height: 10,),
                Text(
                  description!,
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
                    onTap: onTap??(){
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
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                      ),
                      child: Center(
                          child: Text(buttonText??"Back",
                              style:  TextStyle(
                                  color: AppColors.primaryColor,


                                  fontSize: 16,
                                  fontFamily: "Bold"))),
                    )),
                SizedBox(height: 15),
                // widget.newButton==true?GestureDetector(
                //   onTap: () {
                //     Get.to(());
                //   },
                //   child: Container(
                //     height: 55,
                //     width: 90.w,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: AppColors.whiteColor,
                //     ),
                //     child: Center(
                //         child: Text(widget.secondButtonName.toString(),
                //             style:  TextStyle(
                //                 color: AppColors.primaryColor,
                //
                //
                //                 fontSize: 16,
                //                 fontFamily: "Bold"))),
                //   ),
                // ):SizedBox.shrink(),






              ],
            ),

          ),
        )
    );
  }


  static Future<dynamic> showPopUpDialog({

    String? description = 'Something went wrong',
    int? maxLine,
    dynamic Function()? onTap,
    dynamic Function()? onTapCancel,
    String? buttonText
  }) {
    return Get.dialog(
        Dialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(
          //         20.0)), //this right here
          child: Container(
            height:380,
            width: 100.w,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.whiteColor,width: 2.7),

            ),
            child:  Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  IconButton(
                    onPressed: onTapCancel,
                    icon: Icon(Icons.cancel,color: Colors.white,),
                  )
                ],),
                Image.asset(
                  AppIcons.errorIcon,
                  scale: 4.6,
                ),
                Spacer(),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Text(
                        textAlign: TextAlign.center,
                        description??'',
                        // maxLines: maxLine??2,
                        style: TextStyle(

                            color: Colors.white,
                            fontSize: 15)),
                  ),
                ),
                Spacer(),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                  child: ZoomTapAnimation(
                    onTap: onTap??() {
                      Get.back();
                    },
                    onLongTap: () {},
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
                          child: Text(buttonText??'Back',
                              style: TextStyle().copyWith(color: AppColors.primaryColor)),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      barrierDismissible: false,
    );
  }

  static Future<dynamic> profileCompleted({
    String title = 'Error',
    String? description = 'Something went wrong',
    int? maxLine,
    dynamic Function()? onTap,
    String? buttonText,
    bool showTitle=false,
    String? iconPath
  }) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0)), //this right here
          child: Container(
            height:380,
            width: 100.w,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.whiteColor,width: 2.7),

            ),
            child: Column(
              children: [

                SizedBox(height: 50,),
                Image.asset(
                  iconPath?? AppIcons.successIcon,
                  scale: 4.6,
                ),
                const Spacer(),
                showTitle? Text(
                  title,
                  style:  TextStyle(fontSize: 22,height: 1.2, fontFamily: "bold",color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ):Container(),
                showTitle? SizedBox(height: 10):Container(),
                Text(
                  description!,
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
                    onTap: onTap??(){
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
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                      ),
                      child: Center(
                          child: Text(buttonText??"Continue",
                              style:  TextStyle(
                                  color: AppColors.primaryColor,


                                  fontSize: 16,
                                  fontFamily: "Bold"))),
                    )),
                SizedBox(height: 15),
                // widget.newButton==true?GestureDetector(
                //   onTap: () {
                //     Get.to(());
                //   },
                //   child: Container(
                //     height: 55,
                //     width: 90.w,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: AppColors.whiteColor,
                //     ),
                //     child: Center(
                //         child: Text(widget.secondButtonName.toString(),
                //             style:  TextStyle(
                //                 color: AppColors.primaryColor,
                //
                //
                //                 fontSize: 16,
                //                 fontFamily: "Bold"))),
                //   ),
                // ):SizedBox.shrink(),






              ],
            ),

          ),
        )
    );
  }

  static Future<dynamic> showProfileCompleteDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
    int? maxLine,
    dynamic Function()? onTap,
    String? buttonText
  }) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0)), //this right here
          child: Container(
            height: 350,
            width: 300,

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child:  Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //  title,
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20),
                // ),
                Spacer(),
                Container(
                    height: 100,
                    width: 100,
                    // color: Colors.green,
                    child: Image.asset('assets/houston_app_icon/houston_hot_pass_logo.jpg',fit: BoxFit.cover,)),
                Spacer(),
                Center(
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: 15),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                        textAlign: TextAlign.center,
                        description??'',
                        // maxLines: maxLine??2,
                        style: TextStyle(

                            color: Colors.black,
                            fontSize: 15)),
                  ),
                ),
                Spacer(),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                  child: ZoomTapAnimation(
                    onTap: onTap??() {
                      Get.back();
                    },
                    onLongTap: () {},
                    enableLongTapRepeatEvent: false,
                    longTapRepeatDuration: const Duration(milliseconds: 100),
                    begin: 1.0,
                    end: 0.93,
                    beginDuration: const Duration(milliseconds: 20),
                    endDuration: const Duration(milliseconds: 120),
                    beginCurve: Curves.decelerate,
                    endCurve: Curves.fastOutSlowIn,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(buttonText??'Sign In',
                              style: TextStyle().copyWith(color: Colors.white)),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
    );
  }

  // static Future<dynamic> showSuccessDialog({description = '',Function()? onTap}) {
  //   return Get.dialog(
  //       Dialog(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(
  //                 20.0)), //this right here
  //         child: Container(
  //           height: 180,
  //           width: 300,
  //
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20)
  //           ),
  //           child:  Column(
  //             mainAxisAlignment:
  //             MainAxisAlignment.center,
  //             children: [
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 'Success',
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 20),
  //               ),
  //               Spacer(),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(
  //                     horizontal: 15),
  //                 child: Text(
  //                     description!,
  //                     maxLines: 2,
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 15)),
  //               ),
  //               Spacer(),
  //               Divider(height: 1),
  //               GestureDetector(
  //                 onTap:onTap??  () {
  //                   Get.back();
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   width: 300,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.only(
  //                         bottomLeft: Radius.circular(20.0), // Adjust as needed
  //                         bottomRight: Radius.circular(20.0), // Adjust as needed
  //                       ),
  //                       color: Colors.white
  //                   ),
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     "OK",
  //                     style: TextStyle(
  //                         color: Colors.green,
  //                         fontSize: 20),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //   );
  // }

  static void loginDialog() {
    Get.dialog(
      Dialog(
        child: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              if (Get.isDialogOpen!) Get.back();
                            },
                            child: const Icon(
                              Icons.cancel_outlined,
                              size: 20,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'Please sign In',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          elevation: 2,
                          backgroundColor: AppColors.primaryColor,
                          side:  BorderSide(
                              color: AppColors.primaryColor, width: 1.5),
                          fixedSize: const Size(80, 12),
                        ),
                        onPressed: () {
                          if (Get.isDialogOpen!) Get.back();
                        },
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Center(
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Colors.deepOrangeAccent),
                const SizedBox(height: 8),
                Text(message ?? 'Loading...'),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}

