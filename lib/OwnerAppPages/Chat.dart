import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realchat/OwnerAppPages/DeputyChatActivity.dart';


class ChatPage extends StatefulWidget {
  final String SchoolUpin;
  const ChatPage({Key key, this.SchoolUpin}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Container(
                height: 60,
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
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
                      ),
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

              /// for listing members

              // Flexible(
              //   child: memberslist.length == 0 ? Center(child: Text("Add Your ", style: TextStyle(fontSize: 30),),): ListView.builder(
              //       itemCount: memberslist.length,
              //       itemBuilder: (_,index){
              //         return CardUI(memberslist[index].FullName, memberslist[index].MemberEmail, memberslist[index].MemberID,
              //             memberslist[index].ProfileImage, memberslist[index].Role, memberslist[index].StandardNumber, memberslist[index].UserBio, memberslist[index].InstID);
              //       }
              //   ),
              // ),
            ],
          ),
        ),

      ),
    );
  }
  Widget CardUI(String Fullname, String MemberEmail, String MemberID, String ProfileImage, String Role, String StandardNumber, String UserBio, String SchoolUpin){
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
          title: Row(
            children: [
              Expanded(
                  child: Text(Fullname,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
              // Text(Role),
            ],
          ),
          subtitle: Text(
            '@'+Role,
            style: TextStyle(
                fontSize: 11,
                color: Colors.grey),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DeputyChatActivityPage(SchoolUpin: widget.SchoolUpin, ChatUserID: MemberID, )));
          },
        ),
      ),
    );
  }
}
