import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realchat/AuthConfig/start.dart';

class ProfilePage extends StatefulWidget {
  final String SchoolUpin;
  const ProfilePage({Key key, this.SchoolUpin}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
