import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../app_widgets/alertbox.dart';
import '../constants/app_icons.dart';
import '../controllers/auth_controller.dart';

class NotificationsServices {
  // UnCom
  // BookingController bookingController = Get.find();
  AuthController _authController=Get.find();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = AndroidInitializationSettings("ic_launcher");
    var initializationSetting = InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payLoad) {
          // UnCom
          handleMessage(context,message);
        });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      initLocalNotification(context, message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    // final ByteData bytes = await rootBundle.load('assets/icons/app_icon.jpg');
    // final Uint8List list = bytes.buffer.asUint8List();
    //
    // // Save the asset to a temporary file
    // final Directory directory = await getTemporaryDirectory();
    // final File file = File('${directory.path}/assets/icons/app_icon.jpg');
    // await file.writeAsBytes(list);

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(), "High Importance Channel",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: "your channel description",
        importance: Importance.high,
        priority: Priority.high,
      icon: '@drawable/ic_launcher',
      color: const Color(0xFFF0F0F0), // Background color for notification
      colorized: false, // Use the color as the background
      // largeIcon: FilePathAndroidBitmap(file.path),
    );
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    print(message.data);
    if(message.data['notification_type']=='offer_redeemed'){
      // Get.dialog(
      //   CustomAlertDialog(
      //     heading: "Offer Redeemed Successfully",
      //     subHeading: "Congratulations! Discount Offer has been redeemed successfully. Enjoy your meal ☺️!",
      //     buttonName: "Great",
      //     img: AppIcons.successIcon,
      //     onTapped: () {
      //       Get.back(); // Close dialog
      //       Get.back(); // Navigate back
      //     },
      //   ),
      // );

    }
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  void requestNotificationsPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        badge: true,
        announcement: true,
        alert: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // DebugUtils.printDebug(StringResources.userGrantedPermission);
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // DebugUtils.printDebug(StringResources.userGrantedProvisionalPermission);
    } else {
      // DebugUtils.printDebug(StringResources.userDidNotGrantPermission);
    }
  }
  // UnCom
  void handleMessage(BuildContext context ,RemoteMessage message){
    // if(_authController.isAdminView==true){
    //   Get.offAll(() => HomeScreen());
    //   _authController.updateIsAdminView(false);
    //   _authController.updateViewToNotificationScreen(true);
    // }else{
    //
    // }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();

    return token!;
  }

  /// Method to trigger a push notification programmatically
  Future<void> triggerPushNotification({
    required String title,
    required String body,
    required String token,
    String? imageUrl,
    Map<String, dynamic>? data,
  }) async {
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    const String serverKey = 'YOUR_FCM_SERVER_KEY'; // Replace with your FCM Server Key

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final payload = {
      'to': token, // or '/topics/your_topic' for topic-based notifications
      'notification': {
        'title': title,
        'body': body,
        if (imageUrl != null) 'image': imageUrl,
      },
      'data': data ?? {}, // Custom data payload
    };

    try {
      final response = await http.post(
        Uri.parse(fcmUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print("Notification sent successfully");
      } else {
        print("Failed to send notification: ${response.body}");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
// // icon: 'app_icon_o_l'