import 'package:airchat/app/data/models/chatModel.dart';
import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/models/requestModel.dart';
import 'package:airchat/app/data/repository/chat_repository.dart';
import 'package:airchat/app/data/repository/passenger_repository.dart';
import 'package:airchat/app/data/repository/request_repository.dart';
import 'package:airchat/app/routes/app_pages.dart';
import 'package:airchat/app/utils/values/enums.dart';
import 'package:airchat/app/utils/firebase/references.dart';
import 'package:airchat/app/utils/loading/loading_utils.dart';
import 'package:airchat/app/utils/values/strings.dart';
import 'package:airchat/app/utils/widgets/snackbars.dart';
import 'package:airchat/app_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AppController _appController = Get.find();
  final _passengerRepository = PassengerRepository();
  final _requestRepository = RequestRepository();
  final _chatRepository = ChatRepository();

  final passengersInVicinity = List<PassengerModel>.empty().obs;

  var _requestsMap = Map<String, RequestModel>().obs;

  final _chatsMap = Map<String, ChatModel>().obs;

  @override
  void onInit() {
    super.onInit();
    configure();
  }

  void configure() {
    getAllPassengersInVicinity();
    getRequestsMap();
    getChatsMap();
  }

  void getRequestsMap() {
    References.requestsRef
        .where(
          Strings.passTicketNos,
          arrayContains: _appController.passengerModel.ticketNo,
        )
        .snapshots()
        .listen((snap) {
      _updateRequestsMapFrom(
        snap.docs.map((doc) => RequestModel.fromMap(doc.data())).toList(),
      );
    });
  }

  void getChatsMap() {
    References.chatsRef
        .where(Strings.passTicketNos, arrayContains: _appController.myTicketNo)
        .snapshots()
        .listen((snap) {
      _updateChatsMapFrom(
        snap.docs.map((doc) => ChatModel.fromMap(doc.data())).toList(),
      );
    });
  }

  void _updateChatsMapFrom(List<ChatModel> chats) {
    final newMap = Map<String, ChatModel>();
    chats.forEach((chat) {
      // get other passenger
      if (chat.passTicketNos.elementAt(0) == _appController.myTicketNo) {
        // other passenger is at index 1
        newMap[chat.passTicketNos.elementAt(1)] = chat;
      } else {
        // other passenger is at index 0
        newMap[chat.passTicketNos.elementAt(0)] = chat;
      }
    });
    _chatsMap.assignAll(newMap);
  }

  void _updateRequestsMapFrom(List<RequestModel> requests) {
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
              '${ErrorStrings.errorRequesting} ${receiver.name}. ${ErrorStrings.pleaseTryAgain}',
        ),
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
        Snackbars.errorSnackBar(message: ErrorStrings.errorAcceptingRequest),
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

  void didTapChat(PassengerModel passengerModel) async {
    // Check if request exists or not
    final req = _requestsMap[passengerModel.ticketNo];
    if (req == null || !req.isAccepted) {
      // request doesn't exist or not accepted => return
      return;
    } else {
      // Request is accepted
      // Firstly check if chat exists or not in the chats map
      if (_chatsMap.containsKey(passengerModel.ticketNo)) {
        // Chat exists, continue to chat screen
        Get.toNamed(Routes.CHAT, arguments: [
          Rx(_chatsMap[passengerModel.ticketNo]),
          passengerModel
        ]);
      } else {
        // Create a new chat and then proceed to chat screen
        final chat = ChatModel(
          id: References.chatsRef.doc().id,
          isBlocked: false,
          passTicketNos: [_appController.myTicketNo, passengerModel.ticketNo],
        );
        try {
          LoadingUtils.showLoader();
          await _chatRepository.addChat(chat);
          LoadingUtils.dismissLoader();
          // proceed to chat screen
          Get.toNamed(Routes.CHAT, arguments: [Rx(chat), passengerModel]);
        } catch (e) {
          LoadingUtils.dismissLoader();
          Get.showSnackbar(
            Snackbars.errorSnackBar(
              message: ErrorStrings.somethingWentWrong,
            ),
          );
        }
      }
    }
  }
}
