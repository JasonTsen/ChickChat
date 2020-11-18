import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:chickchat/onlineApplication.dart';

DatabaseService<OnlineApplicationModel> onlineApplicationDBS = DatabaseService<OnlineApplicationModel>
  ("events",fromDS: (id,dataOnline) => OnlineApplicationModel.fromDS(id, dataOnline),
    toMap:(application) => application.toMap());