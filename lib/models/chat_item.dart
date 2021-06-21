class ChatItem {
  String dateTime;
  bool isRead;
  String message;
  String fromId;
  String toUserId;
  String messageId;

  ChatItem.fromJson(Map<dynamic,dynamic> data,String id) {
    dateTime = data["dateTime"];
    isRead = data["isRead"];
    message = data["message"];
    fromId = data["fromId"];
    toUserId = data["toUserId"];
    messageId = id;
  }
}