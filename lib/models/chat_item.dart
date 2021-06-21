class ChatItem {
  String dateTime;
  bool isRead;
  String message;
  String fromId;
  String toUserId;
  String messageId;

  ChatItem.fromJson(Map<dynamic,dynamic> data,String id) {
    dateTime = data["date_time"];
    isRead = data["isRead"];
    message = data["message"];
    fromId = data["fromId"];
    toUserId = data["toUserId"];
    messageId = id;
  }
}