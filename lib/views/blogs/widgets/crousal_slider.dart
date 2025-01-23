import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/custom_listview.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'dart:ui'; // For the BackdropFilter

import '../../../app_widgets/app_button.dart';
import '../../../app_widgets/bold_text.dart';
import '../../../app_widgets/shimmer_single_widget.dart';
import '../../../constants/app_colors.dart';
import '../blog_details.dart';

class CrousalSlider extends StatefulWidget {
   CrousalSlider(
      {super.key, this.height, this.aspectRatio, this.showGestureButtons,this.featuredImagesList,required this.showHeadingWidgets,required this.imagesHeadingList,required this.isFeaturedBlogs});
  List<String>? featuredImagesList;
  List<String>? imagesHeadingList;
  bool showHeadingWidgets;
  bool isFeaturedBlogs;


  @override
  State<CrousalSlider> createState() => _CrousalSliderState();
  final double? height;
  final double? aspectRatio;
  final bool? showGestureButtons;
}

class _CrousalSliderState extends State<CrousalSlider> {
  DateTime? selectedDate;
  List<String> imagePaths = [
    AppImages.foodTileImg,
    'assets/app_images/food_img2.png',
    'assets/app_images/food_img.png'
  ];
  Future<void> selectDate(BuildContext context) async {
    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
          onBackground: Colors.white,
          onSecondary: Colors.white,
          primary: Colors.white,
          onPrimary: Colors.black,
          onSurface: Colors.white,
          surface: AppColors.primaryColor),
    );

    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  List<String> image = [
    "assets/app_images/food_img.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
    "assets/app_images/food_img2.png",
  ];
  String selectedImage = "";
  int activeIndex = 0;
  double pageOffset = 0.0;
  void initState() {
    super.initState();
    imagePaths=widget.featuredImagesList!;
    selectedImage=imagePaths.first;
    setState(() {

    });
  }
OffersController _offersController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  height: widget.height ?? 240,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  aspectRatio: widget.aspectRatio ?? 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  onScrolled: (offset) {
                    setState(() {
                      pageOffset = offset!;
                    });
                  },
                ),
                itemCount: widget.featuredImagesList!.length,
                carouselController: buttonCarouselController,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap:(){
                            if(widget.isFeaturedBlogs==true){
                              Get.to(()=>BlogDetailsScreen(
                                offer: _offersController.featuredBlogsList[index].offer==null?'null':'',
                                offerCreatedAt:_offersController.featuredBlogsList[index].offer==null? _offersController.formatDate(_offersController.featuredBlogsList[index].createdAt.toString()): _offersController.formatDate(_offersController.featuredBlogsList[index].offer!.createdAt.toString()),
                                htmWidgetDescription: _offersController.featuredBlogsList[index].description,
                                canRedeemAgain: true,
                                restaurantId: _offersController.featuredBlogsList[index].restuarant.id.toString(),
                                offerId:_offersController.featuredBlogsList[index].offer==null?'': _offersController.featuredBlogsList[index].offer!.id.toString(),
                                imagePath:_offersController.featuredBlogsList[index].offer==null?_offersController.featuredBlogsList[index].images[1].toString(): _offersController.featuredBlogsList[index].offer!.image.toString(),
                                validTill:_offersController.featuredBlogsList[index].offer==null?'': _offersController.formatDate(_offersController.featuredBlogsList[index].offer!.expirationDate.toString()),
                                foodTitle: _offersController.featuredBlogsList[index].restuarant.name,
                                saleOnFood: _offersController.featuredBlogsList[index].title,
                                tagsList:_offersController.featuredBlogsList[index].offer==null?[]: _offersController.featuredBlogsList[index].offer!.tags,
                                restaurantLocation: _offersController.featuredBlogsList[index].restuarant.location.title.toString(),
                                // termsAndConditions: _offersController.blogsList[index].termsConditions.toString(),
                                featuredImagesList: _offersController.featuredBlogsList[index].images,
                                lat: double.parse(_offersController.featuredBlogsList[index].restuarant.location.latitude),
                                long: double.parse(_offersController.featuredBlogsList[index].restuarant.location.longitude),
                                foodTitleToRedeem:_offersController.featuredBlogsList[index].offer==null?'': _offersController.featuredBlogsList[index].offer!.title,
                                foodDescriptionToRedeem:_offersController.featuredBlogsList[index].offer==null?'': _offersController.featuredBlogsList[index].offer!.description,
                              ));
                        }else{

                            }


                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 550,
                          width: 90.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            // memCacheWidth: 150,
                            // memCacheHeight: 150,
                            // maxHeightDiskCache: 150,
                            // maxWidthDiskCache: 150,
                            imageUrl:widget.featuredImagesList![index],
                            placeholder: (context, url) =>
                                Center(
                                    child: ShimmerSingleWidget(shimmerWidth: 100.w,)),
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
                          ),
                        ),
                        widget.showHeadingWidgets==true?  Positioned(
                                          left: 10,
                                          top: 10,
                                          child: ZoomTapAnimation(
                                            child: CustomButton(
                                              Text: "Featured",
                                              textColor: AppColors.whiteColor,
                                              buttonColor: AppColors.primaryColor,
                                              width: 100,
                                              height: 30,
                                            ),
                                          ),
                                        ):Container(),
                        widget.showHeadingWidgets==true?  Positioned(
                                          bottom: 17,
                                          left: 10,
                                          child: Container(
                                            width: 80.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.primaryColor,
                                                  spreadRadius: 1,
                                                  blurRadius: 0,
                                                  offset: Offset(0, -5),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 10),
                                              child: BoldText(

                                                 height: 1.2,
                                                Text:
                                                widget.imagesHeadingList![index],TextALign: TextAlign.center,
                                                color: AppColors.primaryColor,
                                                fontSize: 17,
                                                maxLines: 2,

                                              ),
                                            ),
                                          ),
                                        ):Container(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                widget.showGestureButtons == true
                    ? Row(
                        children: [
                          ZoomTapAnimation(
                            onTap: () {
                              buttonCarouselController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear);
                              setState(() {

                                if(activeIndex==0){
                                      print('first index');
                                }else{
                                  activeIndex = (activeIndex - 1 + widget.featuredImagesList!.length) %
                                      widget.featuredImagesList!.length;
                                }
                              });
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration:
                                  BoxDecoration(
                                      color: activeIndex!=0?AppColors.whiteColor: AppColors.primaryColor,
                                      border: Border.all(
                                          color: AppColors.primaryColor, width: 2)),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20,
                                  color:activeIndex!=0?AppColors.primaryColor: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ZoomTapAnimation(
                            onTap: () {
                              buttonCarouselController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear);
                              setState(() {

                                if(activeIndex==widget.featuredImagesList!.length-1){
                                  print('last index');
                                }else{
                                  activeIndex = (activeIndex + 1) % widget.featuredImagesList!.length;
                                  print(activeIndex);
                                }

                              });
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: activeIndex==widget.featuredImagesList!.length-1?AppColors.primaryColor: AppColors.whiteColor,
                                  border: Border.all(
                                      color: AppColors.primaryColor, width: 2)),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color:activeIndex==widget.featuredImagesList!.length-1?AppColors.whiteColor: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                        ],
                      )
                    : SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    widget.featuredImagesList!.length,
                    (index) => Container(
                      height: 4,
                      width: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: index == activeIndex
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  }

}
