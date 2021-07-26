import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    final models = Get.arguments;
    final chatModel = models[0];
    final passengerModel = models[1];
    Get.lazyPut<ChatController>(
      () =>
          ChatController(chatModel: chatModel, passengerModel: passengerModel),
    );
  }
}
