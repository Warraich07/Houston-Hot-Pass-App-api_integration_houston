import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:houstan_hot_pass/models/cuisines_model.dart';
import 'package:houstan_hot_pass/models/dining_times_model.dart';
import 'package:houstan_hot_pass/models/interests_model.dart';
import 'package:houstan_hot_pass/models/main_user_sign_up_model.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_in/sign_in_screen.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_up/sign_up_screeen.dart';
import 'package:houstan_hot_pass/views/intro_screens/on_boarding_screen.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../models/main_user_model.dart';
import '../utils/custom_dialog.dart';
import '../utils/shared_preference.dart';
import '../views/auth_screens/sign_in/otp_screen.dart';
import '../views/auth_screens/sign_in/reset_password_screen.dart';
import '../views/auth_screens/sign_up/complete_profile.dart';
import '../views/home/home_screen.dart';
import 'base_controller.dart';
import 'general_controller.dart';
import 'offers_controller.dart';


class AuthController extends GetxController {
  final AuthPreference _authPreference = AuthPreference.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController  passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController locationAreaController=TextEditingController();
  TextEditingController genderController=TextEditingController();
  TextEditingController genderControllerForPersonalInfo=TextEditingController();
  TextEditingController workAreaController=TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailControllerForgetPassword = TextEditingController();
  TextEditingController changePasswordController=TextEditingController();
  TextEditingController confirmChangePasswordController = TextEditingController();
  TextEditingController editProfileInfoFirstNameController = TextEditingController();
  TextEditingController editProfileInfoEmailController = TextEditingController();
  TextEditingController editProfileInfoLocationController = TextEditingController();
  TextEditingController editProfileInfoWorkAreaController = TextEditingController();
  TextEditingController editProfileInfoDineOutTimeController = TextEditingController();
  final GlobalKey<FormState> formKeySignUpScreen = GlobalKey();
  final GlobalKey<FormState> formKeyEditProfile = GlobalKey();
  final GlobalKey<FormState> formKeyResetPasswordScreen = GlobalKey();
  final GlobalKey<FormState> formKeyChangePasswordScreen = GlobalKey();
  final GlobalKey<FormState> formKeySignInScreen = GlobalKey();
  final GlobalKey<FormState> formKeyForgetPasswordScreen = GlobalKey();
  final GlobalKey<FormState> formKeyForCompleteProfile = GlobalKey();
  RxString imagePath=''.obs;
  RxString completeProfileImagePath=''.obs;
  RxString favouriteCuisines=''.obs;
  RxString averageSpending=''.obs;
  RxInt cuisineId=0.obs;
  RxList<String> cuisineIds=<String>[].obs;
  RxList<String> interestsIds=<String>[].obs;
  RxInt preferredDiningTimesId=0.obs;
  RxInt hobbiesId=0.obs;
  RxString preferredDiningTimes=''.obs;
  RxString dineOut=''.obs;
  RxString userLogInStatus=''.obs;
  RxString dineOutForPersonalInfo=''.obs;
  RxString hobbies=''.obs;
  RxString selectedAge=''.obs;
  RxInt firstAge=0.obs;
  RxInt lastAge=0.obs;
  RxInt firstCapitaValue=034.obs;
  RxInt lastCapitaValue=0.obs;
  RxString selectedGender=''.obs;
  RxString hotPassMemberShipAim=''.obs;
  RxBool showValidationMessage=false.obs;
 RxString userStatusForShowingPopups=''.obs;
  // DataModel Variables
  Rxn<MainUserLoginModel> userLoginData=Rxn<MainUserLoginModel>();
  Rxn<MainUserSignUpModel> userSignUpData=Rxn<MainUserSignUpModel>();
  // RxList<EditProfileModel> editProfileData=<EditProfileModel>[].obs;
  // for edit profile
  RxString selectedAgeForPersonalInfo=''.obs;
  RxInt firstAgeForPersonalInfo=0.obs;
  RxInt lastAgeForPersonalInfo=0.obs;
  RxString selectedGenderForPersonalInfo=''.obs;
  RxString averageSpendingForPersonalInfo=''.obs;
  RxInt firstCapitaValueForPersonalInfo=034.obs;
  RxInt lastCapitaValueForPersonalInfo=0.obs;
  RxString favouriteCuisinesForPersonalInfo=''.obs;
  RxInt cuisineIdForPersonalInfo=0.obs;
  RxList<String> cuisineIdsForPersonalInfo=<String>[].obs;
  RxString preferredDiningTimesForPersonalInfo=''.obs;
  RxInt preferredDiningTimesIdForPersonalInfo=0.obs;
  RxString hobbiesForPersonalInfo=''.obs;
  RxInt hobbiesIdForPersonalInfo=0.obs;
  RxList<String> interestsIdsForPersonalInfo=<String>[].obs;
  RxString hotPassMemberShipAimForPersonalInfo=''.obs;
  // Controllers
  final OffersController _offersController = Get.find();
  GeneralController _generalController=Get.find();
  final BaseController _baseController = BaseController.instance;


