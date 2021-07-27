import 'package:airchat/app/utils/values/strings.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

class Snackbars {
  static GetBar errorSnackBar({@required String message}) {
    return GetBar(
      title: Strings.error,
      message: message,
      duration: Duration(seconds: 2),
    );
  }
}
