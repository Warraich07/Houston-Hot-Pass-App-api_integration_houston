import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:houstan_hot_pass/controllers/timer_controller.dart';
import 'package:houstan_hot_pass/models/faqs_model.dart';
import 'package:houstan_hot_pass/models/featured_blogs_model.dart';
import 'package:houstan_hot_pass/models/redeemed_offers_model.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../api_services/api_exceptions.dart';
import '../api_services/api_urls.dart';
import '../api_services/data_api.dart';
import '../app_widgets/alertbox.dart';
import '../constants/app_icons.dart';
import '../models/blogs_model.dart';
import '../models/main_user_model.dart';
import '../models/nearby_offers_model.dart';
import '../models/notifications_model.dart';
import '../models/offers_model.dart';
import '../utils/custom_dialog.dart';
import 'auth_controller.dart';
import 'base_controller.dart';
import 'package:http/http.dart' as http;
class OffersController extends GetxController {
  final BaseController _baseController = BaseController.instance;
  RxList<OffersModel> offersList=<OffersModel>[].obs;
  RxList<FaqsModel> faqsList=<FaqsModel>[].obs;
  RxList<OffersModel> filteredList=<OffersModel>[].obs;
  RxList<OffersModel> filteredOfferTypesList=<OffersModel>[].obs;
  RxList<RedeemedOffersModel> redeemedOffersList=<RedeemedOffersModel>[].obs;
  RxList<NearbyOffersModel> nearbyOffersList=<NearbyOffersModel>[].obs;
  RxList<NearbyOffersModel> filteredOffersOfRestaurantList=<NearbyOffersModel>[].obs;
  RxBool isLoading=false.obs;
  RxBool isLoadingForHome=false.obs;
  RxBool isLoadingFilteredNearbyOffers=false.obs;
  RxBool isPullUp=false.obs;
  RxInt homeOffersCurrentPage=0.obs;
  RxInt homeOffersLastPage=0.obs;
  RxInt searchedOffersCurrentPage=0.obs;
  RxInt searchedOffersLastPage=0.obs;
  RxInt filteredOffersCurrentPage=0.obs;
  RxInt filteredOffersLastPage=0.obs;
  RxInt nearbyOffersCurrentPage=0.obs;
  RxInt nearbyOffersLastPage=0.obs;
  RxInt redeemedOffersCurrentPage=0.obs;
  RxInt redeemedOffersLastPage=0.obs;
  final focusNodeForHome=FocusNode();
  final focusNodeForBlogs=FocusNode();
  RxBool showQrCode = false.obs;
  RxString codeType = ''.obs;
  RxString qrCodeDataForRedeemingOffer=''.obs;
  RxString fcmToken=''.obs;
  Position? currentPosition;
  Rxn<double> lattitude = Rxn<double>();
  Rxn<double> longitude = Rxn<double>();
  TimerController _timerController=Get.find();
  RxString selectedDate='today'.obs;
  RxList<BlogsModel> blogsList=<BlogsModel>[].obs;
  RxList<BlogsModel> filteredBlogsList=<BlogsModel>[].obs;
  RxList<BlogsModel> filteredCuisineBlogsList=<BlogsModel>[].obs;
  RxList<String> featuredImagesList = <String>[].obs;
  RxList<String> featuredImagesHeadingList = <String>[].obs;
  RxString adminEmail=''.obs;
  RxList<FeaturedBlogsModel> featuredBlogsList=<FeaturedBlogsModel>[].obs;

  RxInt blogsCurrentPage=0.obs;
  RxInt blogsLastPage=0.obs;
  RxInt filteredBlogsCurrentPage=0.obs;
  RxInt filteredBlogsLastPage=0.obs;
  RxInt filteredCuisineBlogsCurrentPage=0.obs;
  RxInt filteredCuisineBlogsLastPage=0.obs;
  Rxn<MainUserLoginModel> userLoginData=Rxn<MainUserLoginModel>();
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  PusherChannel? challengePresence;
  RxString userIdForPusher = "".obs;
  RxBool newPerksOfferedValue = true.obs;
  RxBool newsAndUpdates = true.obs;
  RxBool reminderValue = true.obs;
  RxList<NotificationsData> notificatonsList=<NotificationsData>[].obs;

