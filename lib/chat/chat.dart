import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realchat/chat/chat_room.dart';
import 'package:realchat/models/conversation_item.dart';
import 'package:realchat/viewmodel/chat_conversation_model.dart';
import 'package:realchat/widgets/users_list.dart';

class Chat extends StatefulWidget {
  final String InstID;

  Chat({@required this.InstID});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Widget _searchBox() {
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.only(
          top: 5,
          left: 15,
          right: 5,
          bottom: 5,
        ),
        width: double.infinity,
        color: Colors.white,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Teachers',
            filled: true,
            fillColor: Color(0xD5F7F7F7),
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
    );
  }

  Widget _list(List<ConversationItem> items) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CardUI(items[index].userName, items[index].message,
              items[index].toUserId, items[index].conversationId,items[index].unreadCount);
        },
        itemCount: items.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider(
            create: (_) => ChatConversationModel(),
            child: Consumer<ChatConversationModel>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60,
                            child: Card(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _searchBox(),

                                  // Container(
                                  //     height: 70,
                                  //     width: 40,
                                  //     padding: EdgeInsets.only(right: 5),
                                  //     color: Colors.white,
                                  //     child: Icon(Icons.search,
                                  //     )
                                  // )
                                ],
                              ),
                            ),
                          ),
                          _list(value.items),

                          /// Bro this the flexible list where you will be fetch in list so we can talk to them.
                          //     Flexible(
                          //       child: memberslist.length == 0 ? Center(child: Text(
                          //         "Add Your person for chat ",
                          //         style: TextStyle(fontSize: 30),),) : ListView.builder(
                          //           itemCount: memberslist.length,
                          //           itemBuilder: (_, index) {
                          //             return CardUI(
                          //                 memberslist[index].FullName,
                          //       ),
                          //     ),
                        ],
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UsersList(value.items, widget.InstID)));
                          },
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            )));
  }

  Widget CardUI(
    String Fullname,
    String message,
    String userId,
    String convId, int unreadCount,
  ) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.fromLTRB(7, 5, 7, 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        // side: BorderSide(color: Color(0xFFF3F3F3)),
      ),
      child: GestureDetector(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Fullname ?? "N/A",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(message, style: TextStyle(fontSize: 12))
              // Text(Role),
            ],
          ),
          trailing: unreadCount == null || unreadCount <= 0 ? SizedBox() : Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // You can use like this way or like the below line
              //borderRadius: new BorderRadius.circular(30.0),
              color: Colors.green,
            ),
            child: Center(
                child: Text(
                  unreadCount.toString(),
              style: TextStyle(color: Colors.white),
            )),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatRoomPage(
                          name: Fullname,
                          toUserId: userId,
                          conversationId: convId,
                        )));
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
