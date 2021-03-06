import 'ManagerChatPage.dart';
import 'package:chickchat/UserNDoc/document.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/project_list.dart';
import 'package:chickchat/ProjectNAnnouncement/Announcement/announcement.dart';
import 'package:chickchat/aboutUs.dart';
import 'package:chickchat/myCalendar.dart';
import 'package:chickchat/myOnlineApplication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Pattern/bottom_tabs.dart';

class ManagerHomePage extends StatefulWidget {
  final String currentUserId;
  ManagerHomePage({Key key, @required this.currentUserId}) : super(key: key);

  @override
  _ManagerHomePageState createState() => _ManagerHomePageState(currentUserId: currentUserId);
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  _ManagerHomePageState({Key key, @required this.currentUserId});
  final String currentUserId;
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                ManagerChat(currentUserId: auth.currentUser.uid),
                ProjectList(),
                MyCalendar(),
                AnnouncementScreen(),
                DocumentPage(),
                MyOnlineApplicationApp(),
                AboutUs()

              ],
            ),
          ),

          BottomTab(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              _tabsPageController.animateToPage(
                  num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    );
  }
}