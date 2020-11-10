import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

// ignore: deprecated_member_use
class EventModel extends DatabaseItem{
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime eventDate;
  final String eventTimeStart;
  final String eventTimeEnd;

  EventModel({this.id,this.title, this.description, this.location, this.eventDate, this.eventTimeStart, this.eventTimeEnd}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      location: data['location'],
      eventDate: data['event_date'],
      eventTimeStart: data['event_timeStart'],
      eventTimeEnd: data['event_timeEnd']
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      location: data['location'],
      eventDate: data['event_date'].toDate(),
      eventTimeStart: data['event_timeStart'],
      eventTimeEnd: data['event_timeEnd']
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "title":title,
      "description": description,
      "location": location,
      "event_date":eventDate,
      "event_timeStart":eventTimeStart,
      "event_timeEnd": eventTimeEnd,
      "id":id,
    };
  }

  Future<void> deleteData(String id) {
    // ignore: deprecated_member_use
    return Firestore.instance.collection('events').document(id).delete();
  }
}