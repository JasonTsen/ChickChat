import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

// ignore: deprecated_member_use
class EventModel extends DatabaseItem{
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime eventDate;
  final String creator;
  final String eventTimeStart;
  final String eventTimeEnd;

  EventModel({this.id,this.title, this.description, this.location, this.eventDate, this.creator ,this.eventTimeStart, this.eventTimeEnd}):super(id);

  factory EventModel.fromMap(Map data) {

    return EventModel(
      title: data['title'],
      description: data['description'],
      location: data['location'],
      eventDate: data['event_date'],
      creator: data['creator'],
      eventTimeStart: data['event_timeStart'],
      eventTimeEnd: data['event_timeEnd']
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    //
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      location: data['location'],
      eventDate: data['event_date'].toDate(),
      creator: data['creator'],
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
      "creator":creator,
      "event_timeStart":eventTimeStart,
      "event_timeEnd": eventTimeEnd,
      "id":id,
    };
  }

  Future<void> deleteData(String id) {
    // ignore: deprecated_member_use
    return Firestore.instance.collection('events').document(id).delete();
  }

  Future<void> updateData(String id) {
    // ignore: deprecated_member_use
    return Firestore.instance.collection('events').document(id).updateData(toMap());
  }

}