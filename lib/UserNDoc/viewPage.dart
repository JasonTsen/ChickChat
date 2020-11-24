import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFViewPage extends StatefulWidget {
  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}


class _PDFViewPageState extends State<PDFViewPage> {
  @override
  void initState() {
    super.initState();
    initPlatformState();

    if(Platform.isIOS){

    }else{
      launchWithPermission();
    }
  }

  Future<void> launchWithPermission() async{
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if(granted(permissions[PermissionGroup.storage])){
    }
  }

  Future<void> initPlatformState() async{
    String version;
    try{
      PdftronFlutter.initialize("Insert commercial license key here after purchase");
      version = await PdftronFlutter.version;
    }on PlatformException{
      version = 'Failed to get platform version.';
    }
    if(!mounted)return;
  }

  showViewer(file){
    PdftronFlutter.openDocument(file);

  }

  bool granted(PermissionStatus status){
    return status == PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context).settings.arguments;

    Widget Loading(){
      if(data==null){
        return CircularProgressIndicator();
      }
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('View Document'),
        ),
        body: AlertDialog(
          title: Text('Open document?'),
          actions: <Widget>[
            MaterialButton(
              child: Text('CANCEL'),
              onPressed: (){
                Navigator.of(context).pop('CANCEL');
              },
            ),
            MaterialButton(
              child: Text('OPEN'),
              onPressed: (){
                Navigator.of(context).pop('OPEN');
                data==null?Loading():showViewer(data);
              },
            ),
          ],
        )
      ),
    );

  }
}


