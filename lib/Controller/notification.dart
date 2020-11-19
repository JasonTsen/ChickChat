import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'chatFirebase.dart';


FirebaseAuth auth = FirebaseAuth.instance;
String token;
DocumentSnapshot document;
FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    print('myBackgroundMessageHandler data');
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    print('myBackgroundMessageHandler notification');
    final dynamic notification = message['notification'];
  }
  // Or do other work.
}

class NotificationController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static NotificationController get instance => NotificationController();

//  NotificationController() {
//    takeFCMTokenWhenAppLaunch();
//    initLocalNotification();
//  }
  Future<void> updateUserToken(userID, token) async {
    await FirebaseFirestore.instance.collection('Users').doc(userID).set({
      'FCMToken':token,
    });
  }
  Future takeFCMTokenWhenAppLaunch() async {
    try{
      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
            sound: true,
            badge: true,
            alert: true
        ));
      }

      String userToken = document.data()['FCMToken'];
      if (userToken == null) {
        _firebaseMessaging.getToken().then((val) async {
          print('Token: '+val);
          userToken = val;
          String id = document.data()['userId'];
          if(id != null) {
            updateUserToken(id, val);
          }
        });
      }

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          String msg = 'notibody';
          String name = 'chatapp';
          if (Platform.isIOS) {
            msg = message['aps']['alert']['body'];
            name = message['aps']['alert']['title'];
          }else {
            msg = message['notification']['body'];
            name = message['notification']['title'];
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String currentChatRoom = (prefs.get('currentChatRoom') ?? 'None');

          if(Platform.isIOS) {
            if(message['chatroomid'] != currentChatRoom) {
              sendLocalNotification(name,msg);
            }
          }else {
            if(message['data']['chatroomid'] != currentChatRoom) {
              sendLocalNotification(name,msg);
            }
          }

          FirebaseController.instance.getUnreadMSGCount();
        },
        onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );

    }catch(e) {
      print(e.message);
    }
  }

  Future initLocalNotification() async{
    if (Platform.isIOS) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }else {// set Android Local notification.
      var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }
  }

  Future _onDidReceiveLocalNotification(int id, String title, String body, String payload) async { }

  Future _selectNotification(String payload) async { }

  sendLocalNotification(name,msg) async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, name, msg, platformChannelSpecifics,
        payload: 'item x');
  }

  // Send a notification message

  Future<void> sendNotificationMessageToPeerUser(unReadMSGCount,messageType,textFromTextField,myName,chatID,peerUserToken) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAADhAsv_s:APA91bFvInxyKDPPfr-CBIQw7Q2uoc1BSJbNdJWp3yvhCRYIGe-51VGIQOlKwuhOF9CfW24gf8zI1-xkubpu9ybd91138poRe5OgFtOUTfnmJzEQus8-m7zIBQqTkorCUMQOJJemkZAT',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': messageType == 'text' ? '$textFromTextField' : '(Photo)',
            'title': '$myName',
            'badge':'$unReadMSGCount',//'$unReadMSGCount'
            "sound" : "default"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'chatroomid': chatID,
          },
          'to': peerUserToken,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
  }
}