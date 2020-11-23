import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {

  final String currentUserId;
  ChangePassword({Key key, @required this.currentUserId}):super(key:key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _ChangePasswordState extends State<ChangePassword> {

  final String currentUserId;
  _ChangePasswordState({Key key, @required this.currentUserId});

  final CollectionReference profileList = FirebaseFirestore.instance.collection('Users');
  var _formKey = GlobalKey<FormState>();
  var _currentPasswordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  bool checkCurrentPasswordValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
        ),
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.done){

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: <Widget>[
                        Material(
                          child: snapshot.data['userImg'] != null
                              ? CachedNetworkImage(
                            placeholder: (context, url) =>
                                Container(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.0,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.amber),
                                  ),
                                  width: 50.0,
                                  height: 50.0,
                                  padding: EdgeInsets.all(15.0),
                                ),
                            imageUrl: snapshot.data['userImg'],
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          )
                              : Icon(
                            Icons.account_circle,
                            size: 50.0,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.pen,
                                size: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    snapshot.data['name'],
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50)
                            .copyWith(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Current Password',
                                ),
                                controller: _currentPasswordController,
                              ),
                            )
                        ),
                        Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50)
                                .copyWith(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0, right: 20.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'New Password'
                                ),
                                controller: _newPasswordController,
                                obscureText: true,
                              ),
                            )
                        ),
                        Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50)
                                .copyWith(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0, right: 20.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                ),
                                controller: _confirmPasswordController,
                                obscureText: true,
                                validator: (value){
                                  return _newPasswordController.text == value ?
                                  null:'Password does not match';
                                },
                              ),
                            )
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          onPressed: (){
                            showDialog(context: context, builder: (context){
                              return Container(
                                child: AlertDialog(
                                  title: Text('Confirm Update Password'),
                                  content: Text('Confirm to update your password?'),
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
                            }).then((result)async{
                              if(result == 'OK'){
                                FirebaseAuth.instance.currentUser.updatePassword(_newPasswordController.text);
                                if(_formKey.currentState.validate() ){
                                  await FirebaseAuth.instance.signOut();
                                  Toast.show("Login with your updated password", context, duration: Toast.LENGTH_LONG);
                                  Navigator.pop(context);
                                }
                              }
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Save Password'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.none){
            print('No data');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
  Future<DocumentSnapshot> getUserInfo()async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).get();
  }

}
