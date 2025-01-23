import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_custom_gridview.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/views/home/redeem_offers_screen.dart';
import 'package:houstan_hot_pass/views/home/search_screen.dart';
import 'package:houstan_hot_pass/views/home/widgets/custom_food_tile.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/views/home/widgets/filtersbottomsheet.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../app_widgets/custom_field .dart';
import '../../app_widgets/shimmer.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import 'offer_details/offer_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GeneralController generalController= Get.find();
  OffersController _offersController=Get.find();
  AuthController _authController=Get.find();
  @override
  void initState() {
    _authController.savedLogInStatusOfUser();

    generalController.searchField.value = false;
    super.initState();

    if (!_offersController.isLoadingForHome.value) {
      _offersController.offersList.clear();
      _offersController.homeOffersCurrentPage.value = 0;
      _offersController.homeOffersLastPage.value = 0;
      _offersController.getOffers(false);
      _offersController.updateFcmToken(_offersController.fcmToken.value);
    }
  }
  @override
  Widget build(BuildContext context) {
    RefreshController _offersRefreshController = RefreshController(initialRefresh: false);
    return Scaffold(
      body: Obx(
        ()=> Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarBackGround(
              filtersBottomSheet: const FiltersBottomSheet(),
              showTextField: true,
              showFiltersIcon: true,
              height: 210,
              textFieldWidget:
            CustomTextField(
              enabled: true,
              focusNode: _offersController.focusNodeForHome,
              inputTextColor: Colors.black,
              onChanged: (String value) {
                generalController.searchField.value = value.isNotEmpty;
              },
              onTap: () {
                Get.to(() => const SearchScreen());
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

            const SizedBox(height:10),
            const CustomHorizontalPadding(
              child: AppSubtitleText(Text: "Top Offers For You", color: Colors.black, fontSize: 20),),
            const SizedBox(height: 10),

            Expanded(
              child:_offersController.isLoadingForHome.value==true?
              ShimmerGridView():_offersController.offersList.isEmpty?const Center(
                child: Text("No offers found."),
              ):
              CustomHorizontalPadding(
                child: SmartRefresher(
                  enablePullDown: false,
                  enablePullUp:_offersController.homeOffersCurrentPage.value>_offersController.homeOffersLastPage.value?false:true,
                  controller: _offersRefreshController,
                  onLoading: () async {
                    if (_offersController.homeOffersCurrentPage.value<_offersController.homeOffersLastPage.value) {
                      _offersController.homeOffersCurrentPage.value++;
                      if(!_offersController.isPullUp.value){
                        await _offersController.getOffers(true);
                        _offersRefreshController.loadComplete();
                      }
                      setState(() {});
                    }
                    _offersRefreshController.loadComplete();
                  },
                  child: CustomGridView(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _offersController.offersList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            print(_offersController.offersList[index].tags);
                            Get.to(()=>OfferDetails(
                              canRedeemAgain: true,
                              restaurantId: _offersController.offersList[index].restuarant.id.toString(),
                              offerId: _offersController.offersList[index].id.toString(),
                              imagePath: _offersController.offersList[index].image.toString(),
                              offerCreatedDate: _offersController.formatDate(_offersController.offersList[index].createdAt.toString()),
                              validTill: _offersController.formatDate(_offersController.offersList[index].expirationDate.toString()),
                              foodTitle: _offersController.offersList[index].title,
                              saleOnFood: _offersController.offersList[index].description,
                              restaurantLocation: _offersController.offersList[index].restuarant.location.title.toString(),
                              termsAndConditions: _offersController.offersList[index].termsConditions.toString(),
                              tagsList: _offersController.offersList[index].tags,
                              lat: double.parse(_offersController.offersList[index].restuarant.location.latitude),
                              long: double.parse(_offersController.offersList[index].restuarant.location.longitude),
                            ));
                          },
                          child: CustomFoodTile(
                            onTapRedeemNow: () {
                              Get.to(()=>RedeemOffersScreen(
                                  offerId:_offersController.offersList[index].id.toString() ,
                                  imagePath: _offersController.offersList[index].image.toString(),
                                  title: _offersController.offersList[index].title.toString(),
                                  description:_offersController.offersList[index].description.toString(),
                                  validTill:"Valid till ${_offersController.formatDate(_offersController.offersList[index].expirationDate.toString())}"
                              ));
                            },
                            foodTileHeading: "Redeem Now",
                            restaurantName: _offersController.offersList[index].title,
                            saleOnFood: _offersController.offersList[index].description,
                            imagePath: _offersController.offersList[index].image,

                          ),
                        ),
                      );
                    },



                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Center(
            //     child: CircularProgressIndicator(
            //       color: AppColors.primaryColor,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
