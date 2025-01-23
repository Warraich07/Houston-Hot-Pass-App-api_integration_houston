import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class GeneralController extends GetxController {
  RxInt _currentIndex = 0.obs;
  RxBool searchField= false.obs;
  int get currentIndex => _currentIndex.value;

  void onBottomBarTapped(int index) {
    _currentIndex.value = index;

  }
}
