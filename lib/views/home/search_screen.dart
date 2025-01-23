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

import '../../app_widgets/app_custom_gridview.dart';
import '../../app_widgets/custom_field .dart';
import '../../controllers/offers_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Controllers
  GeneralController generalController = Get.find();
  OffersController _offersController=Get.find();
  String searchQuery='';
  final focusNode=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offersController.filteredList.clear();
    _offersController.searchedOffersCurrentPage.value=0;
    _offersController.searchedOffersLastPage.value=0;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    RefreshController _offersRefreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      body: Obx(
        ()=> Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarBackGround(
              showTextField: true,
              showFiltersIcon: false,
              showBackButton: true,
              height: 200,
              textFieldWidget:
              CustomTextField(
                onFieldSubmitted: (value){
                  _offersController.getSearchOffers(false, value.toString());
                },
                focusNode: focusNode,
                inputTextColor: Colors.black,
                onChanged: (String value) {
                  searchQuery=value.toString();
                  if(searchQuery.isEmpty){
                    _offersController.filteredList.clear();
                    setState(() {});
                  }
                },
                onTap: () {
                  if(searchQuery.isNotEmpty){
                    _offersController.getSearchOffers(false,searchQuery);
                  }
                },
                fillColor: AppColors.whiteColor,
                hintText: "Search here...",
                hintTextColor:
                Colors.black.withOpacity(0.5),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Image.asset(AppIcons.searchIcon, scale: 3.5,),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CustomHorizontalPadding(child: AppSubtitleText(Text: "Search Results",color: Colors.black,fontSize: 20,)),
           // generalController.searchField.value
           //      ?
         _offersController.filteredList.isNotEmpty?  Expanded(
                  child: CustomHorizontalPadding(
                    child: SmartRefresher(
                      enablePullDown: false,
                      enablePullUp:true,
                      controller: _offersRefreshController,
                      onLoading: () async {
                        if (_offersController.searchedOffersCurrentPage.value<_offersController.searchedOffersLastPage.value) {
                          _offersController.searchedOffersCurrentPage.value++;
                          // if(!_offersController.isPullUp.value){
                          _offersController.searchOffers(true,searchQuery);
                          // }
                          setState(() {});
                        }
                        _offersRefreshController.loadComplete();
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
                              itemCount: _offersController.filteredList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                    Get.to(()=> OfferDetails(
                                      offerCreatedDate: _offersController.formatDate(_offersController.offersList[index].createdAt.toString()),

                                      canRedeemAgain: true,
                                      restaurantId: _offersController.offersList[index].restuarant.id.toString(),
                                      offerId: _offersController.filteredList[index].id.toString(),
                                      imagePath: _offersController.filteredList[index].image.toString(),
                                      validTill: _offersController.formatDate(_offersController.filteredList[index].expirationDate.toString()),
                                      foodTitle: _offersController.filteredList[index].title,
                                      saleOnFood: _offersController.filteredList[index].description,
                                      restaurantLocation: _offersController.filteredList[index].restuarant.location.title.toString(),
                                      termsAndConditions: _offersController.filteredList[index].termsConditions.toString(),
                                      tagsList: _offersController.filteredList[index].tags,
                                      lat: double.parse(_offersController.filteredList[index].restuarant.location.latitude),
                                      long: double.parse(_offersController.filteredList[index].restuarant.location.longitude),
                                    ));
                                  },
                                      child: CustomFoodTile(
                                        onTapRedeemNow: () {
                                          Get.to(()=> RedeemOffersScreen(
                                              offerId:_offersController.filteredList[index].id.toString() ,
                                              imagePath: _offersController.filteredList[index].image.toString(),
                                              title: _offersController.filteredList[index].title.toString(),
                                              description:_offersController.filteredList[index].description.toString() ,
                                              validTill:"Valid till ${_offersController.formatDate(_offersController.filteredList[index].expirationDate.toString())}"
                                          ));
                                        },
                                        foodTileHeading: "Redeem Now",
                                        restaurantName: _offersController.filteredList[index].title,
                                        saleOnFood:  _offersController.filteredList[index].description,
                                        imagePath: _offersController.filteredList[index].image.toString(),

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
