import 'package:airchat/app/data/models/chatModel.dart';
import 'package:airchat/app/data/models/messageModel.dart';
import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/repository/chat_repository.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app/utils/values/strings.dart';
import 'package:airchat/app/utils/widgets/snackbars.dart';
import 'package:airchat/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChatController extends GetxController {
  final ChatModel chatModel;
  final PassengerModel passengerModel;
  ChatController({@required this.passengerModel, @required this.chatModel});

  final AppController _appController = Get.find();
  final _chatRepository = ChatRepository();
  final messages = List<MessageModel>.empty().obs;

  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    bindMessages();
  }

  void bindMessages() {
    final stream = _chatRepository.getMessagesOf(chatModel);
    messages.bindStream(stream);
  }

  Future<void> didTapSendMessage() async {
    if (messageController.text.isEmpty) return;
    // Create a Message
    final message = MessageModel(
      id: References.messagesRef(chatModel.id).doc().id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      createdBy: _appController.myTicketNo,
      message: messageController.text,
    );
    messageController.text = '';
    // Add message to chat
    try {
      await _chatRepository.addMessage(chatModel, message);
    } catch (e) {
      Get.showSnackbar(
        Snackbars.errorSnackBar(
          message: ErrorStrings.errorSendingMessage,
        ),
      );
    }
  }
}
