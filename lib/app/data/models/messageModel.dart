class MessageModel {
  MessageModel({
    required this.createdAt,
    required this.createdBy,
    required this.message,
  });

  String createdAt;
  String createdBy;
  String message;

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "createdAt": createdAt,
        "createdBy": createdBy,
        "message": message,
      };
}
