import 'package:airchat/app/utils/values/strings.dart';

enum RequestStatus { Pending, Accepted, NotSent }

final requestStatuses = EnumValues({
  Strings.pending: RequestStatus.Pending,
  Strings.accepted: RequestStatus.Accepted,
  Strings.notSent: RequestStatus.NotSent,
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
