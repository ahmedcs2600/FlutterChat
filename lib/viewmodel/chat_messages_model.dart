import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realchat/global/firebase_constants.dart';
import 'package:realchat/models/chat_item.dart';
import 'package:realchat/other/date_time.dart';

class ChatMessagesModel extends ChangeNotifier {
  List<ChatItem> messages = [];

  final DatabaseReference db =
      FirebaseDatabase().reference().child(FirebaseConstants.messages);
  final DatabaseReference conversationDb =
      FirebaseDatabase().reference().child(FirebaseConstants.conversation);
  final currentUserId = FirebaseAuth.instance.currentUser.uid;
  final String toUserId;
  final String conversationId;
  final String userName;
  StreamSubscription<Event> _onChildAdded;
  StreamSubscription<Event> _onChildChanged;

  ChatMessagesModel(
      {@required this.toUserId,
      @required this.conversationId,
      @required this.userName}) {
    _observe();
    _markRead();
  }

  void _markRead() {
    if(toUserId != FirebaseAuth.instance.currentUser.uid){
      print("$toUserId/$currentUserId");

      if(conversationId != null) {
        conversationDb.child(FirebaseAuth.instance.currentUser.uid).child(conversationId).update({
          "unreadCount" : 0
        });
      }


      db.child(toUserId).child(currentUserId).once().then((result) {
        Map<dynamic, dynamic> resultList2 = result.value;
        if((resultList2?.isNotEmpty ?? false)){
          resultList2.forEach((key, value) {
            final item = ChatItem.fromJson(value, key);
            print("isRead -> ${item.messageId}");
            db.child(toUserId).child(currentUserId).child(item.messageId).set({
              "message": item.message,
              "date_time": item.dateTime,
              "isRead": true,
              "fromId": item.fromId,
              "toUserId": item.toUserId
            });
          });
        }
      });
    }

  }

  void _observe() {
    print("${currentUserId}/${toUserId}");
    _onChildAdded =
        db.child(currentUserId).child(toUserId).onChildAdded.listen((event) {
      final item = ChatItem.fromJson(event.snapshot.value, event.snapshot.key);
      messages.add(item);

      if(currentUserId != FirebaseAuth.instance.currentUser.uid) {

        if(conversationId != null) {
          conversationDb.child(FirebaseAuth.instance.currentUser.uid).child(conversationId).update({
            "unreadCount" : 0
          });
        }


        db.child(toUserId).child(currentUserId).child(item.messageId).set({
          "message": item.message,
          "date_time": item.dateTime,
          "isRead": true,
          "fromId": item.fromId,
          "toUserId": item.toUserId
        });
      }
      notifyListeners();

      /*  print("event---> ${event.snapshot.value.toString()}");
          print("event---> ${event.runtimeType.toString()}");
      Map<dynamic, dynamic> resultList2 = event.snapshot.value;
      resultList2.forEach((key, value) {

      });*/
    });

    _onChildChanged =
        db.child(currentUserId).child(toUserId).onChildChanged.listen((event) {
      print("onChildChanged -> ${event.snapshot.value.toString()}");
      final item = ChatItem.fromJson(event.snapshot.value, event.snapshot.key);
      int index = messages
          .indexWhere((element) => item.messageId == element.messageId);
      if (index != -1) {
        messages[index] = item;
        notifyListeners();
      }

      /*  print("event---> ${event.snapshot.value.toString()}");
          print("event---> ${event.runtimeType.toString()}");
      Map<dynamic, dynamic> resultList2 = event.snapshot.value;
      resultList2.forEach((key, value) {

      });*/
    });
  }

  void sendMessage(String message) {
    final key = db.child(currentUserId).child(toUserId).push().key;

    // My Node
    db.child(currentUserId).child(toUserId).child(key).set({
      "message": message,
      "date_time": getCurrentUtcDateTime(),
      "isRead": false,
      "fromId": currentUserId
    });

    // to user node
    final key2 = db.child(toUserId).child(currentUserId).push().key;
    db.child(toUserId).child(currentUserId).child(key2).set({
      "message": message,
      "date_time": getCurrentUtcDateTime(),
      "isRead": false,
      "fromId": currentUserId,
      "toUserId": toUserId,
    });

    // conversation
    if (conversationId == null) {
      final key = conversationDb.child(toUserId).push().key;
      conversationDb.child(toUserId).child(key).set({
        "message": message,
        "date_time": getCurrentUtcDateTime(),
        "fromUserId": toUserId,
        "toUserId": currentUserId,
        "userName": FirebaseAuth.instance.currentUser.displayName,
        "timeStamp" : DateTime.now().toUtc().millisecondsSinceEpoch,
        "unreadCount" : messages.where((element) => element.fromId == FirebaseAuth.instance.currentUser.uid).toList().length + 1
      });

      conversationDb.child(currentUserId).child(key).set({
        "message": message,
        "date_time": getCurrentUtcDateTime(),
        "fromUserId": currentUserId,
        "toUserId": toUserId,
        "userName": userName,
        "timeStamp" : DateTime.now().toUtc().millisecondsSinceEpoch
      });
    } else {
      conversationDb.child(toUserId).child(conversationId).set({
        "message": message,
        "date_time": getCurrentUtcDateTime(),
        "fromUserId": toUserId,
        "toUserId": currentUserId,
        "userName": FirebaseAuth.instance.currentUser.displayName,
        "timeStamp" : DateTime.now().toUtc().millisecondsSinceEpoch,
        "unreadCount" : messages.where((element) => element.fromId == FirebaseAuth.instance.currentUser.uid).toList().length + 1
      });

      conversationDb.child(currentUserId).child(conversationId).set({
        "message": message,
        "date_time": getCurrentUtcDateTime(),
        "fromUserId": currentUserId,
        "toUserId": toUserId,
        "userName": userName,
        "timeStamp" : DateTime.now().toUtc().millisecondsSinceEpoch
      });
    }
  }

  @override
  void dispose() {
    _onChildAdded.cancel();
    _onChildChanged.cancel();
    super.dispose();
  }
}
