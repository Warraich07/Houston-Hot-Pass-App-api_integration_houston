import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/app_widgets/shimmer_single_widget.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_images.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/views/my_profile/change_password_screen.dart';
import 'package:houstan_hot_pass/views/my_profile/customer_service_screen/customer_support.dart';
import 'package:houstan_hot_pass/views/my_profile/edit_personal_info.dart';
import 'package:houstan_hot_pass/views/my_profile/membership_screen.dart';
import 'package:houstan_hot_pass/views/my_profile/notification_setting_screen.dart';
import 'package:houstan_hot_pass/views/my_profile/notifications_screen.dart';
import 'package:houstan_hot_pass/views/my_profile/payment_method_screen.dart';
import 'package:houstan_hot_pass/views/my_profile/refer_a_friend_screen.dart';
import 'package:houstan_hot_pass/views/my_profile/widgets/profile_button.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../constants/app_icons.dart';
import '../../utils/custom_dialog.dart';
import '../../utils/shared_preference.dart';
import '../auth_screens/sign_in/sign_in_screen.dart';
import '../auth_screens/sign_up/sign_up_screeen.dart';
import 'logOut_bottomSheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController _authController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authController.showPopUps();
    });
    // _authController.savedLogInStatusOfUser();
    // setState(() {
    //
    // });
    print("${_authController.userStatusForShowingPopups.value}user status");
  }
  OffersController _offersController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(

        ()=> Column(
          children: [
            SizedBox(height: 260,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomAppBarBackGround(
                    height: 140,
                    showTextField: false,
                    showFiltersIcon: false,
                    showIcon: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppSubtitleText(fontWeight: FontWeight.bold,
                            Text: "Profile",
                            color: AppColors.primaryColor,
                            fontSize: 25,
                          ),
                          ZoomTapAnimation(onTap: () {
                            Get.to(()=>NotificationsScreen());
                            if(_authController.userLoginData.value!.hasUnReadNotification=='true'){
                              _authController.userLoginData.value!.hasUnReadNotification='false';
                              setState(() {

                              });
                            }

                          },
                              child: Stack(
                                children: [
                                  Image.asset(AppIcons.notificationBellIcon, scale: 3.8),
                                  _authController.userLoginData.value!.hasUnReadNotification=='true'?
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      height: 8,width: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryColor,
                                    ),

                                    ),
                                  )
                                      :Container()
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  _authController.userStatusForShowingPopups.value=='true'? Positioned(
                      bottom: 13,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          ClipRRect(
                            borderRadius:BorderRadius.circular(100),
                            child: SizedBox(
                              height:100,
                              width: 100,
                              child: CachedNetworkImage(
                                // memCacheWidth: 150,
                                // memCacheHeight: 150,
                                // maxHeightDiskCache: 150,
                                // maxWidthDiskCache: 150,
                                imageUrl:_authController.userLoginData.value!.image.toString(),
                                placeholder: (context, url) =>
                                    Center(
                                        child: ShimmerSingleWidget(shimmerWidth: 200)),
                                errorWidget: (context, url,
                                    error) =>
                                    Image.asset(
                                      "assets/app_images/upload_image.png",scale: 5.3,
                                      // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,

                                    ),
                                fit: BoxFit.cover,
                                scale:20 ,
                                // width: double.infinity,
                                // height: 250,
                              ),
                            ),
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(100),
                          //   child: SizedBox(
                          //     height: 100,
                          //     width: 100,
                          //     child: Image.asset(AppImages.uploadedImage,fit: BoxFit.cover,),
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          SizedBox(width: 85.w,
                            child: BoldText(Text: _authController.userLoginData.value!.name,color: Colors.black,fontSize: 20,TextALign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width:85.w ,
                              child: AppSubtitleText(Text: _authController.userLoginData.value!.email,color: Colors.black,fontSize: 13,TextALign: TextAlign.center,))
                        ],
                      )):Container()
                ],
              ),
            ),
            SizedBox(height: 0),
            _authController.userStatusForShowingPopups.value=='true'?  Expanded(
              child: SingleChildScrollView(
                child: CustomHorizontalPadding(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        ProfileButton(
                            title: "Edit Personal Info",
                            onTap: () {
                              _authController.updateImagePath(_authController.userLoginData.value!.image.toString());
                              Get.to(()=>EditPersonalInfo());
                            },
                            image: AppIcons.editPersonalProfileIcon),
                        spacingBetweenButtons(),
                        ProfileButton(
                            title: "Membership",
                            onTap: () {
                              Get.to(()=>MembershipScreen());
                            },
                            image: AppIcons.memberShipIcon),
                        spacingBetweenButtons(),
                        // ProfileButton(
                        //     title: "Payment Methods",
                        //     onTap: () {
                        //       Get.to(()=>PaymentMethodScreen());
                        //     },
                        //     image: AppIcons.paymentMethod),
                        // spacingBetweenButtons(),
                        ProfileButton(
                            title: "Notification setting",
                            onTap: () {
                              Get.to(()=>NotificationSettingScreen());
                            },
                            image: AppIcons.notificationSettingIcon),
                        spacingBetweenButtons(),
                        ProfileButton(
                            title: "Change Password",
                            onTap: () {
                              Get.to(()=>ChangePasswordScreen());
                            },
                            image: AppIcons.changePasswordIcon),
                        spacingBetweenButtons(),
                        ProfileButton(
                            title: "Customer Support",
                            onTap: () {
                              Get.to(()=>CustomerSupport());
                            },
                            image: AppIcons.customerSupportIcon),
                        spacingBetweenButtons(),
                        ProfileButton(
                            title: "Refer a friend",
                            onTap: () {
                              Get.to(()=>ReferAFriendScreen());
                            },
                            image: AppIcons.referAFriendIcon),
                        spacingBetweenButtons(),
                        ProfileButton(
                            title: "Log out",textColor: Colors.red,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const LogOutBottomSheet();
                                },
                              );
                            },

                            image: AppIcons.logOutIcon),
                      ],
                    ),
                  ),
                ),
              ),
            ):Container(),

          ],
        ),
      ),
    );
  }
  Widget spacingBetweenButtons() {
    return SizedBox(height: 17);
}
}
