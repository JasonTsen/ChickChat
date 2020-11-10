import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chickchat/event.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;
  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        actions: [
          IconButton(icon: Icon(Icons.delete,color: Colors.white,size: 30,),
              onPressed: () => _deleteData(context, event.id),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ignore: deprecated_member_use
            SizedBox(height: 40.0),
            Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Icon(IconData(61577, fontFamily: 'MaterialIcons'),size: 50,),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              //Text("Event Tittle",style: TextStyle(fontSize: 22.0,),),
              Text(event.title,style: TextStyle(fontSize: 22.0,),), //Theme.of(context).textTheme.display1
            ],
            ),
            // ignore: deprecated_member_use
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Icon(IconData(59047, fontFamily: 'MaterialIcons'),size: 50,),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              Text(event.description, style: TextStyle(fontSize: 22.0,),),
            ],
            ),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Icon(IconData(58022, fontFamily: 'MaterialIcons'),size: 50,),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              Text(event.location, style: TextStyle(fontSize: 22.0,),)
            ],
            ),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Icon(IconData(58715, fontFamily: 'MaterialIcons'),size: 50,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text(event.eventTimeStart + ' - ' + event.eventTimeEnd, style: TextStyle(fontSize: 22.0,),)
              ],)


          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () => Navigator.pushNamed(context, 'add_event'),
        )
    );
  }

  void _deleteData(BuildContext context,String id) async {
    if(await _showConfirmationDialog(context)) {
      try {
        await EventModel().deleteData(id);
      }catch(e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text("Caution!!"),
          content: Text("Are you sure you want to delete this event!?"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.red,
              child: Text("Delete"),
              onPressed: () => Navigator.pop(context,true),
            ),
            FlatButton(
              textColor: Colors.black,
              child: Text("No"),
              onPressed: () => Navigator.pop(context,false),
            ),
          ],
        )
    );
  }
}