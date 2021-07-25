import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/models/requestModel.dart';
import 'package:airchat/app/data/provider/request_provider.dart';

class RequestRepository {
  final _apiClient = RequestProvider();

  Future<RequestModel> getRequestOfThisPassenger(
      PassengerModel passengerModel) async {
    return await _apiClient.getRequestForThisPassenger(passengerModel);
  }

  Future<void> addRequest(RequestModel requestModel) async {
    await _apiClient.addRequest(requestModel);
  }
}
