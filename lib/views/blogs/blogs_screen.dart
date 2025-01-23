import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_custom_gridview.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/app_widgets/shimmer_single_widget.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/views/blogs/blog_details.dart';
import 'package:houstan_hot_pass/views/blogs/search_blogs.dart';
import 'package:houstan_hot_pass/views/blogs/widgets/crousal_slider.dart';
import 'package:houstan_hot_pass/views/home/widgets/custom_food_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/app_bar_blogs.dart';
import '../../app_widgets/custom_appbar_background.dart';
import '../../app_widgets/custom_field .dart';
import '../../app_widgets/shimmer.dart';
import '../../controllers/home_controller.dart';
import '../home/redeem_offers_screen.dart';
import '../home/search_screen.dart';
import '../home/widgets/filtersbottomsheet.dart';
import 'blog_filters_bottom_sheet.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final OffersController _offersController=Get.find();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offersController.blogsList.clear();
    _offersController.blogsCurrentPage.value=0;
    _offersController.blogsLastPage.value=0;
    _offersController.getBlogs(false);
    _offersController.getFeaturedBlogs();
  }
  @override
  Widget build(BuildContext context) {
    RefreshController _blogsRefreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBarBlogs(
            filtersBottomSheet: BlogsFiltersBottomSheet(),
            showTextField: true,
            showFiltersIcon: true,
            height: 180,
            textFieldWidget:
            CustomTextField(
              enabled: true,
              focusNode: _offersController.focusNodeForBlogs,
              inputTextColor: Colors.black,
              onChanged: (String value) {
                // generalController.searchField.value = value.isNotEmpty;
              },
              onTap: () {

                Get.to(() => SearchBlogsScreen());
              },
              fillColor: AppColors.whiteColor,
              hintText: "Search blogs here...",
              hintTextColor:
              Colors.black.withOpacity(0.5),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Image.asset(AppIcons.searchIcon, scale: 3.5,),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CustomHorizontalPadding(
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      AppSubtitleText(
                          Text: 'Featured', color: Colors.black, fontSize: 20),
                      SizedBox(height: 10),
                     Obx(
                       ()=>_offersController.isLoading.value==true?SizedBox(
                           height: 25.h,
                           child: ShimmerSingleWidget(shimmerWidth: 90.w)):_offersController.featuredBlogsList.isEmpty?
        Center(
          child: Container(
            
              height: 20.h,
              child: Center(
                child: Text("No featured Blogs."),
              )),
        ):                CrousalSlider(
                              isFeaturedBlogs: true,
                              showHeadingWidgets: true,
                              featuredImagesList: _offersController.featuredImagesList,
                              imagesHeadingList: _offersController.featuredImagesHeadingList,
                       
                         ),
                     ),
                      SizedBox(height: 15),
                      AppSubtitleText(
                          Text: 'Recent Posts', color: Colors.black, fontSize: 20),
                      SizedBox(height: 10),
                      // Obx(
                      //     ()=>
                      //     // _offersController.isLoading.value==true?
                      //     // ShimmerGridView():
                      //     SmartRefresher(
                      //       enablePullDown: false,
                      //       enablePullUp:true,
                      //       controller: _blogsRefreshController,
                      //       onLoading: () async {
                      //         if (_offersController.blogsCurrentPage.value<_offersController.blogsLastPage.value) {
                      //           _offersController.blogsCurrentPage.value++;
                      //           // if(!_offersController.isPullUp.value){
                      //           await _offersController.getBlogs(true);
                      //           // }
                      //           setState(() {});
                      //         }
                      //         _blogsRefreshController.loadComplete();
                      //       },
                      //       child: CustomGridView(
                      //         physics: const BouncingScrollPhysics(),
                      //         itemCount: _offersController.blogsList.length,
                      //         itemBuilder: (context, index) {
                      //           return GestureDetector(
                      //             onTap: () {
                      //               Get.to(()=>BlogDetailsScreen(
                      //               ));
                      //             },
                      //             child: CustomFoodTile(
                      //               onTapRedeemNow: () {
                      //                 // Get.to(()=>RedeemOffersScreen(
                      //                 //     offerId:_offersController.blogsList[index].id.toString() ,
                      //                 //     imagePath: _offersController.blogsList[index].image.toString(),
                      //                 //     title: _offersController.blogsList[index].title.toString(),
                      //                 //     description:_offersController.blogsList[index].description.toString(),
                      //                 //     validTill:"Valid till ${_offersController.formatDate(_offersController.blogsList[index].expirationDate.toString())}"
                      //                 // ));
                      //               },
                      //               foodTileHeading: "Redeem Now",
                      //               restaurantName: "_offersController.blogsList[index].title",
                      //               saleOnFood: "_offersController.blogsList[index].description",
                      //               imagePath: "_offersController.blogsList[index].image",
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      // ),
                      Obx(
                        ()=>_offersController.isLoading.value==true?
                            SizedBox(
                              height: 25.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                ShimmerSingleWidget(shimmerWidth: 43.w),
                                ShimmerSingleWidget(shimmerWidth: 43.w),
                              ],),
                            )
                            :
    _offersController.blogsList.isEmpty?Center(
      child: Container(

          height: 20.h,
          child: Center(child: Text("No Recent Blogs."))),
    ): CustomGridView(
                              mainAxisSpacing: 10,
                            itemCount: _offersController.blogsList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    // print(_offersController.blogsList[index].images[1].toString());
                                    // print(_offersController.blogsList[index].offer!.image.toString());
                                    Get.to(()=>BlogDetailsScreen(
                                      offer: _offersController.blogsList[index].offer==null?'null':'',
                                      offerCreatedAt:_offersController.blogsList[index].offer==null? _offersController.formatDate(_offersController.blogsList[index].createdAt.toString()): _offersController.formatDate(_offersController.blogsList[index].offer!.createdAt.toString()),
                                      htmWidgetDescription: _offersController.blogsList[index].description,
                                      canRedeemAgain: true,
                                      restaurantId: _offersController.blogsList[index].restuarant.id.toString(),
                                      offerId:_offersController.blogsList[index].offer==null?'': _offersController.blogsList[index].offer!.id.toString(),
                                      imagePath:_offersController.blogsList[index].offer==null?_offersController.blogsList[index].images[1].toString(): _offersController.blogsList[index].offer!.image.toString(),
                                      validTill:_offersController.blogsList[index].offer==null?'': _offersController.formatDate(_offersController.blogsList[index].offer!.expirationDate.toString()),
                                      foodTitle: _offersController.blogsList[index].restuarant.name,
                                      saleOnFood: _offersController.blogsList[index].title,
                                      tagsList:_offersController.blogsList[index].offer==null?[]: _offersController.blogsList[index].offer!.tags,
                                      restaurantLocation: _offersController.blogsList[index].restuarant.location.title.toString(),
                                      // termsAndConditions: _offersController.blogsList[index].termsConditions.toString(),
                                      featuredImagesList: _offersController.blogsList[index].images,
                                      lat: double.parse(_offersController.blogsList[index].restuarant.location.latitude),
                                      long: double.parse(_offersController.blogsList[index].restuarant.location.longitude),
                                      foodTitleToRedeem:_offersController.blogsList[index].offer==null?'': _offersController.blogsList[index].offer!.title,
                                      foodDescriptionToRedeem:_offersController.blogsList[index].offer==null?'': _offersController.blogsList[index].offer!.description,
                                    ));
                                  },
                                  child: CustomFoodTile(
                                    showRedeemNowButton: _offersController.blogsList[index].offer==null?false:true,
                                    onTapRedeemNow: () {
                                      print(_offersController.blogsList[index].offer!.image.toString());
                                      Get.to(()=>RedeemOffersScreen(
                                          offerId:_offersController.blogsList[index].offer!.id.toString() ,
                                          imagePath: _offersController.blogsList[index].offer!.image.toString(),
                                          title: _offersController.blogsList[index].offer!.title.toString(),
                                          description:_offersController.blogsList[index].offer!.description.toString(),
                                          validTill:"Valid till ${_offersController.formatDate(_offersController.blogsList[index].offer!.expirationDate.toString())}"
                                      ));
                                    },
                                    foodTileHeading: "Redeem Now",
                                    restaurantName: "_offersController.blogsList[index].offer.title",
                                    saleOnFood: _offersController.blogsList[index].title,
                                    imagePath: _offersController.blogsList[index].images[1].toString(),
                                    showTitle: false,
                                    fontWeightTitle: FontWeight.bold,
                                  ));
                            },
                            ),
                      ),
                  
                  
                  
                  
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
