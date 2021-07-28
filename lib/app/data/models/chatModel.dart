class ChatModel {
  ChatModel({
    this.id,
    this.passTicketNos,
    this.isBlocked,
    this.blockedBy,
  });

  String id;
  bool isBlocked;
  String blockedBy;
  List<String> passTicketNos;

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        id: json["id"] == null ? null : json["id"],
        isBlocked: json["isBlocked"] == null ? null : json["isBlocked"],
        blockedBy: json["blockedBy"] == null ? null : json["blockedBy"],
        passTicketNos: ((json["passTicketNos"] as List) ?? [])
            .map<String>((x) => x as String)
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "isBlocked": isBlocked == null ? null : isBlocked,
        "blockedBy": blockedBy == null ? null : blockedBy,
        "passTicketNos": passTicketNos ?? [],
      };
}
