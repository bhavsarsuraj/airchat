import 'package:airchat/app/data/models/messageModel.dart';
import 'package:airchat/app/utils/values/images.dart';
import 'package:airchat/app_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final _iconSize = 26.0;
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackButton(),
        SizedBox(width: 12),
        Image.asset(
          Images.passengerIcon,
          height: _iconSize,
          width: _iconSize,
        ),
        SizedBox(width: 6),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      controller.passengerModel.name ?? '--',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    controller.passengerModel.maskedTicketNo ?? '--',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.56),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                controller.passengerModel.designation ?? '--',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.56),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                controller.passengerModel.company ?? '--',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.4),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            _buildAppBar(),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 0.6,
              color: Colors.grey.withOpacity(0.8),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  return Obx(() => _getMessageView(controller.messages[index]));
                },
                reverse: true,
              ),
            ),
            SizedBox(height: 6),
            _buildTextField(),
          ],
        ),
      ),
    );
  }

  Widget _getMessageView(MessageModel messageModel) {
    return messageModel.createdBy == _appController.myTicketNo
        ? _buildMyMessageView(messageModel)
        : _buildOtherMessageView(messageModel);
  }

  Widget _buildMyMessageView(MessageModel messageModel) {
    return Row(
      children: [
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orangeAccent, width: 1.0),
          ),
          child: Text(
            messageModel.message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.orangeAccent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherMessageView(MessageModel messageModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          Images.passengerIcon,
          height: _iconSize,
          width: _iconSize,
        ),
        SizedBox(width: 4),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: Text(
            messageModel.message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildTextField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.messageController,
            onEditingComplete: controller.didTapSendMessage,
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Tap to type',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        GestureDetector(
          onTap: () async {
            await controller.didTapSendMessage();
          },
          child: Icon(Icons.send),
        ),
      ],
    );
  }
}
