import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  AuthPreference._();

  static final AuthPreference _instance = AuthPreference._();

  static AuthPreference get instance => _instance;
  //
  // Future setNotificationsValue(String notificationLength) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("notificationLength", notificationLength??'0');
  // }
  // Future<String> getNotificationsValue() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String result = pref.getString("notificationLength") ?? '';
  //   return result;
  // }
  void setGymStatus(String selectedGymStatus)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("selectedGymStatus", selectedGymStatus);
  }

  Future getGymStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selectedGymStatus");
  }
  void setUserIdInCache(String userId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
  }

  Future getUserIdInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }

  void setGender(String gender)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("selectedGender", gender);
  }

  Future getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selectedGender");
  }

  void setReasons(List selectedReasons)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringReasons = selectedReasons.cast<String>();
    prefs.setStringList("selectedReasons", stringReasons);
  }

  Future<List<String>> getReasons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("selectedReasons") ?? [];
  }

void setGoals(List selectedGoals)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> stringGoals = selectedGoals.cast<String>();
  prefs.setStringList("selectedGoals", stringGoals);
}

  Future<List<String>> getGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("selectedGoals") ?? [];
  }

  void setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
  }

  void setUserLoggedIn(bool key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", key);
    // prefs.setString("userType", userType);
  }

  Future<Map<String, dynamic>> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var log = prefs.getBool("isLoggedIn") ?? false;
    String userType=prefs.getString("userType") ?? "user";
    return {
      "isLoggedIn": log,
      "userType": userType,
    };
  }

  Future getUserType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("userType") ?? '';
    return result;
  }

  Future getSocialType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("socialType") ?? '';
    return result;
  }
  void setShowPopup(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("popupShown", type);
  }


  Future<String> shouldShowPopup() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool('popupShown').toString();
  }

  void setUserType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userType", type);
  }

  void setSocialType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("socialType", type);
  }



  void saveUserDataToken({@required token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
  }


  void saveUserId({@required id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("userId", id);
  }

  Future getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("userId") ?? '';
    return result;
  }

  void saveCurrency({@required id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("currency", id);
  }

  Future getCurrency() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("currency") ?? '';
    return result;
  }

  Future getUserDataToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("token") ?? '';
    return result;
  }

  void saveUserRefreshToken({@required token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("refresh_token", token);
  }

  Future getUserRefreshToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("refresh_token") ?? '';
    return result;
  }

  void saveUserData({@required token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("userData", token.toString());
  }

  Future getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("userData") ?? '';
    return result;
  }

  Future setUserGuestMode(String mode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("userMode", mode);
  }

  Future<String> getUserMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("userMode") ?? 'guest';
    return result;
  }

  void setAge(int age) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("age", age);
  }

  Future getAge() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int result = pref.getInt("age") ?? 0;
    return result;
  }

}
