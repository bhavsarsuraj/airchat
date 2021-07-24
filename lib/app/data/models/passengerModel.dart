class PassengerModel {
  PassengerModel({
    required this.name,
    required this.ticketNo,
    this.designation,
    this.company,
  });

  String get maskedTicketNo => 'xxxxxxx' + ticketNo.substring(7);

  String name;
  String ticketNo;
  String? designation;
  String? company;

  factory PassengerModel.fromMap(Map<String, dynamic> json) => PassengerModel(
        name: json["name"] == null ? null : json["name"],
        ticketNo: json["ticketNo"] == null ? null : json["ticketNo"],
        designation: json["designation"] == null ? null : json["designation"],
        company: json["company"] == null ? null : json["company"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "ticketNo": ticketNo,
        "designation": designation == null ? null : designation,
        "company": company == null ? null : company,
      };
}
