import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Member.dart';
import 'SignUp.dart';
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}
class _StartPageState extends State<StartPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              SizedBox(height: 90),
              Center(
                child: Container(
                  height: 100,
                  child: Image(
                    image: AssetImage("images/logo101.png"),
                  ),
                ),
              ),
              SizedBox(height: 80),

              Card(
                margin: EdgeInsets.only(left: 20, right: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('Destination',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5
                        ) ,
                      ),
                      SizedBox(height: 5,),
                      Text(
                        'Choose Your  Authorized Destination',
                        style: TextStyle(
                            color: Color(0xFF727171),
                            fontSize: 12
                        ),
                      ),

                      SizedBox(height: 25),
                      SizedBox(width: double.infinity,
                        child: Container(
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                            },
                            padding: EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff2193b0), Color(0xff6dd5ed)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 52.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Creator",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),),
                      ),
                      SizedBox(height: 25,),
                      Text(
                        'Or',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,

                        ),
                      ),
                      SizedBox(height: 25),
                      SizedBox(width: double.infinity,
                        child: Container(
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Member()));
                            },
                            padding: EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff06beb6), Color(0xff48b1bf)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 52.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Member",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 120,),
              InkWell(
                // onTap: googleSignIn,
                child: Text('Powered By Lods',
                  style: TextStyle(
                    color: Color(0xFFA7A5A5),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