  Future markAsRead(String notificationId) async {
    Map<String, String> body = {
      'notification_id': notificationId
    };
    var response = await DataApiService.instance
        .post('user/mark-as-read', body)
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        // CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // userLoginData.value=MainUserLoginModel.fromJson(result['data']);
    } else {
      // CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future getNotifications() async {
    Future.microtask(() async {
      isLoading.value=true;

      var response = await DataApiService.instance
          .get('user/notifications')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        notificatonsList.value = List<NotificationsData>.from(result['data'].map((x) => NotificationsData.fromJson(x)));
        // log(notificatonsList.first.notificationData);
      } else {

      }});
  }

  Future changeNotificatiionSettings(String newPerks,String reminders,String newUpdates) async {
    Map<String, String> body = {
      'new_perks': newPerks,
      'reminders': reminders,
      'news_updates': newUpdates
    };
    var response = await DataApiService.instance
        .post('user/edit-notification-settings', body)
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        // CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      userLoginData.value=MainUserLoginModel.fromJson(result['data']);
    } else {
      // CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future getFeaturedBlogs() async {
    Future.microtask(() async {
        isLoading.value=true;

      var response = await DataApiService.instance
          .get('user/get-featured-blogs')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        featuredBlogsList.value = List<FeaturedBlogsModel>.from(result['data'].map((x) => FeaturedBlogsModel.fromJson(x)));
        featuredImagesList.value= featuredBlogsList.map((e){return e.offer==null?e.images.first.toString():e.offer!.image.toString();}).toList();
        featuredImagesHeadingList.value=featuredBlogsList.map((e){return e.title.toString();}).toList();
        print(featuredImagesList.length.toString()+">>>>>>>>>>>>>>>>>>>>featured list");
      } else {

      }});
  }

  Future getBlogs(bool isPagination) async {

    Future.microtask(() async {
      isPullUp.value=true;
      if(!isPagination){
        isLoading.value=true;
      }
      var response = await DataApiService.instance
          .get('user/get-blogs?page=${blogsCurrentPage.value}')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isPullUp.value=true;
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        if(blogsList.isEmpty){
          blogsList.value = List<BlogsModel>.from(result['data']['data'].map((x) => BlogsModel.fromJson(x)));
        }else{
          blogsList.addAll(List<BlogsModel>.from(result['data']['data'].map((x) => BlogsModel.fromJson(x))));
        }
        blogsCurrentPage.value=result['data']['current_page'];
        blogsLastPage.value=result['data']['last_page'];
      } else {

      }});
  }

  Future filterBlogs(bool isPagination,String keyword) async {
    filteredBlogsList.clear();
    filteredBlogsCurrentPage.value=0;
    filteredBlogsLastPage.value=0;
    Future.microtask(() async {
      isPullUp.value=true;
      if(!isPagination){
        isLoading.value=true;
      }
      String searchedKeyword=keyword.contains('#')?keyword.replaceFirst('#', '%23'):keyword;

      var response = await DataApiService.instance
          .get('user/get-blogs?keyword=$searchedKeyword')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isPullUp.value=true;
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        // focusNodeForBlogs.unfocus();
        if(filteredBlogsList.isEmpty){
          filteredBlogsList.value = List<BlogsModel>.from(result['data']['data'].map((x) => BlogsModel.fromJson(x)));
        }else{
          filteredBlogsList.addAll(List<BlogsModel>.from(result['data']['data'].map((x) => BlogsModel.fromJson(x))));
        }
        filteredBlogsCurrentPage.value=result['data']['current_page'];
        filteredBlogsLastPage.value=result['data']['last_page'];
      } else {

      }});
  }

  Future getNearByOffers(String lattitude,String longitude) async {
    // _baseController.showLoading();
    isLoading.value=true;
    Map<String, String> body = {
      'latitude': lattitude,
      'longitude': longitude
    };
    var response = await DataApiService.instance
        .post('user/get-nearby-offers', body)
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        // CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        // _baseController.handleError(error);
      }
    });
    update();
    // _baseController.hideLoading();
    isLoading.value=false;
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // if(nearbyOffersList.isEmpty){
        nearbyOffersList.value = List<NearbyOffersModel>.from(result['data'].map((x) => NearbyOffersModel.fromJson(x)));
      // }else{
      //   nearbyOffersList.addAll(List<NearbyOffersModel>.from(result['data']['data'].map((x) => NearbyOffersModel.fromJson(x))));
      // }
      // nearbyOffersCurrentPage.value=result['data']['current_page'];
      // nearbyOffersLastPage.value=result['data']['last_page'];
    } else {
      // CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future filterNearByOffersForRestaurant(String lattitude,String longitude,String restaurantId) async {
    // _baseController.showLoading();
    isLoadingFilteredNearbyOffers.value=true;
    Map<String, String> body = {
      'latitude': lattitude,
      'longitude': longitude
    };
    var response = await DataApiService.instance
        .post('user/get-nearby-offers', body)
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        // CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        // _baseController.handleError(error);
      }
    });
    update();
    // _baseController.hideLoading();
    isLoadingFilteredNearbyOffers.value=false;
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // if(nearbyOffersList.isEmpty){
        nearbyOffersList.value = List<NearbyOffersModel>.from(result['data'].map((x) => NearbyOffersModel.fromJson(x)));
        filteredOffersOfRestaurantList.value = nearbyOffersList.where((e) => e.restuarant.id.toString() == restaurantId).toList();
        print(filteredOffersOfRestaurantList.length.toString()+'lengthZZ>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');

      // }else{
      //   nearbyOffersList.addAll(List<NearbyOffersModel>.from(result['data']['data'].map((x) => NearbyOffersModel.fromJson(x))));
      //   filteredOffersOfRestaurantList.addAll(List<NearbyOffersModel>.from(result['data']['data'].map((x) => NearbyOffersModel.fromJson(x))));
      //
      // }
      // nearbyOffersCurrentPage.value=result['data']['current_page'];
      // nearbyOffersLastPage.value=result['data']['last_page'];
    } else {
      // CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  // Pusher Implementation Start
  getData(String offerId) async {
    try {
      await pusher.init(
          apiKey: "9e4fec219ac465423f09",
          cluster: "ap2",
          onConnectionStateChange: onConnectionStateChange,
          onError: onError,
          onSubscriptionSucceeded: onSubscriptionSucceeded,
          onEvent: onEvent,
          onSubscriptionError: onSubscriptionError,
          onDecryptionFailure: onDecryptionFailure,
          onMemberAdded: onMemberAdded,
          onMemberRemoved: onMemberRemoved,
          onSubscriptionCount: onSubscriptionCount,
          onAuthorizer: onAuthorizer);

      challengePresence = await pusher.subscribe(
        channelName: "private-user-${userIdForPusher.value}-offer-${offerId}",
      );
      print(challengePresence!.channelName+"channel name");
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  getSignature(String value) {
    var key = utf8.encode('e2e5da1cd9b8f2cbb5fe');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key);// HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    print(socketId);
    print(options);
    print(channelName);
    String url = "https://houstonhotpass.beckcircle.com/api/user/pusher-authentication";
    print(url);
    var result = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer ${Get.put(AuthController()).accessToken.value}',
        // 'X-TIMEZONE': 'Asia/Karachi',
        // 'X-LANG': 'en',
        "auth":
        "9e4fec219ac465423f09:${getSignature("$socketId:$channelName")}",
      },
      body: 'socket_id=' + socketId + '&channel_name=' + channelName,
    );
    var json = jsonDecode(result.body);
    return json;
    // return {
    //   "auth":
    //   "d7d4887bfd77b8ede0a7:${getSignature("$socketId:$channelName")}",
    // };
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  Future<void> onEvent(PusherEvent event) async {
    print("...there is something");
    print(event.eventName);
    log(event.data.toString());

    if (event.eventName == "offer_redeemed") {
      var result = json.decode(event.data);
      Get.back(); // Close dialog
      Get.back(); // Navigate back
      Get.dialog(

        CustomAlertDialog(
          heading: "Offer Redeemed Successfully",
          subHeading: "Congratulations! Discount Offer has been redeemed successfully. Enjoy your meal ☺️!",
          buttonName: "Great",
          img: AppIcons.successIcon,
          onTapped: () {
            Get.back(); // Close dialog
            // Get.back(); // Navigate back
          },

        ),
      );
      update();
    }
    // if (event.eventName == "send_user_contest_content") {
    //   var result = json.decode(event.data);
    // }
    // if (event.eventName == "reload_content_views") {
    //   Map<String, dynamic> result = jsonDecode(json.decode(event.data));
    //   print(result['content_id']);
    //   contentController.increaseViewsFunction(result);
    //   update();
    // }
    // if (event.eventName == "reload_content_likes") {
    //   Map<String, dynamic> result = jsonDecode(json.decode(event.data));
    //   print(result['content_id']);
    //   contentController.increaseLikeFunction(result);
    // }
    // if (event.eventName == "reload_winning_participants") {
    //   var result = json.decode(event.data);
    //   contestLiveWinners.value = RxList<ContestLiveWinnersModel>.from(
    //       result.map((x) => ContestLiveWinnersModel.fromJson(x)));
    //   update();
    // }
    // if (event.eventName == "sendEndedContest") {
    //   var result = json.decode(event.data);
    // }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }
  // Pusher Implementation End

  Future redeemOffer(String offerId,BuildContext context) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'offer_id': offerId
    };
    var response = await DataApiService.instance
        .post('user/redeem-offer', body)
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
    var result = json.decode(response);
    if (result['success']) {

      print(result['type'].toString()+"this is code");
      if(result['type']=='qr_code'){
        codeType.value='qr_code';
        showQrCode.value = true;
        qrCodeDataForRedeemingOffer.value=result['code'];

        print(qrCodeDataForRedeemingOffer.value);
        _timerController.resendOtp();
      }else{
        showQrCode.value = true;
        codeType.value='code';
        qrCodeDataForRedeemingOffer.value=result['code'];
        _timerController.resendOtp();
      }

      // Get.offAll(() => Login());

        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return CustomAlertDialog(
        //       heading: "Offer Redeemed successfully",
        //       subHeading: "Congratulations! Discount Offer has been redemmed successfully.enjoy your meal ☺️!",
        //       buttonName: "Great",img: AppIcons.successIcon,onTapped: () {
        //       Get.back();
        //       Get.back();
        //     },);
        //   },
        // );


    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(description: message,title: "Error!",showTitle: true);
    }
  }

  Future updateFcmToken(String tokenId) async {
    // _baseController.showLoading();
    Map<String, String> body = {
      'token': tokenId,
    };
    var response = await DataApiService.instance
        .post('user/save-fcm', body)
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
    var result = json.decode(response);
    if (result['success']) {
    print('fcm token updated');
    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
    }
  }


  Future getOffers(bool isPagination) async {

    Future.microtask(() async {
      isPullUp.value=true;
      if(!isPagination){
        isLoadingForHome.value=true;
      }
    var response = await DataApiService.instance
        .get('user/get-offers?page=${homeOffersCurrentPage.value}')
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        // CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        // _baseController.handleError(error);
      }
    });
      isPullUp.value=false;
      isLoadingForHome.value=false;
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      if(offersList.isEmpty){
        offersList.value = List<OffersModel>.from(result['data']['data'].map((x) => OffersModel.fromJson(x)));
      }else{
        offersList.addAll(List<OffersModel>.from(result['data']['data'].map((x) => OffersModel.fromJson(x))));
      }
        homeOffersCurrentPage.value=result['data']['current_page'];
        homeOffersLastPage.value=result['data']['last_page'];
    } else {

    }});
  }

  Future searchOffers(bool isPagination,String searchQuery,) async {
    Future.microtask(() async {
      // if(!isPagination){
        isLoading.value=true;
      // }
      var response = await DataApiService.instance
          .get('user/get-offers?keyword=$searchQuery&page=$searchedOffersCurrentPage')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        if(filteredList.isEmpty){
          filteredList.value = List<OffersModel>.from(result['data']['data'].map((x) => OffersModel.fromJson(x)));
        }else{
          filteredList.addAll(List<OffersModel>.from(result['data']['data'].map((x) => OffersModel.fromJson(x))));
        }
        searchedOffersCurrentPage.value=result['data']['current_page'];
        searchedOffersLastPage.value=result['data']['last_page'];
      } else {

      }});
  }

  Future getSearchOffers(bool isPagination,String searchQuery,) async {
    Future.microtask(() async {
      // if(!isPagination){
      isLoading.value=true;
      // }
      String searchedKeyword=searchQuery.contains('#')?searchQuery.replaceFirst('#', '%23'):searchQuery;
      var response = await DataApiService.instance
          .get('user/get-offers?keyword=$searchedKeyword&page=1')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {

          filteredList.value = List<OffersModel>.from(result['data']['data'].map((x) => OffersModel.fromJson(x)));
        searchedOffersCurrentPage.value=0;
        searchedOffersLastPage.value=0;
      } else {

      }});
  }

  Future getSearchOffersOnMapScreen(bool isPagination,String searchQuery,) async {
    Future.microtask(() async {
      // if(!isPagination){
      isLoading.value=true;
      // }
      var response = await DataApiService.instance
          .get('user/get-offers?keyword=$searchQuery&page=1')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {

        filteredOffersOfRestaurantList.value = List<NearbyOffersModel>.from(result['data']['data'].map((x) => NearbyOffersModel.fromJson(x)));
        searchedOffersCurrentPage.value=0;
        searchedOffersLastPage.value=0;
        if(filteredOffersOfRestaurantList.isEmpty){
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: "No results found");

        }
      } else {

      }});
  }

  Future filterOfferTypes(bool isPagination,String searchQuery) async {
    Future.microtask(() async {
      // if(!isPagination){
      isLoading.value=true;
      // }
      var response = await DataApiService.instance
          .get('user/get-offers?keyword=$searchQuery&page=$filteredOffersCurrentPage')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        if(filteredOfferTypesList.isEmpty){
          filteredOfferTypesList.value = List<OffersModel>.from(result['data']['data'].map((x) => OffersModel.fromJson(x)));
        }else{
          filteredOfferTypesList.addAll(List<OffersModel>.from(result['data']['data'].map((x) => OffersModel.fromJson(x))));
        }
        filteredOffersCurrentPage.value=result['data']['current_page'];
        filteredOffersLastPage.value=result['data']['last_page'];
      } else {

      }});
  }

  Future filterBlogsTypes(bool isPagination,String searchQuery) async {
    Future.microtask(() async {
      // if(!isPagination){
      isLoading.value=true;
      // }
      var response = await DataApiService.instance
          .get('user/get-blogs?cuisine=$searchQuery&page=$filteredCuisineBlogsCurrentPage')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        if(filteredCuisineBlogsList.isEmpty){
          filteredCuisineBlogsList.value = List<BlogsModel>.from(result['data']['data'].map((x) => BlogsModel.fromJson(x)));
        }else{
          filteredCuisineBlogsList.addAll(List<BlogsModel>.from(result['data']['data'].map((x) => BlogsModel.fromJson(x))));
        }
        filteredCuisineBlogsCurrentPage.value=result['data']['current_page'];
        filteredCuisineBlogsLastPage.value=result['data']['last_page'];
      } else {

      }});
  }

  Future getRedeemedOffers(bool isPagination,String date) async {
    Future.microtask(() async {
      if(!isPagination){
      isLoading.value=true;
      }
      var response = await DataApiService.instance
          .get('user/get-redeemed-offers?page=$redeemedOffersCurrentPage&date=$date')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        if(redeemedOffersList.isEmpty){
          redeemedOffersList.value = List<RedeemedOffersModel>.from(result['data']['data'].map((x) => RedeemedOffersModel.fromJson(x)));
        }else{
          redeemedOffersList.addAll(List<RedeemedOffersModel>.from(result['data']['data'].map((x) => RedeemedOffersModel.fromJson(x))));
        }
        redeemedOffersCurrentPage.value=result['data']['current_page'];
        redeemedOffersLastPage.value=result['data']['last_page'];
      } else {

      }});
  }
  Future getFAQs() async {

    Future.microtask(() async {
        isLoading.value=true;
      var response = await DataApiService.instance
          .get('user/get-faqs')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        faqsList.value = List<FaqsModel>.from(result['data']['faqs'].map((x) => FaqsModel.fromJson(x)));
        adminEmail.value=result['data']['customer_support_email'].toString();
      } else {

      }});
  }
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('M/d/yyyy').format(parsedDate);

    return formattedDate;
  }
  void updateLatLongForNavigatingCamera(double? lat,double? long) {
    lattitude.value=lat;
    longitude.value=long;
  }
  void updateFcmTokenValue(String value) {
   fcmToken.value=value;
  }

  void updateSelectedDate(String date) {

    String todayData = DateFormat('d MMMM, yyyy').format(DateTime.now());
    if(date==todayData||date=='today'){
      selectedDate.value="today";
    }else{
      selectedDate.value='on $date';
    }
  }
}