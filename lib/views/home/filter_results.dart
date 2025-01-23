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

class FilterResults extends StatefulWidget {
  FilterResults({super.key,required this.filteredKeyWord});
  String filteredKeyWord;
  @override
  State<FilterResults> createState() => _FilterResultsState();
}

class _FilterResultsState extends State<FilterResults> {
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
                child:_offersController.filteredOfferTypesList.isEmpty?Center(
                  child: Text("No filtered cuisines"),
                ): SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: _offersRefreshController,
                  onLoading: () async {
                    if (_offersController.filteredOffersCurrentPage.value<_offersController.filteredOffersLastPage.value) {
                      _offersController.filteredOffersCurrentPage.value++;
                      await _offersController.filterOfferTypes(true,widget.filteredKeyWord);

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
                        itemCount: _offersController.filteredOfferTypesList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(()=>OfferDetails(
                                  offerCreatedDate: _offersController.formatDate(_offersController.filteredOfferTypesList[index].createdAt.toString()),

                                  canRedeemAgain: true,
                                  offerId: _offersController.filteredOfferTypesList[index].id.toString(),
                                  imagePath: _offersController.filteredOfferTypesList[index].image.toString(),
                                  validTill: _offersController.formatDate(_offersController.filteredOfferTypesList[index].expirationDate.toString()),
                                  foodTitle: _offersController.filteredOfferTypesList[index].title,
                                  saleOnFood: _offersController.filteredOfferTypesList[index].description,
                                  restaurantLocation: _offersController.filteredOfferTypesList[index].restuarant.location.title.toString(),
                                  termsAndConditions: _offersController.filteredOfferTypesList[index].termsConditions.toString(),
                                  tagsList: _offersController.filteredOfferTypesList[index].tags,
                                  lat: double.parse(_offersController.filteredOfferTypesList[index].restuarant.location.latitude),
                                  long: double.parse(_offersController.filteredOfferTypesList[index].restuarant.location.longitude),));
                              },
                              child: CustomFoodTile(
                                onTapRedeemNow: () {
                                  Get.to(()=>RedeemOffersScreen());
                                },
                                foodTileHeading: "Redeem Now",
                                restaurantName: _offersController.filteredOfferTypesList[index].title,
                                saleOnFood: _offersController.filteredOfferTypesList[index].description,
                                imagePath: _offersController.filteredOfferTypesList[index].image,
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
