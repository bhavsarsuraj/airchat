import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void didTapConnect(PassengerModel passenger) {
    //TODO: implement connect
  }

  void didTapAcceptRequest(PassengerModel passenger) {
    //TODO: implement accept
  }

  void didTapRejectRequest(PassengerModel passenger) {
    //TODO: implement reject
  }

  void didTapUndo(PassengerModel passenger) {
    //TODO: implement undo
  }
}
