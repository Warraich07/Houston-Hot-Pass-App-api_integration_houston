import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:houstan_hot_pass/views/home/offer_details/offer_details.dart';
import 'package:houstan_hot_pass/views/home/redeem_offers_screen.dart';
import 'package:houstan_hot_pass/views/home/widgets/custom_food_tile.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/app_bar_blogs.dart';
import '../../app_widgets/app_custom_gridview.dart';
import '../../app_widgets/custom_field .dart';
import '../../controllers/offers_controller.dart';
import 'blog_details.dart';

class SearchBlogsScreen extends StatefulWidget {
  const SearchBlogsScreen({super.key});

  @override
  State<SearchBlogsScreen> createState() => _SearchBlogsScreenState();
}

class _SearchBlogsScreenState extends State<SearchBlogsScreen> {
  // Controllers
  GeneralController generalController = Get.find();
  OffersController _offersController=Get.find();
  String searchQuery='';
  String storedString='';
  String storedStringOnChanged='';
  final focusNode=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offersController.filteredBlogsList.clear();
    _offersController.filteredBlogsCurrentPage.value=0;
    _offersController.filteredBlogsLastPage.value=0;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    RefreshController _blogsRefreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      body: Obx(
            ()=> Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarBlogs(
              // filtersBottomSheet: FiltersBottomSheet(),
              showTextField: true,
              showFiltersIcon: false,
              showBackButton: true,
              height: 200,
              textFieldWidget:
              CustomTextField(
                enabled: false,
                focusNode: focusNode,
                inputTextColor: Colors.black,
                onChanged: (String value) {
                  storedStringOnChanged=value.toString();
                  searchQuery=value.toString();
                  if(searchQuery.isEmpty){
                    _offersController.filteredBlogsList.clear();
                    setState(() {});
                  }
                },
                onTap: () {
                  print("object");
                  // if(searchQuery.isNotEmpty){
                  //     // if(storedString.length)
                  //   _offersController.filterBlogs(false,searchQuery);
                  //   // focusNode.unfocus();
                  // }
                },
                onFieldSubmitted: (value){
                  focusNode.unfocus();
                  _offersController.filterBlogs(false, value.toString());
                },
                fillColor: AppColors.whiteColor,
                hintText: "Search blogs here...",
                hintTextColor:
                Colors.black.withOpacity(0.5),
                suffixIcon: GestureDetector(
                  onTap: (){
                    if(searchQuery.isNotEmpty){
                      focusNode.unfocus();
                      _offersController.filterBlogs(false,searchQuery);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image.asset(AppIcons.searchIcon, scale: 3.5,),
                  ),
                ),
              ),
            ),
            // CustomAppBarBackGround(
            //   showTextField: true,
            //   showFiltersIcon: false,
            //   showBackButton: true,
            //   height: 200,
            //   textFieldWidget:
            //   CustomTextField(
            //     onFieldSubmitted: (value){
            //       _offersController.getSearchOffers(false, value.toString());
            //     },
            //     focusNode: focusNode,
            //     inputTextColor: Colors.black,
            //     onChanged: (String value) {
            //       searchQuery=value.toString();
            //       if(searchQuery.isEmpty){
            //         _offersController.filteredList.clear();
            //         setState(() {});
            //       }
            //     },
            //     onTap: () {
            //       if(searchQuery.isNotEmpty){
            //         _offersController.getSearchOffers(false,searchQuery);
            //       }
            //     },
            //     fillColor: AppColors.whiteColor,
            //     hintText: "Search here...",
            //     hintTextColor:
            //     Colors.black.withOpacity(0.5),
            //     suffixIcon: Padding(
            //       padding: const EdgeInsets.only(right: 5.0),
            //       child: Image.asset(AppIcons.searchIcon, scale: 3.5,),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            const CustomHorizontalPadding(child: AppSubtitleText(Text: "Search Results",color: Colors.black,fontSize: 20,)),
            // generalController.searchField.value
            //      ?
            _offersController.filteredBlogsList.isNotEmpty?  Expanded(
                child: CustomHorizontalPadding(
                  child: SmartRefresher(
                    enablePullDown: false,
                    enablePullUp:true,
                    controller: _blogsRefreshController,
                    onLoading: () async {
                      if (_offersController.filteredBlogsCurrentPage.value<_offersController.filteredBlogsCurrentPage.value) {
                        _offersController.filteredBlogsCurrentPage.value++;
                        // if(!_offersController.isPullUp.value){
                        _offersController.filterBlogs(true,searchQuery);
                        // }
                        setState(() {});
                      }
                      _blogsRefreshController.loadComplete();
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          height: 65.h,
                          // color: Colors.green,
                          child: CustomGridView(
                            padding: EdgeInsets.only(
                                bottom: 10
                            ),
                            itemCount: _offersController.filteredBlogsList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: GestureDetector(
                                    onTap: () {
                                      // Get.to(()=>BlogDetailsScreen(
                                      //   offerCreatedAt: _offersController.formatDate(_offersController.filteredBlogsList[index].offer!.createdAt.toString()),
                                      //
                                      //   htmWidgetDescription: _offersController.filteredBlogsList[index].description,
                                      //   canRedeemAgain: true,
                                      //   restaurantId: _offersController.filteredBlogsList[index].restuarant.id.toString(),
                                      //   offerId: _offersController.filteredBlogsList[index].offer!.id.toString(),
                                      //   imagePath: _offersController.filteredBlogsList[index].offer!.image.toString(),
                                      //   validTill: _offersController.formatDate(_offersController.filteredBlogsList[index].offer!.expirationDate.toString()),
                                      //   foodTitle: _offersController.blogsList[index].restuarant.name,
                                      //   saleOnFood: _offersController.blogsList[index].title,
                                      //   tagsList: _offersController.filteredBlogsList[index].offer!.tags,
                                      //   restaurantLocation: _offersController.filteredBlogsList[index].restuarant.location.title.toString(),
                                      //   // termsAndConditions: _offersController.blogsList[index].termsConditions.toString(),
                                      //   featuredImagesList: _offersController.filteredBlogsList[index].images,
                                      //   lat: double.parse(_offersController.filteredBlogsList[index].restuarant.location.latitude),
                                      //   long: double.parse(_offersController.filteredBlogsList[index].restuarant.location.longitude),
                                      //   foodTitleToRedeem: _offersController.blogsList[index].offer!.title,
                                      //   foodDescriptionToRedeem: _offersController.blogsList[index].offer!.description,
                                      // ));
                                      Get.to(()=>BlogDetailsScreen(
                                        offer: _offersController.filteredBlogsList[index].offer==null?'null':'',
                                        offerCreatedAt:_offersController.filteredBlogsList[index].offer==null? _offersController.formatDate(_offersController.filteredBlogsList[index].createdAt.toString()): _offersController.formatDate(_offersController.filteredBlogsList[index].offer!.createdAt.toString()),
                                        htmWidgetDescription: _offersController.filteredBlogsList[index].description,
                                        canRedeemAgain: true,
                                        restaurantId: _offersController.filteredBlogsList[index].restuarant.id.toString(),
                                        offerId:_offersController.filteredBlogsList[index].offer==null?'': _offersController.filteredBlogsList[index].offer!.id.toString(),
                                        imagePath:_offersController.filteredBlogsList[index].offer==null?_offersController.filteredBlogsList[index].images[1].toString(): _offersController.filteredBlogsList[index].offer!.image.toString(),
                                        validTill:_offersController.filteredBlogsList[index].offer==null?'': _offersController.formatDate(_offersController.filteredBlogsList[index].offer!.expirationDate.toString()),
                                        foodTitle: _offersController.filteredBlogsList[index].restuarant.name,
                                        saleOnFood: _offersController.filteredBlogsList[index].title,
                                        tagsList:_offersController.filteredBlogsList[index].offer==null?[]: _offersController.filteredBlogsList[index].offer!.tags,
                                        restaurantLocation: _offersController.filteredBlogsList[index].restuarant.location.title.toString(),
                                        // termsAndConditions: _offersController.blogsList[index].termsConditions.toString(),
                                        featuredImagesList: _offersController.filteredBlogsList[index].images,
                                        lat: double.parse(_offersController.filteredBlogsList[index].restuarant.location.latitude),
                                        long: double.parse(_offersController.filteredBlogsList[index].restuarant.location.longitude),
                                        foodTitleToRedeem:_offersController.filteredBlogsList[index].offer==null?'': _offersController.filteredBlogsList[index].offer!.title,
                                        foodDescriptionToRedeem:_offersController.filteredBlogsList[index].offer==null?'': _offersController.filteredBlogsList[index].offer!.description,
                                      ));
                                    },
                                    child: CustomFoodTile(
                                      showRedeemNowButton: _offersController.filteredBlogsList[index].offer==null?false:true,
                                      onTapRedeemNow: () {
                                        Get.to(()=>RedeemOffersScreen(
                                            offerId:_offersController.filteredBlogsList[index].offer!.id.toString() ,
                                            imagePath: _offersController.filteredBlogsList[index].offer!.image.toString(),
                                            title: _offersController.filteredBlogsList[index].offer!.title.toString(),
                                            description:_offersController.filteredBlogsList[index].offer!.description.toString(),
                                            validTill:"Valid till ${_offersController.formatDate(_offersController.filteredBlogsList[index].offer!.expirationDate.toString())}"
                                        ));
                                      },
                                      foodTileHeading: "Redeem Now",
                                      restaurantName: "_offersController.filteredBlogsList[index].offer!.title",
                                      saleOnFood: _offersController.filteredBlogsList[index].title,
                                      imagePath: _offersController.filteredBlogsList[index].images[1].toString(),
                                      showTitle: false,
                                      fontWeightTitle: FontWeight.bold,
                                    )),
                              );
                            },
                          ),
                        )
                    ),
                  ),
                ))
                : Expanded(
              child:_offersController.isLoading.value==false? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcons.searchIconForSearchScreen,
                      scale: 1,
                      width: 50,
                    ),
                    const SizedBox(height: 10),
                    BoldText(
                      Text: "Nothing To Show",
                      color: AppColors.primaryColor,fontSize: 16,
                    )
                  ],
                ),
              ):Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
