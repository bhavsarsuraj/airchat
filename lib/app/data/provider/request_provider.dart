import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/models/requestModel.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app/utils/values/strings.dart';
import 'package:airchat/app_controller.dart';
import 'package:get/get.dart';

class RequestProvider {
  final AppController _appController = Get.find();

  Future<RequestModel> getRequestForThisPassenger(
      PassengerModel passengerModel) async {
    final snap = await References.requestsRef
        .where(Strings.passTicketNos, arrayContains: _appController.myTicketNo)
        .where(Strings.passTicketNos, arrayContains: passengerModel.ticketNo)
        .get();
    if (snap.docs.isEmpty) {
      // No request exists between me and this passenger
      return null;
    } else {
      // Request exists between me and this passenger
      return RequestModel.fromMap(snap.docs.first.data());
    }
  }

  Future<void> addRequest(RequestModel requestModel) async {
    await References.requestsRef.doc(requestModel.id).set(requestModel.toMap());
  }

  Future<void> deleteRequest(RequestModel requestModel) async {
    await References.requestsRef.doc(requestModel.id).delete();
  }
}
