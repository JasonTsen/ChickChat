
import 'package:chickchat/ProjectNAnnouncement/Project/app_bar.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/body.dart';
import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Body(),
    );
  }
}
