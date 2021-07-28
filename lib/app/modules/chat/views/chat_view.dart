import 'package:airchat/app/data/models/messageModel.dart';
import 'package:airchat/app/utils/values/images.dart';
import 'package:airchat/app/utils/values/strings.dart';
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
        SizedBox(
          width: 12,
        ),
        Obx(
          () => _getBlockStatus(),
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
                padding: EdgeInsets.symmetric(vertical: 6),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  return Obx(() => _getMessageView(controller.messages[index]));
                },
                reverse: true,
              ),
            ),
            Obx(() => _buildBlockText()),
            SizedBox(height: 6),
            Obx(() => _buildTextField()),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 50),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange, width: 1.0),
              ),
              child: Text(
                messageModel.message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherMessageView(MessageModel messageModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Images.passengerIcon,
            height: _iconSize,
            width: _iconSize,
            color: Colors.black54,
          ),
          SizedBox(width: 4),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black54, width: 1.0),
              ),
              child: Text(
                messageModel.message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return !controller.chat.isBlocked
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller.messageController,
                  onEditingComplete: controller.didTapSendMessage,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: Strings.tapToType,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  style: TextStyle(fontSize: 18),
                  minLines: 1,
                  maxLines: 5,
                ),
              ),
              SizedBox(width: 4),
              GestureDetector(
                onTap: () async {
                  await controller.didTapSendMessage();
                },
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF128C7E),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.send,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _getBlockStatus() {
    if (controller.chatModel.value.isBlocked) {
      // Chat is Blocked
      if (_isBlockedByMe()) {
        // Blocked by me
        return TextButton.icon(
          onPressed: () async {
            await controller.unblockUser();
          },
          icon: Icon(
            Icons.lock_open_rounded,
            color: Colors.red,
          ),
          label: Text(
            Strings.unblock,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      } else {
        // I am blocked
        return Image.asset(
          Images.blockIcon,
          height: _iconSize,
          width: _iconSize,
          color: Colors.red,
        );
      }
    } else {
      // Show the option to block the chat
      return TextButton.icon(
        onPressed: () async {
          await controller.blockUser();
        },
        icon: Icon(
          Icons.block,
          color: Colors.red,
        ),
        label: Text(
          Strings.block,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }
  }

  Widget _buildBlockText() {
    if (!controller.chatModel.value.isBlocked) {
      // Chat is unblocked
      return Container();
    } else {
      // Chat is blocked
      if (_isBlockedByMe()) {
        return _blockedTextContainer(
            Strings.youBlocked(controller.passengerModel.name));
      } else {
        return _blockedTextContainer(
            Strings.youCantSendMessages(controller.passengerModel.name));
      }
    }
  }

  Widget _blockedTextContainer(String message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  bool _isBlockedByMe() {
    final isBlockedByMe =
        controller.chatModel.value.blockedBy == _appController.myTicketNo;
    return isBlockedByMe;
  }
}
