import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/models/requestModel.dart';
import 'package:airchat/app/data/repository/passenger_repository.dart';
import 'package:airchat/app/utils/enums.dart';
import 'package:airchat/app_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AppController _appController = Get.find();
  final _passengerRepository = PassengerRepository();
  final passengersInVicinity = List<PassengerModel>.empty().obs;
  var map = Map<String, RequestModel>();

  @override
  void onInit() {
    super.onInit();
    configure();
  }

  void configure() {
    getAllPassengersInVicinity();
  }

  void getAllPassengersInVicinity() {
    final stream = _passengerRepository.getAllPassengers();
    passengersInVicinity.bindStream(stream);
  }

  RequestStatus getStatusOfRequest(PassengerModel passengerModel) {
    // check if requests exists or not
    if (map.containsKey(passengerModel.ticketNo)) {
      // Exists
      // Get the req
      final req = map[passengerModel.ticketNo];
      return requestStatuses.map[req];
    } else {
      // Not exists
      return RequestStatus.NotSent;
    }
  }

  bool isRequestedByMe(PassengerModel passengerModel) {
    if (map.containsKey(passengerModel.ticketNo)) {
      final req = map[passengerModel.ticketNo];
      return req.requester == _appController.passengerModel.ticketNo;
    } else {
      // Default
      return false;
    }
  }
}
