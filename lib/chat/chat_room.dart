import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realchat/models/chat_item.dart';
import 'package:realchat/viewmodel/chat_messages_model.dart';

import '../../widgets/chat_bubble.dart';

class ChatRoomPage extends StatefulWidget {
  final String name;
  final String toUserId;
  final String conversationId;

  const ChatRoomPage(
      {Key key,
      @required this.name,
      @required this.toUserId,
      @required this.conversationId})
      : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final _messageController = TextEditingController();

  Widget _sendMessageView(ChatMessagesModel value) {
    return Container(
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
              child: TextField(
                controller: _messageController,
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
                onPressed: () {
                  final message = _messageController.text;
                  value.sendMessage(message);
                  _messageController.text = "";
                },
                icon: Icon(
                  Icons.send,
                ),
                iconSize: 28,
                tooltip: "Send to message",
              )),
        ],
      ),
    );
  }


  final _scrollController = ScrollController();

  Widget _messages(List<ChatItem> messages) {
    Timer(
      Duration(seconds: 1),
          () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    );
    return ListView.builder(
      controller: _scrollController,
      itemCount: messages.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ChatBubble(
          chatMessage: messages[index],
        );
      },
    );
  }

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
                    Icons.arrow_back,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              // SizedBox(width: 10,),
              Center(
                child: CircleAvatar(
                  maxRadius: 20,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                widget.name ?? "N/A",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        body: ChangeNotifierProvider(
          create: (_) => ChatMessagesModel(
              toUserId: widget.toUserId,
              conversationId: widget.conversationId,
              userName: widget.name),
          child: Consumer<ChatMessagesModel>(
            builder: (context, value, child) {
              return Column(
                children: <Widget>[
                  Expanded(child: _messages(value.messages)),
                  _sendMessageView(value)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
