import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child("Schools");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, SchoolUpin;

  checkAuthentification() async {
    firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }


  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
        await reference.child("School-Owners").child(firebaseAuth.currentUser.uid).child("inst-upin").once().then((DataSnapshot datasnapshot) {
          SchoolUpin = datasnapshot.value.toString();
          return Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
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

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }
  navigateToResetPassPage() async{
    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassPage()));
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
                        Navigator.pushReplacementNamed(context, 'start');
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
                  child: Text('Creator Can Access Account Here',
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
                                onSaved: (input) => _email = input
                            ),
                          ),
                        ),

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:20, vertical: 11),
                            child: TextFormField(
                                validator: (input) {
                                  if (input.length < 6)
                                    return 'Provide Minimum 6 Character';
                                },
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap:  _togglePasswordView,
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
                                obscureText: isHiddenPassword,
                                onSaved: (input) => _password = input
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
                      onPressed: login,
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
                      onTap: navigateToRegister,

                      child: Text(
                        " Create Account",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlueAccent
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Center(
                  child: InkWell(
                    onTap: navigateToResetPassPage,
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 200,),
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
  void _togglePasswordView(){
    setState(() {
      isHiddenPassword = ! isHiddenPassword;
    });
  }

}
