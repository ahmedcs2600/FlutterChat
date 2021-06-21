
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realchat/models/chat_item.dart';



class ChatBubble extends StatefulWidget {
  ChatItem chatMessage;

  ChatBubble({@required this.chatMessage});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String memberidreceiver = "HLnBqJuTTfMgZuoDqEoQX0AbIGE3";

  bool get isMyMessage {
    //print("from Id -> " + widget.chatMessage.fromId);
    //print("current user Id -> " + FirebaseAuth.instance.currentUser.uid);
    return widget.chatMessage.fromId == FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 7, 16, 7),
      child: Align(
        alignment: (!isMyMessage ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Color(0xFFD2D2D2))],
            borderRadius: BorderRadius.circular(30),
            color: (!isMyMessage ? Colors.white : Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(13),
          child: Column(
            children: [
              Text(widget.chatMessage.message),
              if(isMyMessage)Icon(
                widget.chatMessage.isRead ? Icons.check_circle_outline : Icons.check,
                color:
                    Colors.black,
                size: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
