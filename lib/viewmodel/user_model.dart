import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realchat/global/firebase_constants.dart';
import 'package:realchat/models/conversation_item.dart';
import 'package:realchat/models/people_item.dart';

class UserModel extends ChangeNotifier {
  final DatabaseReference db = FirebaseDatabase().reference();

  final fb = FirebaseDatabase.instance;

  List<PeopleItem> users = [];
  final String instID;


  UserModel(List<ConversationItem> items, this.instID) {
    _getUsersList();
  }

  void _getUsersList() {
    db.child("${FirebaseConstants.schools}/$instID/School-Members").once().then((result) {
      if (result.value != null) {
        Map<dynamic, dynamic> resultList2 = result.value;
        resultList2.forEach((key, value) {
          final item = PeopleItem.fromJson(value, key);
          if (item.MemberID != FirebaseAuth.instance.currentUser.uid) {
            users.add(item);
          }
        });

        notifyListeners();
      }
    });
  }
}
