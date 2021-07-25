import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/repository/passenger_repository.dart';
import 'package:airchat/app/routes/app_pages.dart';
import 'package:airchat/app/utils/loading/loading_utils.dart';
import 'package:airchat/app/utils/widgets/snackbars.dart';
import 'package:airchat/app_controller.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerController extends GetxController {
  final AppController _appController = Get.find();
  final _passengerRepository = PassengerRepository();

  @override
  void onInit() {
    super.onInit();
  }

  void didTapScanButton() async {
    String json = await scanner.scan();
    if (json != null) {
      try {
        LoadingUtils.showLoader();
        Map<String, dynamic> pass = jsonDecode(json);
        final passenger = PassengerModel.fromMap(pass);
        _appController.passengerModel = passenger;
        // Add passenger to firestore
        await _passengerRepository.addPassenger(passenger);
        LoadingUtils.dismissLoader();
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        LoadingUtils.dismissLoader();
        Get.showSnackbar(
          Snackbars.errorSnackBar(
            message:
                'Something went wrong.\n Please try again and ensure to scan the barcode behind your ticket.',
          ),
        );
      }
    }
  }
}
