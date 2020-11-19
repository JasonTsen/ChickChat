import 'package:flutter/material.dart';
import 'package:chickchat/addOnlineApplication.dart';
import 'package:chickchat/onlineApplicationHistory.dart';

class MyOnlineApplicationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Application'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Title(color: Colors.black, child: Text('Rules and Regulation for Online Application',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),),
            SizedBox(height: 10.0),
            Text('* Please apply all application 3 days before. We would contact you as soon as possible',textAlign: TextAlign.left, style: TextStyle(fontSize: 16,color: Colors.red),),
            SizedBox(height: 10.0),
            Text('* Once the application submitted cannot be undo. Think wisely before send the online application form to us.',textAlign: TextAlign.left, style: TextStyle(fontSize: 16,color: Colors.red),),
            SizedBox(height: 10.0),
            Text('By HR Department', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),textAlign: TextAlign.end,),
            SizedBox(height: 80.0),

            RaisedButton(
              onPressed: () => {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => AddOnlineApplication()))
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child:
                const Text('Apply Online Application', style: TextStyle(fontSize: 20)),
              ),),
            SizedBox(height: 40.0),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, 'onlineApplicationHistory'),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      //Colors.yellow,
                      Colors.red,
                      Colors.indigo,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child:
                const Text('View History Application', style: TextStyle(fontSize: 20)),
              ),),
          ],
        ),
      ),
    );}
}
//-------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

