class ChatModel {
  ChatModel({
    this.id,
    this.passTicketNos,
  });

  String id;
  List<String> passTicketNos;

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        id: json["id"] == null ? null : json["id"],
        passTicketNos: ((json["passTicketNos"] as List) ?? [])
            .map<String>((x) => x as String)
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "passTicketNos": passTicketNos ?? [],
      };
}
