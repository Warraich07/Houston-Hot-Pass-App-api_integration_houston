import 'package:get/get.dart';
import 'package:houstan_hot_pass/controllers/timer_controller.dart';
import 'auth_controller.dart';
import 'base_controller.dart';
import 'general_controller.dart';
import 'home_controller.dart';
import 'offers_controller.dart';

class LazyController extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TimerController());
    Get.put(OffersController());
    Get.put(GeneralController());
    Get.put(AuthController());
    Get.put(HomeController());
  }
}