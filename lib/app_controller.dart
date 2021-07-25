import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final Rx<PassengerModel> _passengerModel = Rx<PassengerModel>(null);
  set passengerModel(val) => _passengerModel.value = val;
  PassengerModel get passengerModel => _passengerModel.value;

  @override
  void onReady() {
    super.onReady();
  }
}
