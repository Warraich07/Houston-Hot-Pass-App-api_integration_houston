import 'dart:developer';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherController extends GetxController {
  late PusherChannelsFlutter pusher;
  RxString lastEventMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePusher();
  }

  Future<void> _initializePusher() async {
    pusher = PusherChannelsFlutter();

    await pusher.init(
      apiKey: 'YOUR_API_KEY',
      cluster: 'YOUR_APP_CLUSTER',
    );

    await pusher.connect();

    _subscribeToChannel();
  }

  void _subscribeToChannel() async {
    await pusher.subscribe(
      channelName: 'my-channel',
      onEvent: _onEvent,
    );
  }

  void _onEvent(PusherEvent event) {
    log("Received event: $event");
    lastEventMessage.value = event.data;
  }

  @override
  void onClose() {
    pusher.unsubscribe(channelName: 'my-channel');
    pusher.disconnect();
    super.onClose();
  }
}
