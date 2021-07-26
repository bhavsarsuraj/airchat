import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:airchat/app/utils/enums.dart';
import 'package:airchat/app/utils/values/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _iconSize = 28.0;

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
    return GestureDetector(
      onTap: () => _didTapChat(passenger),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: 96,
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
            Image.asset(
              Images.passengerIcon,
              height: _iconSize,
              width: _iconSize,
            ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          passenger.name ?? '--',
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
                          passenger.maskedTicketNo ?? '--',
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
                      Obx(
                        () => _getRequestStatusIcon(passenger),
                      ),
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
                      Obx(() => _getRequestStatusText(passenger)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRequestStatusText(PassengerModel passengerModel) {
    switch (controller.getStatusOfRequest(passengerModel)) {
      case RequestStatus.NotSent:
        return Text(
          'Tap to connect',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w500,
          ),
        );
      case RequestStatus.Pending:
        // Check if requester is Me
        if (controller.isRequestedByMe(passengerModel)) {
          // Requested By Me
          return Text(
            'Undo request',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w500,
            ),
          );
        } else {
          //Not Requested By Me
          return Text(
            '${passengerModel.name} has requested to connect',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w500,
            ),
          );
        }
        break;
      case RequestStatus.Accepted:
        return Text(
          'Connected',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w500,
          ),
        );
        break;
      default:
        return Text(
          'Tap to connect',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w500,
          ),
        );
    }
  }

  Widget _getRequestStatusIcon(PassengerModel passengerModel) {
    switch (controller.getStatusOfRequest(passengerModel)) {
      case RequestStatus.NotSent:
        return GestureDetector(
          onTap: () => controller.didTapRequest(passengerModel),
          child: Icon(
            Icons.add,
            size: _iconSize,
            color: Colors.blue,
          ),
        );
      case RequestStatus.Pending:
        // Check if requester is Me
        if (controller.isRequestedByMe(passengerModel)) {
          // Requested By Me
          return GestureDetector(
            onTap: () => controller.undoRequest(passengerModel),
            child: Image.asset(
              Images.undoIcon,
              height: _iconSize,
              width: _iconSize,
              color: Colors.red,
            ),
          );
        } else {
          //Not Requested By Me
          return Row(
            children: [
              GestureDetector(
                onTap: () => controller.didTapRejectRequest(passengerModel),
                child: Icon(
                  Icons.person_remove_alt_1_outlined,
                  color: Colors.red,
                  size: _iconSize,
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () => controller.didTapAcceptRequest(passengerModel),
                child: Icon(
                  Icons.person_add_alt_1_outlined,
                  size: _iconSize,
                  color: Colors.orangeAccent,
                ),
              )
            ],
          );
        }
        break;
      case RequestStatus.Accepted:
        return Image.asset(
          Images.connectedIcon,
          height: _iconSize,
          width: _iconSize,
          color: Colors.orangeAccent,
        );
        break;
      default:
        return GestureDetector(
          onTap: () => controller.didTapRequest(passengerModel),
          child: Icon(
            Icons.add,
            size: _iconSize,
          ),
        );
    }
  }

  void _didTapChat(PassengerModel passengerModel) {
    controller.didTapChat(passengerModel);
  }
}
