import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/data/provider/passenger_provider.dart';

class PassengerRepository {
  final _apiClient = PassengerProvider();

  Stream<List<PassengerModel>> getAllPassengers() {
    return _apiClient.getAllPassengersInVicinity();
  }

  Future<void> addPassenger(PassengerModel passengerModel) async {
    await _apiClient.addPassenger(passengerModel);
  }
}
