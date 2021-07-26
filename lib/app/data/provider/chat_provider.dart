import 'package:airchat/app/data/models/chatModel.dart';
import 'package:airchat/app/data/models/messageModel.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app_controller.dart';
import 'package:get/get.dart';

class ChatProvider {
  final AppController _appController = Get.find();

  Future<void> addChat(ChatModel chatModel) async {
    await References.chatsRef.doc(chatModel.id).set(chatModel.toMap());
  }

  Stream<List<MessageModel>> getMessagesOf(ChatModel chat) {
    final stream = References.messagesRef(chat.id)
        .orderBy('createdAt', descending: true)
        .snapshots();
    return stream.map((snap) =>
        snap.docs.map((doc) => MessageModel.fromMap(doc.data())).toList());
  }

  Future<void> addMessage(ChatModel chat, MessageModel messageModel) async {
    await References.messagesRef(chat.id)
        .doc(messageModel.id)
        .set(messageModel.toMap());
  }

  Stream<List<ChatModel>> getMyChats() {
    final stream = References.chatsRef
        .where('passTicketNos', arrayContains: _appController.myTicketNo)
        .snapshots();
    return stream.map((snap) =>
        snap.docs.map((doc) => ChatModel.fromMap(doc.data())).toList());
  }
}
