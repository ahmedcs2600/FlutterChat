import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'DeputyChatActivity.dart';
import 'chat_message.dart';

class ChatBubble extends StatefulWidget{

  ChatMessage chatMessage;
  ChatBubble({@required this.chatMessage});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String memberidreceiver = "HLnBqJuTTfMgZuoDqEoQX0AbIGE3";
  @override
  Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 7, 16, 7),
    child: Align(
      alignment: (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft: Alignment.topRight),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Color(0xFFD2D2D2))],
          borderRadius: BorderRadius.circular(30),
          color: (widget.chatMessage.type == MessageType.Receiver?Colors.white:Colors.grey.shade200 ),
        ),
        padding: EdgeInsets.all(13),
        child: Text(widget.chatMessage.message),
      ),
    ),
  );
  }
}