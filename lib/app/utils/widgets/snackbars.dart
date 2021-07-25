import 'package:meta/meta.dart';
import 'package:get/get.dart';

class Snackbars {
  static GetBar errorSnackBar({@required String message}) {
    return GetBar(
      title: 'Error'.tr,
      message: message.tr,
      duration: Duration(seconds: 2),
    );
  }

  static GetBar successSnackbar({@required String message}) {
    return GetBar(
      title: 'Success'.tr,
      message: message.tr,
      duration: Duration(seconds: 2),
    );
  }
}
