import 'package:chickchat/UserNDoc/upload_document.dart';
import 'package:chickchat/UserNDoc/viewPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';


class DocumentPage extends StatefulWidget {

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> with SingleTickerProviderStateMixin{

  ProgressDialog pr;
  String rename;
  final CollectionReference docs = FirebaseFirestore.instance.collection('Documents');

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        textDirection: TextDirection.ltr,
        isDismissible: true);

    pr.style(
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
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30,right: 5,top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Documents',
                      style: TextStyle(
                        fontSize: 25.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: IconButton(
                          onPressed: (){

                          },
                          iconSize: 30.0,
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 440.0,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Documents').snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{
                      return ListView.builder(
                        itemBuilder: (context, index) =>
                            buildItem(context, snapshot.data.documents[index]),
                        itemCount: snapshot.data.documents.length,
                      );
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadDocument()),
          );
        },
        heroTag: null,
        tooltip: 'Upload Document',
        child: Icon(
          Icons.add_circle,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document){
    if(document.data()['name'] == null){
      return CircularProgressIndicator();
    }
    else{
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: (){
            String passData = document.data()['url'];
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=> PDFViewPage(),
                    settings: RouteSettings(
                      arguments: passData,
                    )
                )
            );
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Image.asset('assets/images/document.png',height: 15.0,width: 15.0),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    width: 278.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            document.data()['name'],
                            style: TextStyle(
                                fontSize: 16.0
                            ),
                          ),
                          Text(
                            document.data()['dateUploaded'],
                            style: TextStyle(
                                fontSize: 12.0
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.ellipsis,
                      color: Colors.grey,
                    ),
                    onPressed: (){
                      showModalBottomSheet(context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext bc){
                            return Container(
                                height: MediaQuery.of(context).size.height * .60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Divider(
                                      endIndent: 190,
                                      indent: 190,
                                      thickness: 3,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10.0),
                                              child: Container(
                                                height: 100.0,
                                                width: 360.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(6.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(3.0),
                                                        ),
                                                        child: Image.asset('assets/images/document.png'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                                      child: Text(
                                                        document.data()['name'],
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          letterSpacing: 1.0,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 220.0,
                                              child: ListView(
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(Icons.edit),
                                                        title: Text('Rename'),
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                          showDialog(context: context, builder: (context){
                                                            TextEditingController customController = TextEditingController(text: document.data()['name']);
                                                            return Container(
                                                              child: AlertDialog(
                                                                title: Text('Rename this file'),
                                                                content: TextField(
                                                                  controller: customController,
                                                                  decoration: InputDecoration(
                                                                      hintText: 'New Document Name'
                                                                  ),
                                                                  onChanged: (text){
                                                                    print(customController.text);
                                                                    rename = customController.text;
                                                                  },
                                                                ),
                                                                actions: <Widget>[
                                                                  MaterialButton(
                                                                    child: Text('CANCEL'),
                                                                    onPressed: (){
                                                                      Navigator.of(context).pop('CANCEL');
                                                                    },
                                                                  ),
                                                                  MaterialButton(
                                                                    child: Text('OK'),
                                                                    onPressed: (){
                                                                      Navigator.of(context).pop('OK');
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }).then((result){
                                                            if(result == 'OK'){
                                                              pr.show();
                                                              docs.doc(document.id).update({'name':rename});
                                                              Future.delayed(Duration(seconds: 1)).then((value){
                                                                pr.update(message: 'Renaming');
                                                                pr.hide();
                                                              });
                                                            }

                                                          });
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(CupertinoIcons.share),
                                                        title: Text('Share'),
                                                      ),
                                                      ListTile(
                                                        leading: Icon(CupertinoIcons.arrow_down_circle),
                                                        title: Text('Download'),
                                                        onTap: ()async{
                                                          Navigator.pop(context);
                                                          final status = Permission.storage.request();
                                                          if(status.isGranted != null){
                                                            pr.show();
                                                            pr.update(message: 'Downloading');
                                                            final externalDir = await getExternalStorageDirectory();
                                                            final id = await FlutterDownloader.enqueue(
                                                              url: document.data()['url'],
                                                              savedDir: externalDir.path,
                                                              fileName: document.data()['name'],
                                                              showNotification: true,
                                                              openFileFromNotification: true,
                                                            );
                                                            Future.delayed(Duration(seconds: 1)).then((value){
                                                              pr.hide();
                                                            });
                                                          }else{
                                                            print("Permission denied");
                                                          }
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(CupertinoIcons.arrow_right),
                                                        title: Text('Move to Folder'),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[500],
                                                        endIndent: 160.0,
                                                        indent: 15,
                                                      ),
                                                      ListTile(
                                                        leading: Icon(CupertinoIcons.lock_fill),
                                                        title: Text('Set Password'),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[500],
                                                        endIndent: 160.0,
                                                        indent: 15.0,
                                                      ),
                                                      ListTile(
                                                        leading: Icon(CupertinoIcons.delete),
                                                        title: Text('Delete Document'),
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                          showDialog(context: context, builder: (context){
                                                            return Container(
                                                              child: AlertDialog(
                                                                title: Text('Delete this item?'),
                                                                content: Text('This item will be permanently deleted.'),
                                                                actions: <Widget>[
                                                                  MaterialButton(
                                                                    child: Text('CANCEL'),
                                                                    onPressed: (){
                                                                      Navigator.of(context).pop('CANCEL');
                                                                    },
                                                                  ),
                                                                  MaterialButton(
                                                                    child: Text('OK'),
                                                                    onPressed: (){
                                                                      Navigator.of(context).pop('OK');
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }).then((result){
                                                            if(result == 'OK'){
                                                              pr.show();
                                                              docs.doc(document.id).delete();
                                                              final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(document.data()['name']);
                                                              firebaseStorageRef.delete();
                                                              Future.delayed(Duration(seconds: 1)).then((value){
                                                                pr.update(message: 'Deleting');
                                                                pr.hide();
                                                              });
                                                            }
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ],
                                )
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

