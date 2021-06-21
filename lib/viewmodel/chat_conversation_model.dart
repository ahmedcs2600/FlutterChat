import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realchat/global/firebase_constants.dart';
import 'package:realchat/models/conversation_item.dart';

class ChatConversationModel extends ChangeNotifier {
  final DatabaseReference conversationDb =
  FirebaseDatabase().reference().child(FirebaseConstants.conversation);

  List<ConversationItem> items = [];

  StreamSubscription<Event> _streamSubscription;

  ChatConversationModel() {
    _observe();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void _observe() {
    _streamSubscription = conversationDb.child(FirebaseAuth.instance.currentUser.uid).onValue.listen((event) {
      items.clear();
      Map<dynamic, dynamic> resultList2 = event.snapshot.value;
      if(resultList2 != null){
        resultList2.forEach((key, value) {
          final item = ConversationItem.fromJson(value, key);
          items.add(item);
        });
        items.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
        notifyListeners();
      }
    });
    /*_onChildAdded = conversationDb.child(FirebaseAuth.instance.currentUser.uid).onValue.listen((event) {
      items.add(ConversationItem.fromJson(event.snapshot.value,event.snapshot.key));
      notifyListeners();
    });
    _onChildChanged = conversationDb.child(FirebaseAuth.instance.currentUser.uid).onChildChanged.listen((event) {
      final item = ConversationItem.fromJson(event.snapshot.value,event.snapshot.key);
      int index = items.indexWhere((element) => item.conversationId == element.conversationId);
      if(index != -1){
        items[index] = item;
        notifyListeners();
      }
    });*/
  }
}