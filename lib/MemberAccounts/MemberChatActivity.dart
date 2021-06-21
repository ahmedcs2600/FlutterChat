import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realchat/MemberAccounts/member_chat_message.dart';

import 'member_chat_bubble.dart';

enum MessageType{
  Sender,
  Receiver,
}


class MemberChatActivityPage extends StatefulWidget {
  final String SchoolUpin, ChatUserID;
  const MemberChatActivityPage({Key key, this.SchoolUpin, this.ChatUserID}) : super(key: key);

  @override
  _MemberChatActivityPageState createState() => _MemberChatActivityPageState();
}

class _MemberChatActivityPageState extends State<MemberChatActivityPage> {


  Future<void> FetchRecievermeMessages() async{

  }

  List<ChatMessage> chatMessage = [
    ChatMessage(message: "Hi John", type: MessageType.Receiver),
    ChatMessage(message: "Hope, You are doing well", type: MessageType.Receiver),
    ChatMessage(message: "Hi Supervisor", type: MessageType.Sender),
    ChatMessage(message: "Yes I am well", type: MessageType.Sender),
    ChatMessage(message: "And Whats About You?", type: MessageType.Sender),
    ChatMessage(message: " I am fine too", type: MessageType.Receiver),
    ChatMessage(message: " I am fine too", type: MessageType.Receiver),
    ChatMessage(message: "Have you done your home work", type: MessageType.Receiver),
    ChatMessage(message: "Yes Supervisor, And i am going to attend Nas Class by now, So see you later", type: MessageType.Sender),
    ChatMessage(message: "See Later Mr", type: MessageType.Sender),
    ChatMessage(message: "See Later Mr", type: MessageType.Sender),
    ChatMessage(message: "Have A Good Day Mr", type: MessageType.Sender),
    ChatMessage(message: "Have A Good Day Mr", type: MessageType.Sender),
    ChatMessage(message: " I am fine too", type: MessageType.Receiver),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          flexibleSpace: Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,color: Colors.grey,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              // SizedBox(width: 10,),
              Center(
                child: CircleAvatar(
                 maxRadius: 20,
                ),
              ),
              SizedBox(width: 15,),
              Text(
                'Supervisor', style: TextStyle(
                fontSize: 15
              ),
              ),
            ],
          ),
        ),
        body: Stack(
          children:<Widget> [
            ListView.builder(
              itemCount: chatMessage.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 80),
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                return ChatBubble(
                 chatMessage: chatMessage[index],
                );
                },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 80,
                width: double.infinity,
               color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        width: double.infinity,
                        color: Colors.white,
                        child: TextFormField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Type message...',
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 70,
                        width: 40,
                        padding: EdgeInsets.only(right: 5),
                        color: Colors.white,
                        child: IconButton(
                          splashColor: Colors.amberAccent,
                          onPressed: (){},
                          icon: Icon(
                          Icons.send,
                        ),
                          iconSize: 28,
                          tooltip: "Send to message",
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
