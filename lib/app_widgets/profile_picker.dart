import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';


import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_icons.dart';
import '../controllers/auth_controller.dart';

class ProfilePicker extends StatefulWidget {
  const ProfilePicker({super.key, this.forMyProfile,this.imagePath});
  final String? imagePath;
  @override
  State<ProfilePicker> createState() => _ProfilePickerState();
  final bool?forMyProfile;
}

class _ProfilePickerState extends State<ProfilePicker> {
  // Controller
  final AuthController _authController=Get.find();
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color:widget.forMyProfile==false? AppColors.whiteColor:AppColors.primaryColor,width: 1.5),
                      color: widget.forMyProfile==false?AppColors.primaryColor:AppColors.whiteColor, shape: BoxShape.circle),
                  child: image != null
                      ? ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image(
                        image: FileImage(File(image!.path)),
                        fit: BoxFit.cover,
                        height: Get.height,
                        width: Get.width,
                      ))
                      :
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      // memCacheWidth: 150,
                      // memCacheHeight: 150,
                      // maxHeightDiskCache: 150,
                      // maxWidthDiskCache: 150,
                      imageUrl:widget.imagePath??'',
                      placeholder: (context, url) =>
                          Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )),
                      errorWidget: (context, url,
                          error) =>
                          Image.asset(
                            widget.imagePath??"assets/app_images/upload_image.png",scale: 5.3,
                            color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
                    
                          ),
                      fit: BoxFit.cover,
                      scale:20 ,
                    ),
                  )
                  // Image.asset(
                  //   widget.imagePath??"assets/app_images/upload_image.png",scale: 5.3,
                  //   color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
                  //
                  // ),
                ),
                Positioned(
                  bottom: 5,
                  right: 3,
                  child: GestureDetector(
                    onTap: () async {
                      print(_authController.imagePath.value);
                      image = await picker.pickImage(
                          source: ImageSource.gallery);
                      _authController.updateImagePath(image!.path.toString());
                      _authController.completeProImagePath(image!.path.toString());
                      setState(() {});
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Icon(
                          CupertinoIcons.camera_fill,
                          size: 16,
                          color:widget.forMyProfile==false? AppColors.primaryColor:AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            
          ),
          SizedBox(height:8),
          BoldText(Text: "Upload Image",color: widget.forMyProfile==true?Colors.black:AppColors.whiteColor)
        ],
      );




    }

  }

