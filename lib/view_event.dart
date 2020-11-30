import 'package:chickchat/add_event.dart';
import 'package:flutter/material.dart';
import 'package:chickchat/event.dart';
import 'package:toast/toast.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;
  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(icon: Icon(Icons.delete,color: Colors.black,size: 30,),
              onPressed: () => _deleteData(context, event.id),
            tooltip: "Delete event",
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
              Icon(Icons.article_rounded,size: 50),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              //Text("Event Tittle",style: TextStyle(fontSize: 22.0,),),
              Flexible(child: Text(event.title,style: TextStyle(fontSize: 22.0,),overflow: TextOverflow.ellipsis,maxLines: 3,)), //Theme.of(context).textTheme.display1
            ],
            ),
            // ignore: deprecated_member_use
            SizedBox(height: 20.0),
            
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: 'Edit your event',
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddEventPage(note: event),)),
        )
    );
  }

  void _deleteData(BuildContext context,String id) async {
    if(await _showConfirmationDialog(context)) {
      try {
        await EventModel().deleteData(id);
        Toast.show("Event has been deleted", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
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
          title: Text("Warning!!",textAlign: TextAlign.center,),
          content: Text("Are you sure you want to delete this event!? Once delete cannot undo the action!!"),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              textColor: Colors.white,
              color: Colors.red[600],
              child: Text("Delete"),
              onPressed: () => Navigator.pop(context,true),
            ),

            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.black)
              ),
              textColor: Colors.black,
              child: Text("No"),
              onPressed: () => Navigator.pop(context,false),
            ),
          ],
        )
    );
  }
}