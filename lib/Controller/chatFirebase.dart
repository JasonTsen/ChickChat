import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';


class FirebaseController {
  static FirebaseController get instance => FirebaseController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> sendImageToUserInChatRoom(croppedFile,chatID) async {
    try {
      String imageTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = 'chatrooms/$chatID/$imageTimeStamp';
      final StorageReference storageReference = FirebaseStorage().ref().child(filePath);
      final StorageUploadTask uploadTask = storageReference.putFile(croppedFile);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      String result = await storageTaskSnapshot.ref.getDownloadURL();
      return result;
    }catch(e) {
      print(e.message);
    }
  }
  // Save Image to Storage
  Future<String> saveUserImageToFirebaseStorage(userId,userName,userIntro,userImageFile) async {
    DocumentSnapshot document;
    try {
       document.data()['userId'] = userId;
       document.data()['name'] = userName;
       document.data()['intro'] = userIntro;


      String filePath = 'userImages/$userId';
      final StorageReference storageReference = FirebaseStorage().ref().child(filePath);
      final StorageUploadTask uploadTask = storageReference.putFile(userImageFile);

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      String imageURL = await storageTaskSnapshot.ref.getDownloadURL(); // Image URL from firebase's image file
      String result = await saveUserDataToFirebaseDatabase(userId,userName,imageURL);
      return result;
    }catch(e) {
      print(e.message);
      return null;
    }
  }
// About Firebase Database
  Future<String> saveUserDataToFirebaseDatabase(userId,userName,downloadUrl) async {
    DocumentSnapshot document;
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('FCMToken', isEqualTo: document.data()['FCMToken']).get();
      final List<DocumentSnapshot> documents = result.docs;
      String myID = userId;
      if (documents.length == 0) {
        await FirebaseFirestore.instance.collection('Users').doc(userId).set({
          'userId':userId,
          'name':userName,
          'userImageUrl':downloadUrl,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'FCMToken': document.data()['FCMToken']?? 'NOToken',
        });
      }else {
        String userID = documents[0]['userId'];
        myID = userID;
        document.data()['userId'] = myID;
        await FirebaseFirestore.instance.collection('users').doc(userID).update({
          'name':userName,
          'userImageUrl':downloadUrl,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'FCMToken':document.data()['FCMToken']?? 'NOToken',
        });
      }
      return myID;
    }catch(e) {
      print(e.message);
      return null;
    }
  }
  Future<void> updateUserToken(userID, token) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).set({
      'FCMToken':token,
    });
  }

  Future<List<DocumentSnapshot>> takeUserInformationFromFBDB() async{
    DocumentSnapshot document;
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('Users').where('FCMToken', isEqualTo: document.data()['FCMToken'] ?? 'None').get();
    return result.docs;
  }

  Future<int> getUnreadMSGCount([String peerUserID]) async{
    try {
      int unReadMSGCount = 0;
      String targetID = '';
      FirebaseAuth auth = FirebaseAuth.instance;

      peerUserID == null ? targetID = (auth.currentUser.uid ?? 'NoId') : targetID = peerUserID;
//      if (targetID != 'NoId') {
      final QuerySnapshot chatListResult =
      await FirebaseFirestore.instance.collection('Users').get();
      final List<DocumentSnapshot> chatListDocuments = chatListResult.docs;
      for(var data in chatListDocuments) {
        final QuerySnapshot unReadMSGDocument = await FirebaseFirestore.instance.collection('chats').
        doc(data['chatID']).
        collection(data['chatID']).
        where('idTo', isEqualTo: targetID).
        where('isread', isEqualTo: false).
        get();

        final List<DocumentSnapshot> unReadMSGDocuments = unReadMSGDocument.docs;
        unReadMSGCount = unReadMSGCount + unReadMSGDocuments.length;
      }
      print('unread MSG count is $unReadMSGCount');
//      }
      if (peerUserID == null) {
        FlutterAppBadger.updateBadgeCount(unReadMSGCount);
        return null;
      }else {
        return unReadMSGCount;
      }

    }catch(e) {
      print(e.message);
    }
  }

  Future updateChatRequestField(String documentID,String lastMessage,chatID,myID,selectedUserID) async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentID)
        .collection('chatlist')
        .doc(chatID)
        .set({'chatID':chatID,
      'chatWith':documentID == myID ? selectedUserID : myID,
      'lastChat':lastMessage,
      'timestamp':DateTime.now().millisecondsSinceEpoch});
  }

  Future sendMessageToChatRoom(chatID,myID,selectedUserID,content,messageType) async {
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatID)
        .collection(chatID)
        .doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
      'idFrom': myID,
      'idTo': selectedUserID,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'content': content,
      'type':messageType,
      'isread':false,
    });
  }
}