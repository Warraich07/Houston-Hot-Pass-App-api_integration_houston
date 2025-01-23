import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/views/my_profile/widgets/customswitch.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/custom_appbar_background.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  // bool newPerksOfferedValue = true;
  // bool newsAndUpdates = true;
  // bool reminderValue = true;
  OffersController _offersController=Get.find();
  AuthController _authController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _offersController.newPerksOfferedValue.value=_authController.userLoginData.value!.notificationSettings.newPerks;
    // _offersController.newsAndUpdates.value=_authController.userLoginData.value!.notificationSettings.newsUpdates;
    // _offersController.reminderValue.value=_authController.userLoginData.value!.notificationSettings.reminders;
    // print(reminderValue.toString()+">>>>>>>>>>>>>");
    // setState(() {
    //
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        body: Column(
          children: [
            CustomAppBarBackGround(
              showTextField: false,
              showFiltersIcon: false,
              showIcon: false,
              screenTitle: "Notification setting",
              showScreenTitle: true,
              showBackButton: true,
              height: 125,
              screenSubtitle: "Enable/disable notifications",
              showScreenSubtitle: true,
            ),
            Column(
              children: [
               SizedBox(height: 30),

                Container(
                  decoration: customShadowedDecoration(buttonColor: Colors.white),
                  height: 60,
                  width: 90.w,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppSubtitleText(Text: "New Perks Offered",color: Colors.black),
                        CustomSwitch(
                          value: _offersController.newPerksOfferedValue.value,
                          onChanged: (value) {
                            setState(() {
                              _offersController.newPerksOfferedValue.value = !_offersController.newPerksOfferedValue.value;
                              _offersController.changeNotificatiionSettings(
                                _offersController.newPerksOfferedValue.value?'1':'0',
                                _offersController.reminderValue.value?'1':'0',
                                _offersController.newsAndUpdates.value?'1':'0',
                              );
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
                spacing(),
                Container(
                  decoration: customShadowedDecoration(buttonColor: Colors.white),
                  height: 60,
                  width: 90.w,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppSubtitleText(Text: "Reminder",color: Colors.black),
                        CustomSwitch(
                          value:  _offersController.reminderValue.value,
                          onChanged: (value) {
                            setState(() {
                              _offersController.reminderValue.value = !_offersController.reminderValue.value;
                              _offersController.changeNotificatiionSettings(
                                _offersController.newPerksOfferedValue.value?'1':'0',
                                _offersController.reminderValue.value?'1':'0',
                                _offersController.newsAndUpdates.value?'1':'0',
                              );
                            }
                            );
                          },

                        )
                      ],
                    ),
                  ),
                ),
                spacing(),
                Container(
                  decoration: customShadowedDecoration(buttonColor: Colors.white),
                  height: 60,
                  width: 90.w,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppSubtitleText(Text: "News & Updates",color: Colors.black),
                        CustomSwitch(
                          value:  _offersController.newsAndUpdates.value,
                          onChanged: (value) {
                            setState(() {
                              _offersController.newsAndUpdates.value = !_offersController.newsAndUpdates.value;
                              _offersController.changeNotificatiionSettings(
                                _offersController.newPerksOfferedValue.value?'1':'0',
                                _offersController.reminderValue.value?'1':'0',
                                _offersController.newsAndUpdates.value?'1':'0',
                              );
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
  Widget spacing(){
    return SizedBox(height: 20);

  }

}
