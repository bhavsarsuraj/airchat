class Strings {
  static final appTitle = 'Airchat';
  static final tapToConnect = 'Tap to connect';
  static String hasRequestedToConnect(String requester) =>
      '$requester has requested to connect';
  static final connected = 'Connected';
  static final undo = 'Undo request';
  static final coPassengersInYourVicinity = 'Co-passengers in your vicinity';
  static final scanToConnectText =
      'Scan the barcode behind your ticket to chat with people in your vicinity!';
  static final scan = 'SCAN';
  static final tapToType = 'Tap to type';
  static final passTicketNos = 'passTicketNos';
  static final ticketNo = 'ticketNo';
  static final createdAt = 'createdAt';
  static final error = 'Error';
  static final pending = 'Pending';
  static final accepted = 'Accepted';
  static final notSent = 'NotSent';
  static final block = 'Block';
  static final unblock = 'Unblock';
  static final noPassengersInVicinity =
      'There are no passengers available in your vicinity!';
  // static final blocked = 'Blocked';
  static String youBlocked(String user) =>
      'You blocked $user. Tap the unblock button on the top right side to continue the chat!';
  static String youCantSendMessages(String user) =>
      'You can\'t send messages to $user anymore as you are blocked by $user.';
}

class ErrorStrings {
  static final scanError =
      'Something went wrong.\n Please try again and ensure to scan the barcode behind your ticket.';
  static final errorRequesting = 'Error occured while requesting';
  static final pleaseTryAgain = 'Please try again';
  static final errorAcceptingRequest =
      'Error occured while accepting request. Please try again';
  static final somethingWentWrong = 'Something went wrong. Please try again';
  static final errorSendingMessage =
      'Something went wrong while sending message!\nPlease try again.';
  static final errorBlocking =
      'Something went wrong while blocking. Please try again.';
  static final errorUnblocking =
      'Something went wrong while unblocking. Please try again.';
}
