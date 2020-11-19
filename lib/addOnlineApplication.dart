import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

class AddOnlineApplication extends StatefulWidget {
  const AddOnlineApplication({Key key}) : super(key: key);

  @override
  _AddOnlineApplicationForm createState() => _AddOnlineApplicationForm();
}

class _AddOnlineApplicationForm extends State<AddOnlineApplication> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _username;
  TextEditingController _reason;
  TextEditingController _email;
  TextEditingController _phoneNumber;
  DateTime _eventDate;
  String applicationFormId;
  FirebaseAuth auth = FirebaseAuth.instance;
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
    _username = TextEditingController();
    _reason = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();
    _eventDate = DateTime.now();
    _timeRange = _defaultTimeRange;
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Application Form", style: TextStyle(fontWeight: FontWeight.bold),),
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
                  controller: _username,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter Event title" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "UserName",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _reason,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event description",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _reason,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Reason...." : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event description",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _email,
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
                          var id = auth.currentUser.uid;
                          var doc = FirebaseFirestore.instance.collection("applicationForm").doc(id).collection(id).doc(applicationFormId);

                          FirebaseFirestore.instance.runTransaction((transaction) async{
                            transaction.set(
                                doc,
                                {
                                  "id": doc.id,
                                  "username": _username.text,
                                  "reason": _reason.text,
                                  "email": _email.text,
                                  "eventDate": _eventDate,
                                  "eventTimeStart": _timeRange.start.format(context),
                                  "eventTimeEnd": _timeRange.end.format(context) ,
                                }
                            );
                          });
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                    },
                    child: Text(
                      "Apply Online Application Form",
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
    _username.dispose();
    _reason.dispose();
    super.dispose();
  }
}