  RxString token = "".obs;
  RxString fcmToken = ''.obs;
  RxInt userType = 0.obs;
  String homeOwnerLat = "31.4504";
  String? homeOwnerLong = "73.1350";
  String? uploadImageUrlServiceProvider;
  String? uploadImageUrlHomeOwner;
  // File? uploadImageFileServiceProvider;
  // File? uploadImageFileCustomer;
  // final picker = ImagePicker();
  // XFile? pickedImage;
  RxString otpCode="".obs;
  RxString accessToken = "".obs;
  // RxString userIdForPusher = "".obs;
  RxString verifiedOtp=''.obs;
  RxString verifiedEmail=''.obs;
  RxString email=''.obs;
  RxString verifiedEmailForSendingOtp=''.obs;
  RxInt userID = 0.obs;
  RxInt completeProfileUserID = 0.obs;
  RxString emailForNaviagatingToHome=''.obs;
  RxString passwordForNaviagatingToHome=''.obs;
  // lists
  RxList<CuisinesModel> cuisinesList=<CuisinesModel>[].obs;
  RxList<DiningTimesModel> diningTimesList=<DiningTimesModel>[].obs;
  RxList<InterestsModel> interestsList=<InterestsModel>[].obs;

  Future completeProfile() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'age': jsonEncode({"from":firstAge.value,"to":lastAge.value}),
      'gender': selectedGender.value=="Prefer to self-describe"?genderController.text.toString():selectedGender.value,
      'residential_location': jsonEncode({"title":locationAreaController.text.toString(),"latitude":"94.39493","longitude":"94.58930"}),
      'commercial_location':jsonEncode({"title":workAreaController.text.toString(),"latitude":"94.39493","longitude":"94.58930"}),
      'avg_spending': jsonEncode({"from":firstCapitaValue.value, "to":lastCapitaValue.value}),
      for(int i=0;i<cuisineIds.length;i++)
        // 'videos_to_remove[$i]':deletedVideos[i]
      'cuisines[$i]': cuisineIds[i],
      'dining_times[]': preferredDiningTimesId.value.toString(),
      'often_dine_out': dineOut.value,
      for(int i=0;i<interestsIds.length;i++)
        'interests[$i]': interestsIds[i],
      'user_aim': hotPassMemberShipAim.value
    };
    var response = await DataApiService.instance
        .multiPartImage('user/complete-profile',[imagePath.value.toString()],"image",body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!',
            showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      print("profile completed");
      // from here
    loginUserToNavigateToHome(true);
      // to here
      // Get.offAll(() => const SignInScreen());
      firstAge.value=0;
      lastAge.value=0;
      selectedGender.value='';
      genderController.clear();
      locationAreaController.clear();
      workAreaController.clear();
      cuisineId.value=0;
      preferredDiningTimesId.value=0;
      dineOut.value='';
      hobbiesId.value=0;
      hotPassMemberShipAim.value='';
      imagePath.value='';
      selectedAge.value='';
      favouriteCuisines.value='';
      preferredDiningTimes.value='';
      hobbies.value='';
      firstCapitaValue.value=034;
      lastCapitaValue.value=0;
      averageSpending.value='';
      completeProfileImagePath.value='';
      // _authPreference.setUserLoggedIn(true)
    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
      // CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future editProfile() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'name': editProfileInfoFirstNameController.text,
      'age': jsonEncode({"from":firstAgeForPersonalInfo.value,"to":lastAgeForPersonalInfo.value}),
      'gender':  selectedGenderForPersonalInfo.value=="Prefer to self-describe"?genderControllerForPersonalInfo.text.toString():selectedGenderForPersonalInfo.value,
      'residential_location': jsonEncode({"title":editProfileInfoLocationController.text.toString(),"latitude":"31.398488","longitude":"73.161313"}),
      'commercial_location': jsonEncode({"title":editProfileInfoWorkAreaController.text.toString(),"latitude":"31.438256","longitude":"73.131790"}),
      'avg_spending': jsonEncode({"from":firstCapitaValueForPersonalInfo.value, "to":lastCapitaValueForPersonalInfo.value}),
      for(int i=0;i<cuisineIdsForPersonalInfo.length;i++)
      'cuisines[$i]': cuisineIdsForPersonalInfo[i],
      'dining_times[]': preferredDiningTimesIdForPersonalInfo.value.toString(),
      'often_dine_out': editProfileInfoDineOutTimeController.text.toString(),
      for(int i=0;i<interestsIdsForPersonalInfo.length;i++)
      'interests[$i]': interestsIdsForPersonalInfo[i],
      'user_aim': hotPassMemberShipAimForPersonalInfo.value
    };
    var response = await DataApiService.instance
        .multiPartImage('user/edit-profile',[imagePath.value.isEmpty?null:imagePath.value],"image",body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      // _offersController.offersList.clear();
      userLoginData.value=MainUserLoginModel.fromJson(result['data']);
      // Get.offAll(()=>const CustomBottomBarr());
      Get.back();
      _generalController.onBottomBarTapped(0);
    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
      // CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future sendOtpToVerifyUser(bool isResend,bool isFromLogin) async {
    // _baseController.showLoading();
    var response = await DataApiService.instance
        .get('user/send-verification-code')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });

    // _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
          verifiedOtp.value=result['data']['code'].toString();
          // Future.delayed(Duration(milliseconds: 100), () {
          //   Get.snackbar(
          //     'OTP',
          //     verifiedOtp.value,
          //     snackPosition: SnackPosition.TOP,
          //     backgroundColor: Colors.white, // Background color
          //     colorText: Colors.black, // Text color for better visibility
          //   );
          // });
          // if(isResend==true){
          //   // Get.back();
          // }
          // else{
          //   Get.to(()=>OtpScreen(isFromForgotPassword: false,isFromLoginScreen: isFromLogin,));
          //
          // }
          // Future.delayed(Duration(seconds: 2));
          // emailController.clear();
          // passwordController.clear();
          // if(isFromLogin==true){
          //   Get.back();
          // }
      // emailController.clear();
      // passwordController.clear();
      // nameController.clear();
      // confirmPasswordController.clear();

    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message,);

    }

  }

  Future verifyOtpToVerifyUser(String otp) async {

    _baseController.showLoading();
    Map<String, String> body = {
      'otp': otp
    };
    var response = await DataApiService.instance
        .post('user/verify-user',body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      Get.to(()=>CompleteProfileScreen());
    } else {
      // List<dynamic> errorMessage=result['message'];
      // String message=errorMessage.join();
      if(result['message']=="Already Verified!"){
        CustomDialog.showErrorDialog(title: 'Already Verified!', showTitle: true,description: result['message'],buttonText: "Continue",
            onTap: (){
              Get.to(()=>CompleteProfileScreen());
            });
      }else{
        List<dynamic> errorMessage=result['message'];
        String message=errorMessage.join();

        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
        // _baseController.hideLoading();

      }

    }
  }

  Future verifyOtpToResetPassword(String otp) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': email.value,
      'otp': otp
    };
    var response = await DataApiService.instance
        .post('user/reset-password-otp-verification',body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      verifiedOtp.value=otp;
      Get.to(()=>ResetPasswordScreen());
      // emailControllerForgetPassword.clear();

    } else {
      // List<dynamic> errorMessage=result['message'];
      // String message=errorMessage.join();
      if(result['message']=="Already Verified!"){
        CustomDialog.showErrorDialog(title: 'Already Verified!', showTitle: true,description: result['message'],buttonText: "Continue",
            onTap: (){
              Get.to(()=>ResetPasswordScreen());
            });
      }else{
        List<dynamic> errorMessage=result['message'];
        String message=errorMessage.join();
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message,);

      }

    }
  }
  // Future editProfile(String name,String email,String age,String gender) async {
  //   _baseController.showLoading();
  //   Map<String, String> body = {
  //     'name': name,
  //     'email': email,
  //     'age': age,
  //     'gender': gender
  //   };
  //   var response = await DataApiService.instance
  //       .post('/edit-profile', body)
  //       .catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     } else {
  //       var apiError = json.decode(error.message!);
  //       CustomDialog.showErrorDialog(description: apiError["reason"]);
  //     }
  //   });
  //   update();
  //   _baseController.hideLoading();
  //   if (response == null) return;
  //   print(response+ "responded");
  //   // print(result['success'])
  //   var result = json.decode(response);
  //   if (result['success']) {
  //     // Get.back();
  //     // _generalController.onBottomBarTapped(0);
  //     // editProfileData.value = List<EditProfileModel>.from(
  //     //     result['data'].map((x) => EditProfileModel.fromJson(x)));
  //     // userData.value!.name=editProfileData.first.name;
  //     // userData.value!.email=editProfileData.first.email;
  //     // userData.value!.age=editProfileData.first.age;
  //     // userData.value!.gender=editProfileData.first.gender;
  //     // _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
  //     //
  //     // PageTransition.pageProperNavigation(page: CustomBottomNavBar());
  //
  //   } else {
  //     CustomDialog.showErrorDialog(description: result['message']);
  //   }
  // }

  Future resetPassword() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': email.value,
      'otp': verifiedOtp.value,
      'password': changePasswordController.text.toString(),
      'password_confirmation': confirmChangePasswordController.text.toString()
    };
    var response = await DataApiService.instance
        .Auth('user/reset-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {

      CustomDialog.profileCompleted(
        title: 'Success!', showTitle: true,
        description: "Password Changed",
        buttonText: "Continue",
        onTap: () {
          Get.offAll(() => SignInScreen());
        },
      );

      // CustomDialog.showProfileCompleteDialog(
      //   description: "Password Changed",
      //   buttonText: "Continue",
      //   onTap: () {
      //   Get.offAll(() => SignInScreen());
      // },
      // );
      Future.delayed(Duration(milliseconds: 100),(){
        emailControllerForgetPassword.clear();
        changePasswordController.clear();
        confirmChangePasswordController.clear();
        passwordController.clear();
      });

    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
    }
  }

  Future createNewPassword(String oldPassword,String newPassword,String confirmNewPassword) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'old_password': oldPassword,
      'password': newPassword,
      'password_confirmation': confirmNewPassword
    };
    var response = await DataApiService.instance
        .post('/change-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {

      // Get.offAll(() => Login());


    } else {
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: result['message']);
    }
  }

  Future verifyOtp() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': verifiedEmail.value,
      'otp': otpCode.value
    };
    var response = await DataApiService.instance
        .post('/verify-otp', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      // Get.to(() => ChangePassword());


    } else {
      if(result['message']=="Incorrect otp"){
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: "Invalid OTP");
      }else{
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: result['message']);

      }
    }
  }

  Future loginUser(bool isFromLogin) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString()
    };
    var response = await DataApiService.instance
        .post('user/login', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {

      // these two are for login user and navigating to home if not signed up completely
      emailForNaviagatingToHome.value=emailController.text.toString();
      passwordForNaviagatingToHome.value=passwordController.text.toString();
      // userLoginData.value=MainUserLoginModel.fromJson(result['data']);
      accessToken.value=result['token'];
      // userLoginData.value!.isVerified==result['data']["is_verified"];
      // userLoginData.value!.hasProfileAdded==result['data']["has_profile_added"];


      _authPreference.saveUserData(token: jsonEncode(userLoginData.value.toString()));
      // general

      if(result['data']["is_verified"]==true){
        if(result['data']["has_profile_added"]==true){
          _offersController.userIdForPusher.value=result['data']['id'].toString();
          userLoginData.value=MainUserLoginModel.fromJson(result['data']);
          _authPreference.setUserLoggedIn(true);
          _authPreference.saveUserDataToken(token: accessToken.value);

          Get.offAll(()=>const CustomBottomBarr());
          Future.delayed(Duration(seconds: 4),(){
            emailController.clear();
            passwordController.clear();
          });

        }else{
          Get.to(()=>const CompleteProfileScreen());
          Future.delayed(Duration(seconds: 4));
          emailController.clear();
          passwordController.clear();
        }
      }else{
        sendOtpToVerifyUser(false,true);
        // Get.to(()=>const CustomBottomBarr());

      }
      // Get.to(()=>const CustomBottomBarr());
      _generalController.onBottomBarTapped(0);


    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);

    }
  }

  Future loginUserToNavigateToHome(bool isFromLogin) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': emailForNaviagatingToHome.value,
      'password': passwordForNaviagatingToHome.value
    };
    var response = await DataApiService.instance
        .post('user/login', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      _offersController.userIdForPusher.value=result['data']['id'].toString();
      accessToken.value=result['token'];
      _authPreference.saveUserData(token: jsonEncode(userLoginData.value.toString()));
          Get.to(()=>const CustomBottomBarr());
      CustomDialog.profileCompleted(title: 'Success!',description: "Profile Completed Successfully.",buttonText: 'Continue',showTitle: true);
      userLoginData.value=MainUserLoginModel.fromJson(result['data']);
          _authPreference.setUserLoggedIn(true);
          _authPreference.saveUserDataToken(token: accessToken.value);
          Future.delayed(Duration(seconds: 4),(){
            emailController.clear();
            passwordController.clear();
          });
      _generalController.onBottomBarTapped(0);
    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(showTitle:true,description: message,title: "Error!");

    }
  }

  saveOtp(String otp){
    otpCode.value=otp;
  }


  updateOtpCode(String otp){
    otpCode.value=otp;
  }


  Future signUp(bool isFromLogin) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'name': nameController.text.toString(),
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
      'password_confirmation': confirmPasswordController.text.toString()
    };
    var response = await DataApiService.instance
        .post('user/signup', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      emailForNaviagatingToHome.value=emailController.text.toString();
      passwordForNaviagatingToHome.value=passwordController.text.toString();
      userSignUpData.value=MainUserSignUpModel.fromJson(result['data']);
      accessToken.value=result['token'];
      Get.to(()=>OtpScreen(isFromForgotPassword: false,isFromLoginScreen: isFromLogin,));

      sendOtpToVerifyUser(false,isFromLogin);
      verifiedEmailForSendingOtp.value=emailController.text.toString();
      // general
      // await Future.delayed(Duration(seconds: 4));
      // emailController.clear();
      // passwordController.clear();
      // nameController.clear();
      // confirmPasswordController.clear();
      // Get.to(()=>const CompleteProfileScreen());

    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
    }
  }
  Future getCuisines() async {
    var response = await DataApiService.instance
        .get('get-cuisines')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      }
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      cuisinesList.value = List<CuisinesModel>.from(result['data'].map((x) => CuisinesModel.fromJson(x)));
    } else {

    }
  }
  Future getDiningTimes() async {
    var response = await DataApiService.instance
        .get('get-dining-times')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      }
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      diningTimesList.value = List<DiningTimesModel>.from(result['data'].map((x) => DiningTimesModel.fromJson(x)));
    } else {

    }
  }
  Future getInterests() async {
    var response = await DataApiService.instance
        .get('get-interests')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      }
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      interestsList.value = List<InterestsModel>.from(result['data'].map((x) => InterestsModel.fromJson(x)));
    } else {

    }
  }

  Future getUserById() async {
    var response = await DataApiService.instance
        .get('user/get-user')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      }
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      userLoginData.value=MainUserLoginModel.fromJson(result['data']);
      _offersController.userIdForPusher.value=result['data']['id'].toString();
      accessToken.value=result['token'];
      _offersController.newPerksOfferedValue.value=userLoginData.value!.notificationSettings.newPerks;
      _offersController.newsAndUpdates.value=userLoginData.value!.notificationSettings.newsUpdates;
      _offersController.reminderValue.value=userLoginData.value!.notificationSettings.reminders;
    } else {

    }
  }
  Future changePassword() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'password': passwordController.text.toString(),
      'password_confirmation':  confirmPasswordController.text.toString(),
      'old_password': oldPasswordController.text.toString(),
      'email': userLoginData.value!.email
    };
    var response = await DataApiService.instance
        .post('user/reset-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);

      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      Get.offAll(()=>SignInScreen());
      CustomDialog.showErrorDialog(
        title: 'Success!',
        showTitle: true,
          iconPath: AppIcons.successIcon,
          description: "Password Changed Successfully",buttonText: "Continue",onTap: (){
        Get.back();
      });

      _generalController.onBottomBarTapped(0);
      _authPreference.setUserLoggedIn(false);
      Future.delayed(Duration(seconds: 3));
      passwordController.clear();
      confirmPasswordController.clear();
      oldPasswordController.clear();
    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
    }
  }

  Future sendOtpCode() async {
    // _baseController.showLoading();
    Map<String, String> body = {
      'email': emailControllerForgetPassword.text.isEmpty?verifiedEmailForSendingOtp.value:emailControllerForgetPassword.text.toString(),
    };
    var response = await DataApiService.instance
        .post('user/forgot-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });
    update();
    // _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
        email.value=emailControllerForgetPassword.text.toString();
      // please uncomment it
      print(result['data']['code']);
      // CustomDialog.showErrorDialog(description: result['data']['otp']);
      verifiedOtp.value=result['data']['code'].toString();

      // verifiedEmail.value=email;
      // Future.delayed(Duration(seconds: 2), () {
      //   Get.snackbar(
      //     'OTP',
      //     verifiedOtp.value,
      //     snackPosition: SnackPosition.TOP,
      //     backgroundColor: Colors.white, // Background color
      //     colorText: Colors.black,  // Text color for better visibility
      //   );
      //   // emailController.clear();
      // });
      Get.to(()=>OtpScreen(isFromForgotPassword: true,isFromLoginScreen:false));

    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
    }
  }

