import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class PDFViewPage extends StatefulWidget {
  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}


class _PDFViewPageState extends State<PDFViewPage> {
  /*PDFDocument doc;
  @override
  Widget build(BuildContext context) {

    String data = ModalRoute.of(context).settings.arguments;
    ViewNow() async{
      doc = await PDFDocument.fromURL(data);
      setState(() {

      });
    }

    Widget Loading(){
      ViewNow();
      if(doc==null){
        return CircularProgressIndicator();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Retrieve Pdf'),
      ),
      body: doc==null?Loading():PDFViewer(document: doc),
    );
  }*/
  String _version = "Unknown";
  String licenseKey;


  @override
  void initState(){
    super.initState();
    initPlatformState();
    PdftronFlutter.openDocument("https://firebasestorage.googleapis.com/v0/b/mychickchat-d2c4d.appspot.com/o/Document%20A?alt=media&token=f0db4a4d-6765-486e-afce-ecbf9e4ef0d7");
  }

  Future<void> initPlatformState() async {
    String version;

    try {
      PdftronFlutter.initialize(licenseKey);
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PDFTron flutter app'),
        ),
        body: Center(
          child: Text('Running on: $_version\n'),
        ),
      ),
    );
  }
}


