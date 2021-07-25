class MessageModel {
  MessageModel({
    this.createdAt,
    this.createdBy,
    this.message,
    this.id,
  });

  String createdAt;
  String createdBy;
  String message;
  String id;

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        message: json["message"] == null ? null : json["message"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "createdAt": createdAt == null ? null : createdAt,
        "createdBy": createdBy == null ? null : createdBy,
        "message": message == null ? null : message,
        "id": id == null ? null : id,
      };
}
