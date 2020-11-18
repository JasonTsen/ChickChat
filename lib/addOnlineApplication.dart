import 'package:chickchat/onlineApplication.dart';
import 'package:flutter/material.dart';
import 'package:chickchat/onlineApplication_firestore_service.dart';

class AddOnlineApplication extends StatefulWidget {
  final OnlineApplicationModel form;
  const AddOnlineApplication({Key key, this.form}) : super(key: key);

  @override
  _AddOnlineApplicationPageState createState() => _AddOnlineApplicationPageState();
}

class _AddOnlineApplicationPageState extends State<AddOnlineApplication> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _userName;
  TextEditingController _reason;
  TextEditingController _email;
  TextEditingController _phoneNumber;
  DateTime _onlineApplicationDate;
  DateTime _onlineApplicationTime;

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  bool processing;

  @override
  void initState() {
    super.initState();
    _userName = TextEditingController(text: widget.form != null ? widget.form.userName : "");
    _reason = TextEditingController(text:  widget.form != null ? widget.form.reason : "");
    _email = TextEditingController(text: widget.form != null ? widget.form.email : "");
    _phoneNumber = TextEditingController(text: widget.form != null ? widget.form.phoneNumber : "");
    _onlineApplicationDate = DateTime(DateTime.now().day,DateTime.now().month,DateTime.now().year);
    _onlineApplicationTime = DateTime(DateTime.now().hour,DateTime.now().minute);

    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Online Application"),
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
                  controller: _userName,
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
                  controller: _reason,
                  minLines: 3,
                  maxLines: 6,
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
                subtitle: Text("${_onlineApplicationDate.day} - ${_onlineApplicationDate.month} - ${_onlineApplicationDate.year}"),
                onTap: ()async{
                  DateTime picked = await showDatePicker(context: context, initialDate: _onlineApplicationDate, firstDate: DateTime(_onlineApplicationDate.year-5), lastDate: DateTime(_onlineApplicationDate.year+5));

                  if(picked != null) {
                    setState(() {
                      _onlineApplicationDate = picked;
                    });
                  }
                },
              ),

              const SizedBox(height: 10.0),

              SizedBox(height: 10.0),


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
                        if(widget.form != null) {
                          await onlineApplicationDBS.updateData(widget.form.id,{
                            "userName": _userName.text,
                            "description": _reason.text,
                            "phoneNumber": _phoneNumber.text,
                            "email": _email.text,
                            //widget.form.eventDate
                            "onlineApplicationDate ":DateTime.now() ,
                            "onlineApplicationTime": DateTime.now(),
                          });
                        }else{
                          // ignore: deprecated_member_use
                          await onlineApplicationDBS.createItem(OnlineApplicationModel(
                            userName: _userName.text,
                            reason: _reason.text,
                            email: _email.text,
                            //eventDate: _eventDate,
                           // eventTimeStart: _timeRange.start.format(context),
                           // eventTimeEnd: _timeRange.end.format(context) ,
                          ));
                        }
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                    },
                    child: Text(
                      "Apply",
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
    _userName.dispose();
    _reason.dispose();
    super.dispose();
  }
}