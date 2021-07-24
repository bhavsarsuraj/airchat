class ChatModel {
  ChatModel({
    required this.passengers,
  });

  List<String> passengers;

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        passengers: json["passengers"],
      );

  Map<String, dynamic> toMap() => {"passengers": passengers};
}
