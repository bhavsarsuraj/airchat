import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app/utils/values/strings.dart';
import 'package:airchat/app_controller.dart';
import 'package:get/get.dart';

class PassengerProvider {
  final AppController _appController = Get.find();
  Stream<List<PassengerModel>> getAllPassengersInVicinity() {
    final stream = References.passengersRef
        .where(Strings.ticketNo,
            isNotEqualTo: _appController.passengerModel.ticketNo)
        .snapshots();
    return stream.map((snap) =>
        snap.docs.map((doc) => PassengerModel.fromMap(doc.data())).toList());
  }

  Future<void> addPassenger(PassengerModel passengerModel) async {
    await References.passengersRef
        .doc(passengerModel.ticketNo)
        .set(passengerModel.toMap());
  }
}
