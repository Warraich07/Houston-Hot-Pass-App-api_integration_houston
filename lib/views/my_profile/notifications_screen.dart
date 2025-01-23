import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/custom_listview.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/app_widgets/shimmer_single_widget.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:sizer/sizer.dart';

import '../home/offer_details/offer_details.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final OffersController _offersController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offersController.getNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        body: Column(
          children: [
            const CustomAppBarBackGround(
              showTextField: false,
              showFiltersIcon: false,
              showBackButton: true,
              showIcon: false,
              screenTitle: "Notifications",
              height: 125,
              showScreenTitle: true,
            ),
           _offersController.isLoading.value?Column(
             children: [SizedBox(height: 20,),ShimmerSingleWidget(shimmerWidth: 90.w),SizedBox(height: 20,),ShimmerSingleWidget(shimmerWidth: 90.w)],
           ) : Expanded(
              child: CustomHorizontalPadding(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:_offersController.notificatonsList.isEmpty?Center(
                    child: Text("No notifications yet."),
                  ): CustomListview(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _offersController.notificatonsList.length,
                    itemBuilder: (context,index){
                      _offersController.markAsRead( _offersController.notificatonsList[index].id.toString());
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>OfferDetails(
                            canRedeemAgain: true,
                            restaurantId: _offersController.notificatonsList[index].notificationData.restaurant.id.toString(),
                            offerId: _offersController.notificatonsList[index].notificationData.id.toString(),
                            imagePath: _offersController.notificatonsList[index].notificationData.image,
                            offerCreatedDate: _offersController.formatDate(_offersController.notificatonsList[index].notificationData.createdAt.toString()),
                            validTill: _offersController.formatDate(_offersController.notificatonsList[index].notificationData.expirationDate.toString()),
                            foodTitle: _offersController.notificatonsList[index].notificationData.title,
                            saleOnFood:_offersController.notificatonsList[index].notificationData.description,
                            restaurantLocation:_offersController.notificatonsList[index].notificationData.restaurant.location.title,
                            termsAndConditions: _offersController.notificatonsList[index].notificationData.termsConditions,
                            tagsList:_offersController.notificatonsList[index].notificationData.tags,
                            lat: double.parse(_offersController.notificatonsList[index].notificationData.restaurant.location.latitude),
                            long: double.parse(_offersController.notificatonsList[index].notificationData.restaurant.location.longitude),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:18.0),
                          child: Container(
                            decoration: customShadowedDecoration(buttonColor: AppColors.peachColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   AppSubtitleText(
                                    Text: _offersController.notificatonsList[index].title,
                                    color: Colors.black,
                                    fontSize: 20,
                                    maxLines: 2,
                                    height: 1,
                                  ),
                                  const SizedBox(height: 5),
                                  AppSubtitleText(
                                    Text:_offersController.notificatonsList[index].body,
                                    fontSize: 13,
                                    maxLines: 2,
                                    color: Colors.black.withOpacity(0.8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    // child: Padding(
                    //   padding: const EdgeInsets.only(bottom:18.0),
                    //   child: Container(
                    //     decoration: customShadowedDecoration(buttonColor: AppColors.peachColor),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                    //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           AppSubtitleText(Text: "30% Off on All-You-Can-Eat",color: Colors.black,fontSize: 20,maxLines: 2,height: 1,),
                    //           SizedBox(height: 5),
                    //           AppSubtitleText(Text: "Hungry? Enjoy 30% Off at The Curry Pizza Guy. Check out the details and claim your reward.",fontSize: 13,maxLines: 2,color: Colors.black.withOpacity(0.8),)
                    //
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
