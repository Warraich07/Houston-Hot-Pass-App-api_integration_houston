import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/custom_listview.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/views/history_screen/widgets/redeemed_offers_tile.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../app_widgets/shimmer_single_widget.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/custom_dialog.dart';
import '../auth_screens/sign_in/sign_in_screen.dart';
import '../auth_screens/sign_up/sign_up_screeen.dart';
import '../home/offer_details/offer_details.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime? selectedDate;
  String selectedDateForPagination= DateFormat('dd-MM-yyyy').format(DateTime.now());
  Future<void> selectDate(BuildContext context) async {
    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        onBackground: AppColors.primaryColor,
        onSecondary: AppColors.blackColor,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.whiteColor,
        onSurface: AppColors.blackColor,
        surface: AppColors.whiteColor,
      ),
    );

    // Set initial date to today if selectedDate is null
    final DateTime initialDate = selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: initialDate,
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
      // _offersController.formattedDate.value =  DateFormat('MMMM, yyyy').format(selectedDate!);
      String filteredDate= DateFormat('dd-MM-yyyy').format(selectedDate!);
      selectedDateForPagination= DateFormat('dd-MM-yyyy').format(selectedDate!);
      _offersController.redeemedOffersList.clear();
      _offersController.redeemedOffersCurrentPage.value=0;
      _offersController.redeemedOffersLastPage.value=0;
      _offersController.getRedeemedOffers(false,filteredDate);
      String selectedDateFor = DateFormat('d MMMM, yyyy').format(selectedDate!);
      _offersController.updateSelectedDate(selectedDateFor);
    }
  }
  AuthController _authController=Get.find();
  OffersController _offersController=Get.find();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _offersController.updateSelectedDate('today');
      _authController.showPopUps();
      String filteredDate= DateFormat('dd-MM-yyyy').format(DateTime.now());
      if(_authController.userStatusForShowingPopups.value=='true'){
        _offersController.redeemedOffersList.clear();
        _offersController.redeemedOffersCurrentPage.value=0;
        _offersController.redeemedOffersLastPage.value=0;
        _offersController.getRedeemedOffers(false,filteredDate);
      }

    });
    print(_authController.userStatusForShowingPopups.value+"shkadhsa");
  }
  @override
  Widget build(BuildContext context) {
    RefreshController _offersRefreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          ()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarBackGround(
                showTextField: false,
                showFiltersIcon: false,showIcon:
              false,height: 140,
              child:_authController.userStatusForShowingPopups.value=='true'? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSubtitleText(Text: "Redeemed Offers\nHistory",color: AppColors.primaryColor,fontSize: 27,height: 1.1,fontWeight: FontWeight.bold,),
                    // Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ZoomTapAnimation(
                          onTap: () {
                            selectDate(context);
                          },
                          child: Icon(Icons.calendar_month_outlined,color: AppColors.primaryColor,)),
                    )
                  ],
                ),
              ):Container(),
              ),

              CustomHorizontalPadding(
                child: Obx(
                  ()=> Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const AppSubtitleText(
                          Text: 'Redeemed Offers', color: Colors.black, fontSize: 20,),
                      const SizedBox(height: 10),
                      _offersController.isLoading.value==true? SizedBox(
                        height: 50.h,
                        child: Column(children: [
                          Container(
                              height: 18.h,
                              child: ShimmerSingleWidget(shimmerWidth: 90.w)),
                          SizedBox(height: 10,),
                          Container(
                              height: 18.h,
                              child: ShimmerSingleWidget(shimmerWidth: 90.w)),
                        ],),
                      ): SizedBox(
                        height: 68.h,
                        child:_offersController.redeemedOffersList.isEmpty?Center(
                          child:Text("No offers redeemed "+_offersController.selectedDate.value+'.'),
                        ): SmartRefresher(
                          enablePullDown: false,
                          enablePullUp:true,
                          controller: _offersRefreshController,
                          onLoading: () async {
                            if (_offersController.redeemedOffersCurrentPage.value<_offersController.redeemedOffersLastPage.value) {
                              _offersController.redeemedOffersCurrentPage.value++;
                              // if(!_offersController.isPullUp.value){
                              await _offersController.getRedeemedOffers(true,selectedDateForPagination);
                              // }
                              setState(() {});
                            }
                            _offersRefreshController.loadComplete();
                          },
                          child: CustomListview(
                            physics: ScrollPhysics(),
                              itemCount:_offersController.redeemedOffersList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    Get.to(()=>OfferDetails(
                                      offerCreatedDate: _offersController.formatDate(_offersController.redeemedOffersList[index].createdAt.toString()),

                                      canRedeemAgain: _offersController.redeemedOffersList[index].offer.unlimited,
                                      restaurantId: _offersController.redeemedOffersList[index].offer.restuarant.id.toString(),
                                      offerId: _offersController.redeemedOffersList[index].offer.id.toString(),
                                      imagePath: _offersController.redeemedOffersList[index].offer.image.toString(),
                                      validTill: _offersController.formatDate(_offersController.redeemedOffersList[index].offer.expirationDate.toString()),
                                      foodTitle: _offersController.redeemedOffersList[index].offer.title,
                                      saleOnFood: _offersController.redeemedOffersList[index].offer.description,
                                      restaurantLocation: _offersController.redeemedOffersList[index].offer.restuarant.location.title.toString(),
                                      termsAndConditions: _offersController.redeemedOffersList[index].offer.termsConditions.toString(),
                                      tagsList: _offersController.redeemedOffersList[index].offer.tags,
                                      lat: double.parse(_offersController.redeemedOffersList[index].offer.restuarant.location.latitude),
                                      long: double.parse(_offersController.redeemedOffersList[index].offer.restuarant.location.longitude),
                                    ));
                                    print(_offersController.redeemedOffersList[index].offer.unlimited);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 15.0),
                                    child: RedeemedOffersTile(
                                      foodTitle: _offersController.redeemedOffersList[index].offer.title,
                                      saleOnFood: _offersController.redeemedOffersList[index].offer.description,
                                      redeemedDateAndTime:'Redeemed At: ${_offersController.formatDate(_offersController.redeemedOffersList[index].createdAt.toString())}',
                                      imagePath: _offersController.redeemedOffersList[index].offer.image,
                                      redeemedButtonText:_offersController.redeemedOffersList[index].offer.unlimited.toString()=='true'? 'Redeem Again':'Redeemed',
                                    ),
                                  ),
                                );
                              },

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
