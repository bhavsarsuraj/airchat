import 'package:airchat/app/data/models/chatModel.dart';
import 'package:airchat/app/data/models/messageModel.dart';
import 'package:flutter/cupertino.dart';

class ChatRepository {
  final _apiClient = ChatRepository();

  Stream<List<ChatModel>> getChatsOf(String passTicketNo) {
    final stream = _apiClient.getChatsOf(passTicketNo);
    return stream;
  }

  Future<void> addMessage(
      {@required String passTicketNo,
      @required MessageModel messageModel}) async {
    await _apiClient.addMessage(
        passTicketNo: passTicketNo, messageModel: messageModel);
  }
}
