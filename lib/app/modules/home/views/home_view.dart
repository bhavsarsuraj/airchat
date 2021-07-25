import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(
        () => _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Co-passengers in your vicinity',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: controller.passengersInVicinity.length,
        itemBuilder: (context, index) {
          return _buildPassengerCard(controller.passengersInVicinity[index]);
        },
      ),
    );
  }

  Widget _buildPassengerCard(PassengerModel passenger) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 90,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.person_outline),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        passenger.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        passenger.maskedTicketNo,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.56),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    _getRequestStatusIcon(passenger),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  passenger.designation ?? '--',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.56),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      passenger.company ?? '--',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Tap to connect',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRequestStatusIcon(PassengerModel passengerModel) {
    switch (controller.getStatusOfRequest(passengerModel)) {
      case RequestStatus.NotSent:
        return GestureDetector(
          child: Icon(Icons.add),
        );
      case RequestStatus.Pending:
        // Check if requester is Me
        if (controller.isRequestedByMe(passengerModel)) {
          // Requested By Me
          return GestureDetector(
            child: Icon(Icons.undo),
          );
        } else {
          //Not Requested By Me
          return Row(
            children: [
              GestureDetector(
                child: Icon(Icons.person_remove),
              ),
              SizedBox(width: 8),
              GestureDetector(
                child: Icon(Icons.person_add),
              )
            ],
          );
        }
        break;
      case RequestStatus.Accepted:
        return GestureDetector(
          child: Icon(Icons.verified),
        );
        break;
      default:
        return GestureDetector(
          child: Icon(Icons.add),
        );
    }
  }
}
