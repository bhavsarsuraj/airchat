enum RequestStatus { Pending, Accepted, NotSent }

final requestStatuses = EnumValues({
  'Pending': RequestStatus.Pending,
  'Accepted': RequestStatus.Accepted,
  'NotSent': RequestStatus.NotSent,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
