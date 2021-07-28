import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingUtils {
  static void showLoader() {
    if (!(Get.isDialogOpen ?? false)) {
      Get.dialog(
        Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.red,
          color: Colors.white,
        )),
      );
    }
  }

  static void dismissLoader() {
    if (Get.isDialogOpen ?? true) {
      Get.back();
    }
  }
}
