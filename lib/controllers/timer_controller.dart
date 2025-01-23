import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TimerController extends GetxController {
  late Timer timer;
  RxBool resendVisible = false.obs;
  RxInt countdown = 60.obs;
  RxBool regenerateVisible = false.obs;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (countdown.value > 0) {
          countdown.value--;
        } else {
          timer.cancel();
          resendVisible.value = true;
          regenerateVisible.value = true; // Show regenerate text
        }

    });
  }
  void resendOtp() {
    // Logic to resend OTP, e.g., make API call
      countdown.value = 60; // Reset countdown
      resendVisible.value = false; // Hide resend button
      regenerateVisible.value = false; // Hide regenerate text

    startTimer(); // Start
    // the timer again
  }
}
