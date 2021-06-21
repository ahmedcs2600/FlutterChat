import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realchat/MemberAccounts/MemberHomePage.dart';

import 'AuthConfig/AddInfo.dart';
import 'AuthConfig/HomePage.dart';
import 'AuthConfig/Login.dart';
import 'AuthConfig/Member.dart';
import 'AuthConfig/SignUp.dart';
import 'AuthConfig/start.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,


      home:
     HomePage(),
     //  DeputyChatActivityPage(),

      routes: {
        "start":(BuildContext context)=> StartPage(),
        "SignUp":(BuildContext context)=> SignUpPage(),
        "Member":(BuildContext context)=> Member(),
        "Login":(BuildContext context)=>LoginPage(),
        "AddInfo":(BuildContext context)=> AddSchoolInfo(),
        "MemberHomePage":(BuildContext context)=> MemberHomePage(),
      },

    );
  }
}
