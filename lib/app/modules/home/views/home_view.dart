import 'package:airchat/app/data/models/passengerModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final users = [
    PassengerModel(
        name: "Dheeraj",
        ticketNo: "123456789123",
        designation: "CEO",
        company: "Infosys"),
    PassengerModel(
        name: "Suraj",
        ticketNo: "123456775891",
        designation: "System Engineer",
        company: "TCS"),
    PassengerModel(
        name: "Ateek",
        ticketNo: "123456785645",
        designation: "UI Designer",
        company: "Google"),
    PassengerModel(
        name: "Joyal",
        ticketNo: "123456728454",
        designation: "Senior Analyst",
        company: "Squareboat Solutions"),
    PassengerModel(
        name: "Aman",
        ticketNo: "123456748963",
        designation: "Co-Founder",
        company: "GeeksForGeeks"),
    PassengerModel(
        name: "Saransh",
        ticketNo: "123456756555",
        designation: "Power Programmer",
        company: "Infosys"),
    PassengerModel(
        name: "Ayushraj",
        ticketNo: "123456748763",
        designation: "Digital Specialist Engineer",
        company: "Infosys"),
    PassengerModel(
        name: "Saransh",
        ticketNo: "123456732144",
        designation: "Power Programmer",
        company: "Infosys"),
    PassengerModel(
        name: "Ayushraj",
        ticketNo: "123456748212",
        designation: "Digital Specialist Engineer",
        company: "Infosys"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
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
        itemCount: users.length,
        itemBuilder: (context, index) {
          return _buildPassengerCard(users[index]);
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
                    Icon(Icons.add),
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

  String getHiddenTicketNo(String ticketNo) {
    return 'xxxxxxx' + ticketNo.substring(7, ticketNo.length);
  }
}
