class ChatModel {
  ChatModel({
    this.id,
    this.passTicketNos,
  });

  String id;
  List<String> passTicketNos;

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        id: json["id"] == null ? null : json["id"],
        passTicketNos: json["passTicketNos"] == null
            ? null
            : List<String>.from(json["passengers"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "passTicketNos": passTicketNos == null
            ? null
            : List<dynamic>.from(passTicketNos.map((x) => x)),
      };
}
