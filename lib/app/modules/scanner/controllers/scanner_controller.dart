import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/repository/passenger_repository.dart';
import 'package:airchat/app/routes/app_pages.dart';
import 'package:airchat/app/utils/loading/loading_utils.dart';
import 'package:airchat/app/utils/values/strings.dart';
import 'package:airchat/app/utils/widgets/snackbars.dart';
import 'package:airchat/app_controller.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ScannerController extends GetxController {
  final AppController _appController = Get.find();
  final _passengerRepository = PassengerRepository();

  @override
  void onInit() {
    super.onInit();
  }

  void didTapScanButton() async {
    LoadingUtils.showLoader();
    final scannedContent = await BarcodeScanner.scan();
    if (scannedContent.rawContent.isNotEmpty) {
      final json = scannedContent.rawContent;
      try {
        // Firstly, try to decode the scanned content into map.
        Map<String, dynamic> pass = jsonDecode(json);

        // create passenger model from the map
        final passenger = PassengerModel.fromMap(pass);

        // set the passenger model in app controller
        _appController.passengerModel = passenger;
        // set the passenger model to cloud firestore.
        await _passengerRepository.addPassenger(passenger);

        LoadingUtils.dismissLoader();

        // Continue to home page
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        LoadingUtils.dismissLoader();
        Get.showSnackbar(
          Snackbars.errorSnackBar(
            message: ErrorStrings.scanError,
          ),
        );
      }
    } else {
      LoadingUtils.dismissLoader();
    }
  }
}
