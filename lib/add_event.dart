import 'package:chickchat/event.dart';
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';
import 'package:chickchat/event_firestore_service.dart';

class AddEventPage extends StatefulWidget {
  final EventModel note;
  const AddEventPage({Key key, this.note}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  TextEditingController _location;
  DateTime _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 8,minute: 00),
    TimeOfDay(hour: 20,minute: 00),
  );
  TimeRangeResult _timeRange;
  bool processing;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(text:  widget.note != null ? widget.note.description : "");
    _location = TextEditingController(text: widget.note != null ? widget.note.location: "");
    _eventDate = DateTime.now();
    _timeRange = _defaultTimeRange;
    processing = false;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Event" : "Create Event"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Event title" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Event description" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event description",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _location,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Event Location" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event Location",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Date (YYYY-MM-DD)"),
                subtitle: Text("${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                onTap: ()async{
                  DateTime picked = await showDatePicker(context: context, initialDate: _eventDate, firstDate: DateTime(_eventDate.year-5), lastDate: DateTime(_eventDate.year+5));

                  if(picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                  }
                },
              ),

              const SizedBox(height: 10.0),
              TimeRange(
                  fromTitle: Text('From', style: TextStyle(fontSize: 18,),),
                  toTitle: Text('To', style: TextStyle(fontSize: 18,),),
                  titlePadding: 20,
                  activeTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22,),
                  activeBackgroundColor: Colors.blue,
                  backgroundColor: Colors.transparent,
                  firstTime: TimeOfDay(hour: 8,minute: 00),
                  lastTime: TimeOfDay(hour: 20,minute: 00),
                  initialRange: _timeRange,
                  timeStep: 10,
                  timeBlock: 30,
                  onRangeCompleted: (range) => setState(() => _timeRange = range),
              ),



              SizedBox(height: 10.0),
              if(_timeRange!=null)
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(' * Your Event Time Range is: ${_timeRange.start.format(context)} - ${_timeRange.end.format(context)}',style: TextStyle(color: Colors.lightGreen),),
          ),


              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          processing = true;
                        });
                        if(widget.note != null) {
                          await eventDBS.updateData(widget.note.id,{
                            "title": _title.text,
                            "description": _description.text,
                            "location": _location.text,
                            "event_date": _eventDate,
                            //widget.note.eventDate
                            "event_timeStart": _timeRange.start.format(context),
                            "event_timeEnd": _timeRange.end.format(context) ,
                          });
                        }else{
                          // ignore: deprecated_member_use
                          await eventDBS.createItem(EventModel(
                              title: _title.text,
                              description: _description.text,
                              location: _location.text,
                              eventDate: _eventDate,
                              eventTimeStart: _timeRange.start.format(context),
                              eventTimeEnd: _timeRange.end.format(context) ,
                          ));
                        }
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                    },
                    child: Text(
                      widget.note != null ? "Update Event" :
                      "Create Event",
                      style: style.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}