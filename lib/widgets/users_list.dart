import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realchat/chat/chat_room.dart';
import 'package:realchat/models/conversation_item.dart';
import 'package:realchat/viewmodel/user_model.dart';

class UsersList extends StatelessWidget {
  final List<ConversationItem> items;
  final String InstID;
  UsersList(this.items,this.InstID);

  get userId => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
          create: (_) => UserModel(items,InstID),
          child: Consumer<UserModel>(
            builder: (context, value, child) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(value.users[index].FullName), onTap: () {
                    String userId = value.users[index].MemberID;
                    int itemIndex = items.indexWhere((element) =>
                    element.toUserId == userId || element.fromUserId == userId);
                    if (itemIndex == -1) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ChatRoomPage(
                                  name: value.users[index].FullName,
                                  toUserId: userId,
                                  conversationId: null)));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ChatRoomPage(
                                  name: value.users[index].FullName,
                                  toUserId: userId,
                                  conversationId: items[itemIndex].conversationId)));
                    }
                  });
                },
                itemCount: value.users.length,
              );
            },
          )),
    );
  }
}
