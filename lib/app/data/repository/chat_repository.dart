import 'package:airchat/app/data/models/chatModel.dart';
import 'package:airchat/app/data/models/messageModel.dart';
import 'package:airchat/app/data/provider/chat_provider.dart';

class ChatRepository {
  final _apiClient = ChatProvider();

  Stream<List<MessageModel>> getMessagesOf(ChatModel chatModel) {
    final stream = _apiClient.getMessagesOf(chatModel);
    return stream;
  }

  Future<void> addChat(ChatModel chatModel) async {
    await _apiClient.addChat(chatModel);
  }

  Future<void> addMessage(ChatModel chat, MessageModel messageModel) async {
    await _apiClient.addMessage(chat, messageModel);
  }

  Stream<List<ChatModel>> getMyChats() {
    return _apiClient.getMyChats();
  }
}
