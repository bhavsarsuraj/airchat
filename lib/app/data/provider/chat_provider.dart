import 'package:airchat/app/data/models/chatModel.dart';
import 'package:airchat/app/data/models/messageModel.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatProvider {
  final AppController _appController = Get.find();

  Stream<List<ChatModel>> getChatsOf(String passTicketNo) {
    final stream = References.chatsRef
        .where('passengers', arrayContains: passTicketNo)
        .where('passengers',
            arrayContains: _appController.passengerModel.ticketNo)
        .snapshots();
    return stream.map((snap) =>
        snap.docs.map((doc) => ChatModel.fromMap(doc.data())).toList());
  }

  Future<void> addMessage(
      {@required String passTicketNo,
      @required MessageModel messageModel}) async {
    // Check if chat already exists, if yes then add message in it else create a new chat and add Message
    final snap = await References.chatsRef
        .where('passengers', arrayContains: passTicketNo)
        .where('passengers',
            arrayContains: _appController.passengerModel.ticketNo)
        .get();
    if (snap.docs.isNotEmpty) {
      // Chat exists
      final myChat = ChatModel.fromMap(snap.docs.first.data());
      await References.messagesRef(myChat.id)
          .doc(messageModel.id)
          .set(messageModel.toMap());
    } else {
      // Create a new chat and add message
      final newChat = ChatModel(
        id: References.chatsRef.doc().id,
        passTicketNos: [_appController.passengerModel.ticketNo, passTicketNo],
      );
      await References.chatsRef.doc(newChat.id).set(newChat.toMap());
      await References.messagesRef(newChat.id)
          .doc(messageModel.id)
          .set(messageModel.toMap());
    }
  }
}
