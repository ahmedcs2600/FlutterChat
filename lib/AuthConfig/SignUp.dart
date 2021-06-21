import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realchat/AuthConfig/AddInfo.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool ishidePassword = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child("Schools");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController FullnameController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();

  SignUpRegisteration() async{
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        String FullName, Email, Password;

        FullName = FullnameController.text;
        Email = EmailController.text;
        Password = PasswordController.text;
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: Email, password: Password);
        if (userCredential != null) {
          String AuthID = userCredential.user.uid.toString();

          Map userDataMap = {
            "Name": FullName,
            "Email": Email,
            "ProfileImage": "",
            "Stage": "1",
            "OwnerID": AuthID,
          };

          await reference.child("School-Owners").child(AuthID).set(userDataMap);
          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddSchoolInfo()));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.pushReplacementNamed(context, "main");
                      }
                  ),
                ),
                SizedBox(height: 60,),
                Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Text('Start A Digital Journey',
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
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:20, vertical: 11),
                            child: TextFormField(
                              controller: FullnameController,
                                validator: (input){
                                  if(input.isEmpty) return 'Enter Full-Name';
                                  if(input.length<2){ return 'Name must bet at least 2 Charachters'; }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Full Name',
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
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:20, vertical: 9),
                            child: TextFormField(
                              controller: EmailController,
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter The E-mail';
                                  if (!input.contains('@')) {return 'Email Address is invalid';}
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
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:20, vertical: 11),
                            child: TextFormField(
                              controller: PasswordController,
                              validator: (input) {
                                if (input.isEmpty) return 'Enter The Password';
                                if (input.length < 6) {return 'Provide Minimum 6 Character';}
                              },
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: ShowPassword,
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
                              obscureText: ishidePassword,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),
                SizedBox(width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 60,
                    child: RaisedButton(
                      onPressed: (){
                        SignUpRegisteration();


                        // if(_name.length < 3)
                        // {
                        //   displayToastMessage("Name must be atleast 2 characters.", context);
                        // }
                        // else if(!_email.contains("@"))
                        // {
                        //   displayToastMessage("Email address is not valid.", context);
                        // }
                        // else if(_password.length < 6)
                        // {
                        //   displayToastMessage("Password must be atleast 5 characters", context);
                        // }

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
                            "Create Account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already Have An Account? ",
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    InkWell(
                      onTap: navigateToLogin,

                      child: Text(
                        " Login",
                        style: TextStyle(
                            fontSize: 16,
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
      ishidePassword = !ishidePassword;
    });
  }
}
