import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/app_subtitle_text.dart';
import '../../../app_widgets/shimmer_single_widget.dart';

class RedeemedOffersTile extends StatefulWidget {
  RedeemedOffersTile({super.key,this.foodTitle,this.saleOnFood,this.redeemedDateAndTime,this.imagePath,this.redeemedButtonText});
  String? foodTitle;
  String? saleOnFood;
  String? redeemedDateAndTime;
  String? imagePath;
  String? redeemedButtonText;

  @override
  State<RedeemedOffersTile> createState() => _RedeemedOffersTileState();
}

class _RedeemedOffersTileState extends State<RedeemedOffersTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  height: 130,
                  width: 170,
                  child: CachedNetworkImage(
                    // memCacheWidth: 150,
                    // memCacheHeight: 150,
                    // maxHeightDiskCache: 150,
                    // maxWidthDiskCache: 150,
                    imageUrl:widget.imagePath??'',
                    placeholder: (context, url) =>
                        Center(
                            child: ShimmerSingleWidget(shimmerWidth: 50.w,)),
                    errorWidget: (context, url,
                        error) =>
                        Image.asset(
                          AppImages.foodTileImg,
                          // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
                            fit: BoxFit.cover,
                        ),
                    fit: BoxFit.cover,
                    scale:20 ,
                    // width: double.infinity,
                    // height: 250,
                  )),
              SizedBox(width: 10),
              CustomButton(Text: widget.redeemedButtonText??'',width: 100,height: 33,buttonColor: Colors.grey,textColor: AppColors.whiteColor,textSize: 13,)

            ],
          ),

        ),
        Positioned(
          top: 12,
          right: 5,
          left: 120,
          child: Container(
            width: 70.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 2.3),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor, // Shadow color
                  spreadRadius: 0, // The radius of the shadow
                  blurRadius: 0, // The blur effect
                  offset: Offset(4, -4), // Offset of the shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText(
                    Text: widget.foodTitle??"The Curry Pizza guys",height: 1.1,
                    color: Colors.black,fontSize: 12,
                    maxLines: 2,
                  ),
                  SizedBox(height: 2),
                  Text(

                    overflow: TextOverflow.ellipsis,
                    widget.saleOnFood??"The Curry Pizza guys",
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: "regular",
                      fontSize: 9,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3),
                  AppSubtitleText(Text: widget.redeemedDateAndTime??"The Curry Pizza guys",color: AppColors.primaryColor,fontSize: 9),
                ],
              ),
            ),
          ),

        ),


      ],
    );
  }
}
