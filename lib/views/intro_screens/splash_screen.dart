import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/views/intro_screens/on_boarding_screen.dart';

import '../../api_services/notifications_services.dart';
import '../../api_services/push_notifications.dart';
import '../../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/main_user_model.dart';
import '../../utils/shared_preference.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();
  getData() async {

    Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();

    bool isLoggedIn = userStatus["isLoggedIn"];
    print(isLoggedIn.toString()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

    if (isLoggedIn==true) {
      _authController.accessToken.value = await AuthPreference.instance.getUserDataToken();
      _authController.getUserById();
      // print(await AuthPreference.instance.getUserData());
      // String result = await AuthPreference.instance.getUserData();
      // Map<String,dynamic> userMap = jsonDecode(result) as Map<String, dynamic>;
      // _authController.userData.value = MainUserModel.fromJson(userMap);
      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const CustomBottomBarr())));
    }else if(isLoggedIn==false){
      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const OnBoardingScreen())));
    }else{
      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const OnBoardingScreen())));
    }
  }
  OffersController _offersController=Get.find();
  @override
  initState() {

    super.initState();
    NotificationsServices notificationsServices = NotificationsServices();
    notificationsServices.requestNotificationsPermission();
    notificationsServices.getDeviceToken().then((value) async{
      log(value.toString()+'device tken');
      // roomController.updateFcmToken(value);
      _offersController.updateFcmTokenValue(value.toString());
      // bool isLoggedIn = await AuthPreference.instance.getUserLoggedIn();
      // _authController.accessToken.value = await AuthPreference.instance.getUserDataToken();
      // Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
      //
      // bool isLoggedIn = userStatus["isLoggedIn"];
      // if(isLoggedIn==true){
      //   // uncomment it later
      //   _offersController.updateFcmToken(value.toString());
      // }
    });
    notificationsServices.firebaseInit(context);

    PushNotifications.sendNotificationToSelectedDriver(_authController.token.toString());
    getData();
    _authController.getCuisines();
    _authController.getDiningTimes();
    _authController.getInterests();
        // Timer(
        //     const Duration(seconds: 4),
        //         () => Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => const OnBoardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xffF8E1C1),
      body: Column(
        children: [
          Spacer(),
          Center(child: Image.asset(AppIcons.splashScreenIcon,scale: 4.5)),
          Spacer(),
          SpinKitCircle(color: Colors.black,size: 60,),
          SizedBox(height: 70,)


        ],
      ),





    );
  }
}
