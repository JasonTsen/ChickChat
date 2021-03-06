import 'package:chickchat/add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chickchat/myCalendarStaff.dart';
import 'package:chickchat/event.dart';

class StaffEventDetailsPage extends StatelessWidget {
  final EventModel event;
  const StaffEventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold),),
          // actions: [
          //   IconButton(icon: Icon(Icons.delete,color: Colors.white,size: 30,),
          //     onPressed: () => _deleteData(context, event.id),
          //   ),
          // ],
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ignore: deprecated_member_use
              SizedBox(height: 40.0),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Icon(Icons.description,size: 50),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Flexible(child: Text(event.description, style: TextStyle(fontSize: 22.0,),overflow: TextOverflow.ellipsis,maxLines: 6,)),
                ],
              ),

              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Icon(Icons.location_on_rounded,size: 50),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Flexible(child: Text(event.location, style: TextStyle(fontSize: 22.0,),overflow: TextOverflow.ellipsis,maxLines: 3,)),
                ],
              ),
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Icon(Icons.access_time,size: 50),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Flexible(child: Text(event.eventTimeStart + ' - ' + event.eventTimeEnd, style: TextStyle(fontSize: 22.0,),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                ],),
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Icon(Icons.supervised_user_circle,size: 50),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Flexible(child: Text(event.creator, style: TextStyle(fontSize: 22.0,),overflow: TextOverflow.ellipsis,maxLines: 3,)),
                ],
              ),


            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.edit),
        //   tooltip: 'Edit your event',
        //   onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddEventPage(note: event),)),
        // )
    );
  }

  // void _deleteData(BuildContext context,String id) async {
  //   if(await _showConfirmationDialog(context)) {
  //     try {
  //       await EventModel().deleteData(id);
  //     }catch(e) {
  //       print(e);
  //     }
  //   }
  // }

  // Future<bool> _showConfirmationDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) => AlertDialog(
  //         title: Text("Warning!!",textAlign: TextAlign.center,),
  //         content: Text("Are you sure you want to delete this event!? Once delete cannot undo the action!!"),
  //
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               textColor: Colors.white,
  //               color: Colors.red[600],
  //               child: Text("Delete"),
  //               onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyCalendar(),),result: true)
  //           ),
  //
  //           FlatButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 side: BorderSide(color: Colors.black)
  //             ),
  //             textColor: Colors.black,
  //             child: Text("No"),
  //             onPressed: () => Navigator.pop(context,false),
  //           ),
  //         ],
  //       )
  //   );
  // }
}