void updateImagePath(String path){
  imagePath.value=path;
}
  void completeProImagePath(String path){
    completeProfileImagePath.value=path;
  }
  void updateShowValidationMessage(bool value){
    showValidationMessage.value=value;
  }
  void getUserLogInStatus()async{
    Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
    bool isLoggedIn = userStatus["isLoggedIn"];
    userLogInStatus.value=isLoggedIn.toString();
  }
  void updateSelectedAge(String value){
    selectedAge.value=value;
  }
  void updateSelectedAgeForPersonalInfo(String value){
    selectedAgeForPersonalInfo.value=value;
  }
  void updateAverageSpending(String value){
    averageSpending.value=value;
  }
  void updateAverageSpendingForPersonalInfo(String value){
    averageSpendingForPersonalInfo.value=value;
  }
  void updateFirstAndLastAge(int fAge,int lAge){
    firstAge.value=fAge;
    lastAge.value=lAge;
  }
  void updateFirstAndLastAgeFOrPersonalInfo(int fAge,int lAge){
    firstAgeForPersonalInfo.value=fAge;
    lastAgeForPersonalInfo.value=lAge;
    if(firstAgeForPersonalInfo.value==65){
      selectedAgeForPersonalInfo.value=' 65 and older';
    }

  }
  void updatePerCapitas(int fValue,int sValue){
    firstCapitaValue.value=fValue;
    lastCapitaValue.value=sValue;
  }
  void updatePerCapitasForPersonalInfo(int fValue,int sValue){
    firstCapitaValueForPersonalInfo.value=fValue;
    lastCapitaValueForPersonalInfo.value=sValue;
    if(firstCapitaValueForPersonalInfo.value.toString()=='150'){
      averageSpendingForPersonalInfo.value=' Over \$150';
    }
    if(firstCapitaValueForPersonalInfo.value.toString()=='0'){
      averageSpendingForPersonalInfo.value='Under \$25';
    }

  }
  void updateSelectedGender(String value){
    selectedGender.value=value;
  }
  void updateSelectedGenderForPersonalInfo(String value){
    selectedGenderForPersonalInfo.value=value[0].toUpperCase() + value.substring(1);
  }
  void updateHotPassMemberShipAim(String value){
    hotPassMemberShipAim.value=value;
  }
  void updateHotPassMemberShipAimForPersonalInfo(String value){
    hotPassMemberShipAimForPersonalInfo.value=value;
  }
  void updateFavoriteCuisines(String value,int id,List<String> cuisinesId){
    favouriteCuisines.value=value;
    cuisineId.value=id;
    cuisineIds.value=cuisinesId;
  }
  void updateFavoriteCuisinesForPersonalInfo(String value,List<String> cuisinesId){
    favouriteCuisinesForPersonalInfo.value=value;


    cuisineIdsForPersonalInfo.value=cuisinesId;
  }
  void updatePreferredDiningTimes(String value,int id){
    preferredDiningTimes.value=value;
    preferredDiningTimesId.value=id;
  }
  void updatePreferredDiningTimesForPersonalInfo(String value,int id){
    preferredDiningTimesForPersonalInfo.value=value;
    preferredDiningTimesIdForPersonalInfo.value=id;
  }
  void updateDineOut(String value){
    dineOut.value=value;
  }
  void updateDineOutInPersonalInfo(String value){
    dineOutForPersonalInfo.value=value;
  }
  void updateDineOutInPersonalInfoController(String value){
    editProfileInfoDineOutTimeController.text=value;
  }
  void updateEmail(String value){
    email.value=value;
  }
  void updateHobbies(String value,int id,List<String> interestsId){
    hobbies.value=value;
    hobbiesId.value=id;
    interestsIds.value=interestsId;
  }
  void updateHobbiesForPersonalInfo(String value,List<String> interestsId){
    hobbiesForPersonalInfo.value=value;
    interestsIdsForPersonalInfo.value=interestsId;
  }
  // to show signUp or logIn popup if user on profile screen if user is not signed up or logged in
  void savedLogInStatusOfUser()async{
    Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
    bool status = userStatus["isLoggedIn"];
    userStatusForShowingPopups.value=status.toString();
    // if(userStatusForShowingPopups.value==''){
    //   CustomDialog.showPopUpDialog(description: "Please SignUp",onTap: (){
    //     Get.offAll(()=>const SignUpScreeen());
    //   });
    // }else  if(userStatusForShowingPopups.value=='false'){
    //   CustomDialog.showPopUpDialog(description: "Please LogIn",onTap: (){
    //     Get.offAll(()=>const SignInScreen());
    //
    //   });
    // }

  }
  void showPopUps()async{
    if(userStatusForShowingPopups.value==''){
      CustomDialog.showPopUpDialog(
        onTapCancel: (){
          Get.back();
          _generalController.onBottomBarTapped(0);
          // Get.offAll(() => const CustomBottomBarr());
        },
          buttonText: 'SignUp',
          description: "Please Sign Up to Access Your Account",onTap: (){
        //     Get.back();
        // _generalController.onBottomBarTapped(0);
        // Get.off(() => const CustomBottomBarr());
        Get.offAll(()=>const SignInScreen());
      });
    }else  if(userStatusForShowingPopups.value=='false'){
      CustomDialog.showPopUpDialog(
          onTapCancel: (){
            Get.back();
            _generalController.onBottomBarTapped(0);
            // Get.offAll(() => const CustomBottomBarr());
          },
          buttonText: 'Sign In',
          description: "Please Sign In to Access Your Account",onTap: (){
        // Get.back();
        // _generalController.onBottomBarTapped(0);
        // Get.off(() => const CustomBottomBarr());
        Get.offAll(()=>const SignInScreen());

      });
    }

  }
}
