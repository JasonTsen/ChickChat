import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';

// ignore: deprecated_member_use
class OnlineApplicationModel extends DatabaseItem{
  final String id;
  final String userName;
  final String reason;
  final String email;
  final String phoneNumber;
  final DateTime onlineApplicationDate;
  final DateTime onlineApplicationTime;


  OnlineApplicationModel({this.id,this.userName, this.reason, this.email, this.phoneNumber, this.onlineApplicationDate, this.onlineApplicationTime}):super(id);

  factory OnlineApplicationModel.fromMap(Map dataOnline) {
    return OnlineApplicationModel(
        userName: dataOnline['userName'],
        reason: dataOnline['reason'],
        email: dataOnline['email'],
        phoneNumber: dataOnline['phoneNumber'],
        onlineApplicationDate: dataOnline['onlineApplication_Date'],
        onlineApplicationTime: dataOnline['onlineApplication_Time'],
    );
  }

  factory OnlineApplicationModel.fromDS(String id, Map<String,dynamic> dataOnline) {
    return OnlineApplicationModel(
        id: id,
        userName: dataOnline['userName'],
        reason: dataOnline['reason'],
        email: dataOnline['email'],
        phoneNumber: dataOnline['phoneNumber'],
        onlineApplicationDate: dataOnline['onlineApplication_Date'].toDate(),
        onlineApplicationTime: dataOnline['onlineApplication_Time']
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "userName":userName,
      "reason": reason,
      "email": email,
      "phoneNumber": phoneNumber,
      "onlineApplication_Date":onlineApplicationDate,
      "onlineApplication_Time": onlineApplicationTime,
      "id":id,
    };
  }

}