import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'HomePage.dart';

class AddSchoolInfo extends StatefulWidget {
  @override
  _AddSchoolInfoState createState() => _AddSchoolInfoState();
}

class _AddSchoolInfoState extends State<AddSchoolInfo> {
  final fb = FirebaseDatabase.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _phoneno, _bio, _address, _instname, _instemail;

  Addbiodata() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      {
        // String randomnumber;
        Random random = new Random();
        int randomNumber = random.nextInt(1000000000);

        String SchoolUpin = randomNumber.toString();

        final ref = fb.reference().child("Schools");
        String AuthID = _auth.currentUser.uid;
        Map userDataMap = {
          "head-name": _name,
          "head-email": _email,
          "inst-name": _instname,
          "inst-email": _instemail,
          "inst-phoneno": _phoneno,
          "inst-bio": _bio,
          "inst-address": _address,
          "inst-upin": SchoolUpin,
          "ownerId": AuthID,

        };


        await ref.child(SchoolUpin).child("School-Info").set(userDataMap);
        await ref.child("School-Owners").child(AuthID).update({
          "Stage": "2",
          "inst-upin": SchoolUpin,
        });
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Add Information',
                  style: TextStyle(
                    color: Color(0xFF343434),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 1,),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Do not leave the page without filling',
                  style: TextStyle(
                    color: Color(0xFF8D8C8C),
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Full-Name';
                                if(input.length<2) {return 'Name must be at 2 Characters';}
                              },
                              decoration: InputDecoration(
                                hintText: 'Head Name (Principle)',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  BorderSide(color: Color(0xFFDEDDDD)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF797979), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.lightBlueAccent),
                              onSaved: (input) => _name = input),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Head E-mail';
                                if(!input.contains('@')) {return 'Email is not in correct form';}
                              },
                              decoration: InputDecoration(
                                hintText: 'Head E-mail',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  BorderSide(color: Color(0xFFDEDDDD)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA7A6A6), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                              ),
                              onSaved: (input) => _email = input),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Institution Name';
                                if (input.length<2) {return 'Institution Name must be at 2 Characters';}
                              },
                              decoration: InputDecoration(
                                hintText: 'Institution Name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  BorderSide(color: Color(0xFFDEDDDD)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA7A6A6), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                              ),
                              onSaved: (input) => _instname = input),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Institution E-mail';
                                if(!input.contains('@')) {return 'E-mail is invalid';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Institution E-mail',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  BorderSide(color: Color(0xFFDEDDDD)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA7A6A6), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                              ),
                              onSaved: (input) => _instemail = input),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty)
                                return 'Enter Institution Phone Number';
                            },
                            decoration: InputDecoration(
                              hintText: 'Institution Phone Number',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Color(0xFFDEDDDD)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFA7A6A6), width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.lightBlueAccent,
                            ),
                            onSaved: (input) => _phoneno = input,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:20, vertical: 9),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty)
                                return 'Enter Institution Address';
                            },
                            decoration: InputDecoration(
                              labelText: "Bio :",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xFFDCDBDB)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            maxLines: 2,
                            maxLength: 150,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty)
                                  return 'Enter Institution Address';
                                if(input.length<13) {return 'Enter your Full Address';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Institution Address',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  BorderSide(color: Color(0xFFDEDDDD)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA7A6A6), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                              ),
                              onSaved: (input) => _address = input),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 55.0,
                  child: RaisedButton(
                    onPressed: () async {
                      await Addbiodata();
                      return;

                    },
                    padding: EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Update",
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
            ],
          ),
        ),
      ),
    );
  }
}
