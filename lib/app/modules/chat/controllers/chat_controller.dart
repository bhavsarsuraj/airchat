import 'package:airchat/app/data/models/chatModel.dart';
import 'package:airchat/app/data/models/messageModel.dart';
import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/repository/chat_repository.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app/utils/loading/loading_utils.dart';
import 'package:airchat/app/utils/values/strings.dart';
import 'package:airchat/app/utils/widgets/snackbars.dart';
import 'package:airchat/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChatController extends GetxController {
  final Rx<ChatModel> chatModel;
  ChatModel get chat => chatModel.value;
  set chat(ChatModel value) => chatModel.value = value;

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
    listenChat();
  }

  void listenChat() {
    References.chatsRef.doc(chat.id).snapshots().listen((doc) {
      final updatedChat = ChatModel.fromMap(doc.data());
      chat = updatedChat;
    });
  }

  void bindMessages() {
    final stream = _chatRepository.getMessagesOf(chat);
    messages.bindStream(stream);
  }

  Future<void> didTapSendMessage() async {
    if (messageController.text.isEmpty) return;
    // Create a Message
    final message = MessageModel(
      id: References.messagesRef(chat.id).doc().id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      createdBy: _appController.myTicketNo,
      message: messageController.text,
    );
    messageController.text = '';
    // Add message in chat
    try {
      await _chatRepository.addMessage(chat, message);
    } catch (e) {
      Get.showSnackbar(
        Snackbars.errorSnackBar(
          message: ErrorStrings.errorSendingMessage,
        ),
      );
    }
  }

  Future<void> blockUser() async {
    chat.isBlocked = true;
    chat.blockedBy = _appController.myTicketNo;
    try {
      LoadingUtils.showLoader();
      await _chatRepository.addChat(chat);
      LoadingUtils.dismissLoader();
    } catch (e) {
      LoadingUtils.dismissLoader();
      Get.showSnackbar(
        Snackbars.errorSnackBar(message: ErrorStrings.errorBlocking),
      );
    }
  }

  Future<void> unblockUser() async {
    chat.isBlocked = false;
    chat.blockedBy = null;
    try {
      LoadingUtils.showLoader();
      await _chatRepository.addChat(chat);
      LoadingUtils.dismissLoader();
    } catch (e) {
      LoadingUtils.dismissLoader();
      Get.showSnackbar(
        Snackbars.errorSnackBar(message: ErrorStrings.errorUnblocking),
      );
    }
  }
}
