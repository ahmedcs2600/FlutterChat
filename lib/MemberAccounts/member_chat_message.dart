import 'package:flutter/cupertino.dart';
import 'package:realchat/MemberAccounts/MemberChatActivity.dart';

class ChatMessage{
  String message;
  MessageType type;
  ChatMessage({@required this.message,@required this.type});
}