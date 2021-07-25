import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/models/requestModel.dart';
import 'package:airchat/app/data/repository/passenger_repository.dart';
import 'package:airchat/app/data/repository/request_repository.dart';
import 'package:airchat/app/utils/enums.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app/utils/loading/loading_utils.dart';
import 'package:airchat/app/utils/widgets/snackbars.dart';
import 'package:airchat/app_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AppController _appController = Get.find();
  final _passengerRepository = PassengerRepository();
  final _requestRepository = RequestRepository();

  final passengersInVicinity = List<PassengerModel>.empty().obs;

  var _requestsMap = Map<String, RequestModel>().obs;

  @override
  void onInit() {
    super.onInit();
    configure();
  }

  void configure() {
    getAllPassengersInVicinity();
    getRequestsMap();
  }

  void getRequestsMap() {
    // _requestRepository.listenRequest().listen((requests) {
    //   _updateMapFrom(requests);
    // });
    References.requestsRef
        .where(
          'passTicketNos',
          arrayContains: _appController.passengerModel.ticketNo,
        )
        .snapshots()
        .listen((snap) {
      _updateMapFrom(
          snap.docs.map((doc) => RequestModel.fromMap(doc.data())).toList());
    });
  }

  void _updateMapFrom(List<RequestModel> requests) {
    final newMap = Map<String, RequestModel>();
    requests.forEach((req) {
      // if receiver is me
      if (req.receiver == _appController.myTicketNo) {
        newMap[req.requester] = req;
      } else {
        newMap[req.receiver] = req;
      }
    });
    _requestsMap.assignAll(newMap);
  }

  void getAllPassengersInVicinity() {
    final stream = _passengerRepository.getAllPassengers();
    passengersInVicinity.bindStream(stream);
  }

  RequestStatus getStatusOfRequest(PassengerModel passengerModel) {
    // check if requests exists or not
    if (_requestsMap.containsKey(passengerModel.ticketNo)) {
      // Exists
      // Get the request
      final req = _requestsMap[passengerModel.ticketNo];
      return req.isAccepted ? RequestStatus.Accepted : RequestStatus.Pending;
    } else {
      // Not exists
      return RequestStatus.NotSent;
    }
  }

  bool isRequestedByMe(PassengerModel passengerModel) {
    final req = _requestsMap[passengerModel.ticketNo];
    if (req != null) {
      return req.requester == _appController.passengerModel.ticketNo;
    } else {
      // Default
      return false;
    }
  }

  Future<void> didTapRequest(PassengerModel receiver) async {
    try {
      LoadingUtils.showLoader();
      final request = RequestModel(
        id: References.requestsRef.doc().id,
        requester: _appController.myTicketNo,
        receiver: receiver.ticketNo,
        isAccepted: false,
        passTicketNos: [_appController.myTicketNo, receiver.ticketNo],
      );
      // Add request
      await _requestRepository.addRequest(request);
      LoadingUtils.dismissLoader();
    } catch (e) {
      LoadingUtils.dismissLoader();
      Get.showSnackbar(
        Snackbars.errorSnackBar(
            message:
                'Error occured while requesting ${receiver.name}. Please try again'),
      );
    }
  }

  Future<void> didTapAcceptRequest(PassengerModel requester) async {
    try {
      LoadingUtils.showLoader();
      // Get the request
      final req = _requestsMap[requester.ticketNo];
      req.isAccepted = true;
      await _requestRepository.addRequest(req);
      LoadingUtils.dismissLoader();
    } catch (e) {
      LoadingUtils.dismissLoader();
      Get.showSnackbar(
        Snackbars.errorSnackBar(
            message: 'Error occured while accepting request. Please try again'),
      );
    }
  }

  Future<void> didTapRejectRequest(PassengerModel requester) async {
    try {
      LoadingUtils.showLoader();
      final req = _requestsMap[requester.ticketNo];
      await _requestRepository.deleteRequest(req);
      LoadingUtils.dismissLoader();
    } catch (e) {
      LoadingUtils.dismissLoader();
      Get.showSnackbar(
        Snackbars.errorSnackBar(message: e),
      );
    }
  }

  Future<void> undoRequest(PassengerModel receiver) async {
    try {
      LoadingUtils.showLoader();
      final req = _requestsMap[receiver.ticketNo];
      await _requestRepository.deleteRequest(req);
      LoadingUtils.dismissLoader();
    } catch (e) {
      LoadingUtils.dismissLoader();
      Get.showSnackbar(
        Snackbars.errorSnackBar(message: e),
      );
    }
  }
}
