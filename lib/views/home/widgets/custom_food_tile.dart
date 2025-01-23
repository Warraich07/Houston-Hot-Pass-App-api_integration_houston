import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:houstan_hot_pass/views/home/offer_details/offer_details.dart';
import 'package:houstan_hot_pass/views/home/redeem_offers_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../app_widgets/shimmer_single_widget.dart';

class CustomFoodTile extends StatefulWidget {
   CustomFoodTile({super.key,this.foodTileHeading,this.restaurantName,this.saleOnFood,this.imagePath,this.onTapRedeemNow,this.showTitle,this.fontWeightTitle,this.showRedeemNowButton});
  final String? foodTileHeading;
  final String? restaurantName;
  final String? saleOnFood;
  final String? imagePath;
  dynamic Function()? onTapRedeemNow;
   final bool? showTitle;
   final bool? showRedeemNowButton;
   FontWeight? fontWeightTitle;
  @override
  State<CustomFoodTile> createState() => _CustomFoodTileState();
}

class _CustomFoodTileState extends State<CustomFoodTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: SizedBox(
            height: 300,
            child:
            // Image.network(
            //   widget.imagePath ?? '',
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            //   // loadingBuilder: (context, child, loadingProgress) {
            //   //   if (loadingProgress == null){
            //   //     return child;
            //   //   } else{
            //   //     return Center(child: ShimmerSingleWidget(shimmerWidth: 45.w,));
            //   //   }
            //   // },
            //   errorBuilder: (context, error, stackTrace) {
            //     return Image.asset(
            //       "assets/app_images/upload_image.png",
            //       fit: BoxFit.cover,
            //       width: double.infinity,
            //     );
            //   },
            // ),
            CachedNetworkImage(
              memCacheWidth: 1000,
              memCacheHeight: 1000,
              maxHeightDiskCache: 1000,
              maxWidthDiskCache: 1000,
              imageUrl:widget.imagePath??'',
                  placeholder: (context, url) =>
                      Center(
                          child: ShimmerSingleWidget(shimmerWidth: 45.w,)),

                  errorWidget: (context, url,
                      error) =>
                      Image.asset(
                        "assets/app_images/upload_image.png",
                      ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          ),
        ),
       widget.showRedeemNowButton==false?Container() :Positioned(
            top: 20,
            left: 10,
            child: ZoomTapAnimation(
              onTap: widget.onTapRedeemNow,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(color: Color(0xffDB8423)),
                child: Center(
                  child: Text(
                   widget.foodTileHeading?? "Redeem Now",
                    style: TextStyle(
                        fontFamily: 'fontSpringExtraBold',
                        color: AppColors.whiteColor,
                        fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )),
        Positioned(
          bottom: 17,
          left: 10,
          child: Container(
            width: 140,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor, // Shadow color
                  spreadRadius: 1, // The radius of the shadow
                  blurRadius: 0, // The blur effect
                  offset: const Offset(0, -5), // Offset of the shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.5,vertical: 5),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 widget.showTitle==false? Container():AppSubtitleText(Text:widget.restaurantName?? "The Curry Pizza guys",color: Colors.black,fontSize: 11,height: 1,),
                  const SizedBox(height: 4),
                  // HtmlWidget(
                  //   widget.saleOnFood??'40% Off On All Burgers',
                  //   // maxLines: 2,
                  //   textStyle: const TextStyle(fontFamily: "regular",
                  //       fontSize: 9,
                  //       color: Colors.black,
                  //       height: 1.1),
                  //   // overflow: TextOverflow.ellipsis,maxLines: 3,
                  // ),
                  Text(widget.saleOnFood??'40% Off On All Burgers',
                    maxLines: 2,
                    style: TextStyle(fontFamily: "regular",
                        fontSize: 9,
                        fontWeight:widget.fontWeightTitle?? FontWeight.normal,
                        color: Colors.black,
                        height: 1.1),)

                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
