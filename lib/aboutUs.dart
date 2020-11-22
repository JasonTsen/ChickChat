import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        actions: [
          IconButton(icon: Icon(Icons.warning_amber_rounded,color: Colors.black,size: 30,),
            onPressed: () =>  showDialog(
              context: context,
              builder: (context) => ReportBugs(),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[

      Text("ChickChat Application Version 1.0", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      SizedBox(height: 20.0),
      Text("ChickChat Application Development Team",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      SizedBox(height: 6.0),
      Text("Tsen Jing Sheng\nKhoo Teck Wei\nAndy Chung Jack Vui\nVoo Kee Yuen",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      SizedBox(height: 10.0),
      //Dear student if you continue develop your system you just copy the above Text code and past at the below to continue VV and change the application version and put your name.
      //let continue don't worry it is scroll view
    ],
    ),
    ),
    );
  }
}

class ReportBugs extends StatefulWidget {
  const ReportBugs({Key key}) : super(key: key);

  @override
  _ReportBugs createState() => _ReportBugs();
}

class _ReportBugs extends State<ReportBugs> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _bugsProblemFacingReason;
  String _reportDate;
  String applicationFormId;
  String _bugsProblem;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;
  String password;
  @override
  void initState() {
    super.initState();
    _bugsProblem = '';
    _bugsProblemFacingReason = TextEditingController();
    _reportDate = DateTime.now().millisecondsSinceEpoch.toString();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bugs Report", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 10.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: DropDownFormField(
                    titleText: 'Bugs Problem',
                    hintText: ' -- Select the Problem -- ',
                    contentPadding: EdgeInsets.all(10.0),
                    value: _bugsProblem,
                    onSaved: (value){
                      setState(() {
                        _bugsProblem = value;
                      });
                    },
                    onChanged: (value){
                      setState(() {
                        _bugsProblem = value;
                      });
                    },
                    dataSource: [
                      {
                        "display" : "Chatting Problem",
                        "value" : "Chatting Problem",
                      },
                      {
                        "display" : "Calendar Problem",
                        "value" : "Calendar Problem",
                      },
                      {
                        "display" : "Document Upload Problem",
                        "value" : "Document Upload Problem",
                      },
                      {
                        "display" : "Online Application Problem",
                        "value" : "Online Application Problem",
                      },
                      {
                        "display" : "User Profile Problem",
                        "value" : "User Profile Problem",
                      },
                      {
                        "display" : "Others...",
                        "value" : "Others...",
                      },
                    ],
                    validator: (value) =>
                    (_bugsProblem.isEmpty) ? "Please choose the bugs problem" : null,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _bugsProblemFacingReason,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Fill In what problem did you facing" : null,
                  style: style,
                  // ignore: deprecated_member_use
                  inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z0-9?!/*-+|\s]"))],
                  decoration: InputDecoration(
                      labelText: "Tell Us the Bugs Problem You facing....",
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              const SizedBox(height: 10.0),

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
                        var id = auth.currentUser.uid;
                        var mail = auth.currentUser.email;
                        var username = auth.currentUser.displayName;
                        var doc = FirebaseFirestore.instance.collection("bugsReport").doc(id).collection(id).doc(applicationFormId);

                        FirebaseFirestore.instance.runTransaction((transaction) async{
                          transaction.set(
                              doc,
                              {
                                "id": doc.id,
                                "username": username,
                                "bugsProblem": _bugsProblem,
                                "descriptionOfBugsProblem": _bugsProblemFacingReason.text,
                                "email": mail,
                                "applyDate": _reportDate,
                              }
                          );
                        });

                        sendBugsReports();
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }

                      Fluttertoast.showToast(
                          msg: "Your Report has been received and is now tracked, Thank you for your help",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.black45,
                          textColor: Colors.white,
                          fontSize: 16.0,

                      );
                    },
                    child: Text(
                      "Send Report",
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
    _bugsProblemFacingReason.dispose();
    super.dispose();
  }

  sendBugsReports() async {
    String username = 'khootw-sm17@student.tarc.edu.my';
    String password = 'k980203125441';
        // ignore: deprecated_member_use
        final smtpServer = gmail(username, password);
        // Create our message.
        final message = Message()

      ..from = Address(username, auth.currentUser.displayName)
      ..recipients.add('kennyzai29@gmail.com')
      ..ccRecipients.addAll(['sjtsen98@gmail.com', 'andycjv-sm17@student.tarc.edu.my'])
      ..bccRecipients.add(Address('andycjv-sm17@student.tarc.edu.my'))
      ..subject = 'Bugs Reporting 😀  ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =  "<h3>${_bugsProblem}</h3> <p>${_bugsProblemFacingReason.text}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE


    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    final equivalentMessage = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(Address('destination@example.com'))
      ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
      ..bccRecipients.add('bccAddress@example.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    await connection.send(equivalentMessage);

    // close the connection
    await connection.close();

  }
}


