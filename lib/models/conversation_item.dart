class ConversationItem {
  String dateTime;
  String fromUserId;
  String toUserId;
  String message;
  String userName;
  String conversationId;
  int timeStamp;
  int unreadCount;


  ConversationItem.fromJson(Map<dynamic,dynamic> data, String key) {
    dateTime = data["dateTime"];
    fromUserId = data["fromUserId"];
    toUserId = data["toUserId"];
    message = data["message"];
    userName = data["userName"];
    timeStamp = data["timeStamp"];
    unreadCount = data["unreadCount"];
    conversationId = key;
  }
}