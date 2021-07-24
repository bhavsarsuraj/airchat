class RequestModel {
  RequestModel({
    required this.id,
    required this.requester,
    required this.receiver,
    required this.status,
    required this.passengers,
  });

  String id;
  String requester;
  String receiver;
  String status;
  List<String> passengers;

  factory RequestModel.fromMap(Map<String, dynamic> json) => RequestModel(
        id: json["id"],
        requester: json["requester"],
        receiver: json["receiver"],
        status: json["status"],
        passengers: json["passengers"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "requester": requester,
        "receiver": receiver,
        "status": status,
        "passengers": passengers,
      };
}
