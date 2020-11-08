import 'dart:io';
import 'package:chickchat/design.dart';
import 'package:chickchat/login.dart';
import 'package:chickchat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'customBtn.dart';
import 'customInput.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {


  String _name, _email, _password, _userRole, _phone, _chattingWith;
  int selectedRad;
  File imageFile;
  String _uploadImgFile;
  final _picker = ImagePicker();
  Future  _openGallery() async{

    final picture = await _picker.getImage(source: ImageSource.gallery);
    
    this.setState(() {
      if(picture != null){
        imageFile = File(picture.path);
      }else{
        print("No image selected.");
      }
    });
  }

  Future<void> _openCamera() async{
    var picture = await _picker.getImage(source: ImageSource.camera);
    this.setState(() {
      if(picture != null){
        imageFile = File(picture.path);
      }else{
        print("No image selected.");
      }
    });
  }
  Future<void> uploadFile() async {

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('userImages/${imageFile.path}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print("file uploaded");


      _uploadImgFile = await taskSnapshot.ref.getDownloadURL();

      _userSetup(_name, _email,_password, _phone, _userRole, _uploadImgFile, _chattingWith);
  }
  Future<void> _userSetup(String userName, String email, String password, String phoneNo, String role, String userImg, String chattingWith) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();

    FirebaseFirestore.instance.collection('Users').doc(auth.currentUser.uid)
        .set({'uid': uid, 'name': userName, 'email': email, 'pass': password, 'phone': phoneNo, 'role': role, 'userImg': userImg, 'chattingWith' : chattingWith});

  }
  Future<String> _createUser() async{
    try{
      await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(email: _email, password: _password);

      User updateUser = FirebaseAuth.instance.currentUser;
      updateUser.updateProfile(displayName: _name);
      uploadFile();

      return null;
    } on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password'){
        return 'The password provided is too weak';
      }else if(e.code == 'email-already-in-use'){
        return 'The account already exists for that email.';
      }
      return e.message;
    }catch(e){
      return e.toString();
    }
  }
  _submitReg() async{
    setState(() {
      _registerLoad = true;
    });
    String _validateAccount = await _createUser();
    if(_validateAccount != null){
      _alertDialog(_validateAccount);
      setState(() {
        _registerLoad = false;
      });
    }else{
      Toast.show("You have registered and login as " + _name +".", context,  duration: Toast.LENGTH_LONG);
      Navigator.pop(context);

    }
  }
  Future<void> _alertDialog(String error) async{
    return showDialog(
      context:  context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text(error),
          ),
          actions:[
            FlatButton(
              child: Text("Close"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ]
        );
      }
    );
  }
  bool _registerLoad = false;
 FocusNode _passwordFocus;
  @override
  void initState(){

    super.initState();
    _passwordFocus = FocusNode();
    selectedRad = 0;
  }
  @override
  void dispose(){
    _passwordFocus.dispose();
    super.dispose();
  }
  setSelectedRadio(int val){
    setState(() {
      selectedRad = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomPadding: false,

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 24.0,
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height:20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child:CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.amber,
                              child: ClipOval(
                                child:SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (imageFile!=null)?Image.file(
                                    imageFile,
                                    fit: BoxFit.fill,
                                  ):Image.network(
                                    "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                    fit: BoxFit.fill,
                                  ),

                                )
                              ),
                            ),
                          ),

                        ],
                      ),



                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: IconButton(

                              icon: Icon(
                                Icons.photo_camera,
                                size: 30.0,
                              ),
                              onPressed: () {
                                _openCamera();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: IconButton(

                              icon: Icon(
                                Icons.photo_library,
                                size: 30.0,
                              ),
                              onPressed: () {
                                _openGallery();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                        onChanged: (value){
                          _name = value;
                        },
                        hintText: "Enter Name...",
                        textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                        onChanged: (value){
                          _email = value;
                        },
                        hintText: "Enter Email...",
                        textInputAction: TextInputAction.next,
                        onSubmitted: (value){
                          _passwordFocus.requestFocus();
                        }
                    ),
                    CustomInput(
                        onChanged: (value){
                          _password = value;
                        },
                        hintText: "Enter Password...",
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.next,
                      isPassField: true,

                    ),
                    CustomInput(
                        onChanged: (value){
                          _phone = value;
                        },
                        hintText: "Enter Phone No...",
                        onSubmitted: (value){
                          _submitReg();
                        },

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                            activeColor: Colors.black,
                            value: 1,
                            groupValue: selectedRad,
                            onChanged: (val){
                              setState(() {
                                _userRole = "Staff";
                                setSelectedRadio(val);
                              });
                            },
                          ),
                        Text("Staff", style: Design.regularDarkText),
                        Radio(
                            activeColor: Colors.black,
                            value: 2,
                            groupValue: selectedRad,
                            onChanged: (val){
                              _userRole = "Manager";
                              setSelectedRadio(val);
                            },
                          ),
                        Text("Manager", style: Design.regularDarkText),
                      ],
                    ),
                    CustomBtn(
                      text: "Create New Account",
                      onPressed: (){
                        _submitReg();
                      },
                      isLoad: _registerLoad,
                      outlineBtn: false,
                    ),

                  ],

                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
