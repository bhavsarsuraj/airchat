import 'package:airchat/app/utils/firebase/collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class References {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  static CollectionReference get passengersRef =>
      _instance.collection(Collections.passengers);
  static CollectionReference get requestsRef =>
      _instance.collection(Collections.requests);
  static CollectionReference get chatsRef =>
      _instance.collection(Collections.chats);
  static CollectionReference messagesRef(String chatID) =>
      chatsRef.doc(chatID).collection(Collections.messages);
}
