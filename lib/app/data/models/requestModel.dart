class RequestModel {
  RequestModel({
    this.id,
    this.requester,
    this.receiver,
    this.isAccepted,
    this.passTicketNos,
  });

  String id;
  String requester;
  String receiver;
  bool isAccepted;
  List<String> passTicketNos;

  factory RequestModel.fromMap(Map<String, dynamic> json) => RequestModel(
        id: json["id"] == null ? null : json["id"],
        requester: json["requester"] == null ? null : json["requester"],
        receiver: json["receiver"] == null ? null : json["receiver"],
        isAccepted: json["isAccepted"] == null ? null : json["isAccepted"],
        passTicketNos: ((json["passTicketNos"] as List) ?? [])
            .map<String>((x) => x as String)
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "requester": requester == null ? null : requester,
        "receiver": receiver == null ? null : receiver,
        "isAccepted": isAccepted == null ? null : isAccepted,
        "passTicketNos": passTicketNos ?? [],
      };
}
