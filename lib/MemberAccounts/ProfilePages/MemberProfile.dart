import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realchat/AuthConfig/start.dart';

class MemberProfilePage extends StatefulWidget {
  final String SchoolUpin;
  const MemberProfilePage({Key key, this.SchoolUpin}) : super(key: key);

  @override
  _MemberProfilePageState createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  signOut() async {
    await _auth.signOut();
    //context.navigateClearStack(Start());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
        ModalRoute.withName("/ROOT"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
            child: ElevatedButton(
              child: Text('LogOut'),
              onPressed: () {
                signOut();
              },
            ),
          )),
    );
  }
}
