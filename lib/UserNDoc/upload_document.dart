import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UploadDocument extends StatefulWidget {

  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {

  String docId;
  ProgressDialog prod;

  CollectionReference docs = FirebaseFirestore.instance.collection('Documents');

  File sampleFile;
  String documentName;
  String fileUrl;
  String finalDate = '';
  var retrieveName;

  Future getFile() async{
    var tempFile = await FilePicker.getFile();

    setState(() {
      sampleFile = tempFile;
    });
  }

  Future<void> addData(documentData) async{
    FirebaseFirestore.instance.collection('Documents').add(documentData).catchError((e){
      print(e);
    });
  }

  getCurrentDate(){
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    prod = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        textDirection: TextDirection.ltr,
        isDismissible: true);

    prod.style(
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      body: ListView(
        children:<Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 100.0, 100.0, 0.0),
            child: Text(
              'Upload Document',
              style: TextStyle(
                fontSize: 25.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 10.0),
            child: Container(
              height: 300.0,
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: RaisedButton(
                  onPressed: getFile,
                  child: Text(
                    'Add Your Document',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 60.0,right: 60.0),
            child: TextField(
              onChanged: (value){
                this.documentName = value;
              },
              decoration: InputDecoration(
                  hintText: 'Document Name'
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.fromLTRB(150.0, 15.0, 150.0, 15.0),
            child: RaisedButton(
              onPressed: () async {

                prod.show();
                prod.update(message: 'Uploading');
                final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(documentName);
                final StorageUploadTask task = firebaseStorageRef.putFile(sampleFile);
                StorageTaskSnapshot taskSnapshot = await task.onComplete;
                print('File Uploaded');

                fileUrl = await taskSnapshot.ref.getDownloadURL();
                getCurrentDate();

                var documentReference = FirebaseFirestore.instance.collection('Documents').doc(docId);
                FirebaseFirestore.instance.runTransaction((transaction) async {
                  transaction.set(
                    documentReference,
                    {
                      'name': documentName,
                      'docId':documentReference.id,
                      'url':fileUrl,
                      'dateUploaded':finalDate
                    },
                  );
                });
                prod.hide();

                await Navigator.pop(context);
              },
              color: Colors.grey,
              child: Text(
                'Upload',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
