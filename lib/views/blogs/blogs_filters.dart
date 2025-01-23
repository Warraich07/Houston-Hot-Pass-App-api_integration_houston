import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/controllers/home_controller.dart';
import 'package:houstan_hot_pass/views/home/offer_details/offer_details.dart';
import 'package:houstan_hot_pass/views/home/redeem_offers_screen.dart';
import 'package:houstan_hot_pass/views/home/widgets/custom_food_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/custom_appbar.dart';
import '../../constants/app_colors.dart';
import '../../controllers/offers_controller.dart';
import 'blog_details.dart';

class BlogsFilterResults extends StatefulWidget {
  BlogsFilterResults({super.key,required this.filteredKeyWord});
  String filteredKeyWord;
  @override
  State<BlogsFilterResults> createState() => _BlogsFilterResultsState();
}

class _BlogsFilterResultsState extends State<BlogsFilterResults> {
  HomeController homeController = Get.find();

  List<String> menuList = [
    "Fashion",
    "Ratings",
    "Price",
  ];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }
  OffersController _offersController=Get.find();

  @override
  Widget build(BuildContext context) {
    RefreshController _offersRefreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      body: Obx(
            () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarBackGround(
              height: 190,
              showTextField: false,
              showFiltersIcon: false,
              showBackButton: true,
              showIcon: true,
              child: SizedBox(
                height: 40,
                width: Get.width,
                child: ListView.builder(
                  itemCount: homeController.filterList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var filter = homeController.filterList[index];
                    return Padding(
                      padding: const EdgeInsets.only( top: 5),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(0)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                filter.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.whiteColor,
                                    fontFamily: "fsb-bold"),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                  onTap: () {
                                    homeController.filterList.removeAt(index);
                                    Get.back();
                                  },
                                  child: Icon(
                                    CupertinoIcons.xmark,
                                    size: 20,
                                    color: AppColors.whiteColor,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child:_offersController.isLoading.value==true?Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ): CustomHorizontalPadding(
                child:_offersController.filteredCuisineBlogsList.isEmpty?Center(
                  child: Text("No filtered cuisines"),
                ): SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: _offersRefreshController,
                  onLoading: () async {
                    if (_offersController.filteredCuisineBlogsCurrentPage.value<_offersController.filteredCuisineBlogsLastPage.value) {
                      _offersController.filteredCuisineBlogsCurrentPage.value++;
                      await _offersController.filterBlogsTypes(true,widget.filteredKeyWord);

                      setState(() {});
                    }
                    _offersRefreshController.loadComplete();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // mainAxisExtent: 135,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 4 / 5),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: _offersController.filteredCuisineBlogsList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                // Get.to(()=>BlogDetailsScreen(
                                //   offerCreatedAt: _offersController.formatDate(_offersController.filteredCuisineBlogsList[index].offer!.createdAt.toString()),
                                //   htmWidgetDescription: _offersController.filteredCuisineBlogsList[index].description,
                                //   canRedeemAgain: true,
                                //   restaurantId: _offersController.filteredCuisineBlogsList[index].restuarant.id.toString(),
                                //   offerId: _offersController.filteredCuisineBlogsList[index].offer!.id.toString(),
                                //   imagePath: _offersController.filteredCuisineBlogsList[index].offer!.image.toString(),
                                //   validTill: _offersController.formatDate(_offersController.filteredCuisineBlogsList[index].offer!.expirationDate.toString()),
                                //   foodTitle: _offersController.filteredCuisineBlogsList[index].restuarant.name,
                                //   saleOnFood: _offersController.filteredCuisineBlogsList[index].title,
                                //   tagsList: _offersController.filteredCuisineBlogsList[index].offer!.tags,
                                //   restaurantLocation: _offersController.filteredCuisineBlogsList[index].restuarant.location.title.toString(),
                                //   // termsAndConditions: _offersController.blogsList[index].termsConditions.toString(),
                                //   featuredImagesList: _offersController.filteredCuisineBlogsList[index].images,
                                //   lat: double.parse(_offersController.filteredCuisineBlogsList[index].restuarant.location.latitude),
                                //   long: double.parse(_offersController.filteredCuisineBlogsList[index].restuarant.location.longitude),
                                //   foodTitleToRedeem: _offersController.filteredCuisineBlogsList[index].offer!.title,
                                //   foodDescriptionToRedeem: _offersController.filteredCuisineBlogsList[index].offer!.description,
                                // ));
                                Get.to(()=>BlogDetailsScreen(
                                  offer: _offersController.filteredCuisineBlogsList[index].offer==null?'null':'',
                                  offerCreatedAt:_offersController.filteredCuisineBlogsList[index].offer==null? _offersController.formatDate(_offersController.filteredCuisineBlogsList[index].createdAt.toString()): _offersController.formatDate(_offersController.filteredCuisineBlogsList[index].offer!.createdAt.toString()),
                                  htmWidgetDescription: _offersController.filteredCuisineBlogsList[index].description,
                                  canRedeemAgain: true,
                                  restaurantId: _offersController.filteredCuisineBlogsList[index].restuarant.id.toString(),
                                  offerId:_offersController.filteredCuisineBlogsList[index].offer==null?'': _offersController.filteredCuisineBlogsList[index].offer!.id.toString(),
                                  imagePath:_offersController.filteredCuisineBlogsList[index].offer==null?_offersController.filteredCuisineBlogsList[index].images[1].toString(): _offersController.filteredCuisineBlogsList[index].offer!.image.toString(),
                                  validTill:_offersController.filteredCuisineBlogsList[index].offer==null?'': _offersController.formatDate(_offersController.filteredCuisineBlogsList[index].offer!.expirationDate.toString()),
                                  foodTitle: _offersController.filteredCuisineBlogsList[index].restuarant.location.title,
                                  saleOnFood: _offersController.filteredCuisineBlogsList[index].title,
                                  tagsList:_offersController.filteredCuisineBlogsList[index].offer==null?[]: _offersController.filteredCuisineBlogsList[index].offer!.tags,
                                  restaurantLocation: _offersController.filteredCuisineBlogsList[index].restuarant.location.title.toString(),
                                  // termsAndConditions: _offersController.blogsList[index].termsConditions.toString(),
                                  featuredImagesList: _offersController.filteredCuisineBlogsList[index].images,
                                  lat: double.parse(_offersController.filteredCuisineBlogsList[index].restuarant.location.latitude),
                                  long: double.parse(_offersController.filteredCuisineBlogsList[index].restuarant.location.longitude),
                                  foodTitleToRedeem:_offersController.filteredCuisineBlogsList[index].offer==null?'': _offersController.filteredCuisineBlogsList[index].offer!.title,
                                  foodDescriptionToRedeem:_offersController.filteredCuisineBlogsList[index].offer==null?'': _offersController.filteredCuisineBlogsList[index].offer!.description,
                                ));
                              },
                              child: CustomFoodTile(
                                showRedeemNowButton: _offersController.filteredCuisineBlogsList[index].offer==null?false:true,
                                onTapRedeemNow: () {
                                  Get.to(()=>RedeemOffersScreen(
                                      offerId:_offersController.filteredCuisineBlogsList[index].offer!.id.toString() ,
                                      imagePath: _offersController.filteredCuisineBlogsList[index].offer!.image.toString(),
                                      title: _offersController.filteredCuisineBlogsList[index].offer!.title.toString(),
                                      description:_offersController.filteredCuisineBlogsList[index].offer!.description.toString(),
                                      validTill:"Valid till ${_offersController.formatDate(_offersController.filteredCuisineBlogsList[index].offer!.expirationDate.toString())}"
                                  ));
                                },
                                foodTileHeading: "Redeem Now",
                                // restaurantName: _offersController.filteredCuisineBlogsList[index].title,
                                // saleOnFood: _offersController.filteredCuisineBlogsList[index].title,
                                // imagePath: _offersController.filteredCuisineBlogsList[index].offer!.image,
                                saleOnFood: _offersController.filteredCuisineBlogsList[index].title,
                                imagePath: _offersController.filteredCuisineBlogsList[index].images[1].toString(),
                                showTitle: false,
                                fontWeightTitle: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
