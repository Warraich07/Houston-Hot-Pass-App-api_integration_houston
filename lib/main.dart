import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/controllers/general_controller.dart';
import 'package:sizer/sizer.dart';
import 'controllers/auth_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/lazy_controller.dart';
import 'views/intro_screens/splash_screen.dart';




void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final FirebaseApp app = Firebase.app();
  final FirebaseOptions options = app.options;

  print("Firebase Project Number: ${options.appId}");
  runApp( const MyApp());


}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            initialBinding: LazyController(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen()

          );
        }
    );
  }

}

// class InitialBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//     Get.put(AuthController());
//     Get.put(GeneralController());
//     Get.put(HomeController());
//
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    // Initialize Firebase only if it hasn't been initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (e) {
    // Handle any initialization errors
    print("Error initializing Firebase in background handler: $e");
  }

  // Handle the background message
  print("Handling a background message: ${message.messageId}");
}

