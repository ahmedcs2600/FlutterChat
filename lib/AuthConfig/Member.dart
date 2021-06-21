import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realchat/MemberAccounts/MemberHomePage.dart';

class Member extends StatefulWidget {
  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  bool mhidePassword = true;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fb = FirebaseDatabase.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _memail, _mpassword, _upin;

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  checkAuthentification() async {
    /*_auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        //Navigator.pushReplacementNamed(context, "MemberHomePage");
      }
    });*/
  }


  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final ref = fb.reference().child("Schools");
      try {
        await _auth.signInWithEmailAndPassword(
            email: _memail, password: _mpassword);
        // when we are login in we are fetching the user data from database and storing in the static model it can be used anywhere in the app
        await ref.child(_upin).child("School-Members").child(_auth.currentUser.uid).child("StandardNumber").once().then((DataSnapshot datasnapshot){
          String StandardNo = datasnapshot.value.toString();

          if(StandardNo == "1") {
            Navigator.of(context).pushReplacementNamed("MemberHomePage");
          }
          //
          // else if(StandardNo == "2") {
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => ()));
          // }
          //
          else if(StandardNo == "3") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MemberHomePage()),
                ModalRoute.withName("/ROOT"));
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MemberHomePage()));
          }

        });
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  displayToastMessage(String message, BuildContext context)
  {
    Fluttertoast.showToast(msg: message);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: new IconButton(
                      icon: Icon(
                        Icons.close,color: Colors.grey,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                SizedBox(height: 60,),
                Center(
                  child: Text(
                    'Login Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Text('Members Can Access Account Here',
                    style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF797979)

                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:20, vertical: 9),
                            child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Your School Upin';
                                },
                                decoration: InputDecoration(
                                  hintText: 'School Upin',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFA7A6A6), width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.lightBlueAccent
                                ),
                                onSaved: (input) => _upin = input
                            ),
                          ),
                        ),

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:20, vertical: 9),
                            child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Email';
                                },
                                decoration: InputDecoration(
                                  hintText: 'E-mail',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFA7A6A6), width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.lightBlueAccent
                                ),
                                onSaved: (input) => _memail = input
                            ),
                          ),
                        ),

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:20, vertical: 11),
                            child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty)
                                    return 'Password field is empty';
                                },
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap:  ShowPassword,
                                    child: Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFA7A6A6), width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.lightBlueAccent,
                                ),
                                obscureText: mhidePassword,
                                onSaved: (input) => _mpassword = input
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 55.0,
                    child: RaisedButton(
                      onPressed: (){
                        login();
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
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't Have An Account? ",
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    InkWell(
                      onTap: (){},

                      child: Text(
                        " Contact Your Principle",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlueAccent
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 120,),
                Center(
                  child: Text('Powered By Lods',
                    style: TextStyle(
                      color: Color(0xFFA7A5A5),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
  void ShowPassword(){
    setState(() {
      mhidePassword = !mhidePassword;
    });
  }
}
