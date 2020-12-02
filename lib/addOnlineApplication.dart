import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:toast/toast.dart';

class AddOnlineApplication extends StatefulWidget {
  const AddOnlineApplication({Key key}) : super(key: key);

  @override
  _AddOnlineApplicationForm createState() => _AddOnlineApplicationForm();
}

class _AddOnlineApplicationForm extends State<AddOnlineApplication> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _reason;
  String _applyDate;
  String applicationFormId;
  String _formType;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _formType = '';
    _reason = TextEditingController();
    _applyDate = DateTime.now().millisecondsSinceEpoch.toString();
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
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(auth.currentUser.displayName,textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),

              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(auth.currentUser.email,textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  ),
                  child: DropDownFormField(
                    titleText: 'Form Types',
                    hintText: ' -- Select the Form Types -- ',
                    contentPadding: EdgeInsets.all(10.0),
                    value: _formType,
                    onSaved: (value){
                      setState(() {
                        _formType = value;
                      });
                    },
                    onChanged: (value){
                      setState(() {
                        _formType = value;
                      });
                    },
                    dataSource: [
                      {
                        "display" : "Event Registration Form",
                        "value" : "Event Registration Form",
                      },
                      {
                        "display" : "Department Change Form",
                        "value" : "Department Change Form",
                      },
                      {
                        "display" : "Claim Form",
                        "value" : "Claim Form",
                      },

                      {
                        "display" : "Others Application Form",
                        "value" : "Others Application Form",
                      },
                    ],
                    validator: (value) =>
                    (_formType.isEmpty) ? "Please Select your Form Type" : null,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _reason,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please fill in your reason" : null,
                  style: style,
                  // ignore: deprecated_member_use
                  inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z0-9?!/*-+|\s]"))],
                  decoration: InputDecoration(
                      labelText: "Reason...",
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              const SizedBox(height: 10.0),

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
                          var doc = FirebaseFirestore.instance.collection("applicationForm").doc(id).collection(id).doc(applicationFormId);

                          FirebaseFirestore.instance.runTransaction((transaction) async{
                            transaction.set(
                                doc,
                                {
                                  "id": doc.id,
                                  "username": username,
                                  "formType": _formType,
                                  "reason": _reason.text,
                                  "email": mail,
                                  "applyDate": _applyDate,
                                }
                            );
                          });
                        sendApplicationForm();
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                      Toast.show("Send Successfully", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
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
    _reason.dispose();
    super.dispose();
  }

  sendApplicationForm() async {
    String username = '(Your Email)';
    String password = '(Your Password)';
    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Create our message.
    final message = Message()

      ..from = Address(username, auth.currentUser.displayName)
      ..recipients.add('kennyzai29@gmail.com')
      ..ccRecipients.addAll(['sjtsen98@gmail.com', 'andycjv-sm17@student.tarc.edu.my'])
      ..bccRecipients.add(Address('andycjv-sm17@student.tarc.edu.my'))
      ..subject = 'Applying ${_formType}  ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =  "<h3>${_formType}</h3> <p>Greetings, i am applying for the ${_formType}. My reason to apply this Application form because : ${_reason.text}</p>";

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