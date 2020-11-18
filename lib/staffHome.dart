import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'StaffChatPage.dart';
import 'Pattern/bottom_tabs.dart';

class StaffHomePage extends StatefulWidget {
  final String currentUserId;

  StaffHomePage({Key key, @required this.currentUserId}) : super(key: key);
  @override
  _StaffHomePageState createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  _StaffHomePageState({Key key, @required this.currentUserId});
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

                StaffChat(currentUserId: auth.currentUser.uid),
                StaffChat(currentUserId: auth.currentUser.uid),
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