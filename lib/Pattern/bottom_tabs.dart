import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
class BottomTab extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTab({this.selectedTab, this.tabPressed});

  @override
  _BottomTabState createState() => _BottomTabState();
}
class _BottomTabState extends State<BottomTab>{

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabNav(

            imagePath: "assets/images/tab_home.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabNav(
            imagePath: "assets/images/tab_search.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabNav(
            imagePath: "assets/images/tab_saved.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomTabNav(
            imagePath: "assets/images/tab_logout.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: () async{
              Toast.show("You have logged out successfully!", context, duration: Toast.LENGTH_LONG);
              await FirebaseAuth.instance.signOut();
            },
          ),


        ],
      ),

    );
  }

}
class BottomTabNav extends StatelessWidget{
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabNav({this.imagePath, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context){
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 28.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                  color: _selected ? Theme.of(context).accentColor : Colors.transparent,
                  width: 2.0,
                )
            )
        ),
        child: Image(
          image: AssetImage(
              imagePath ?? "assets/images/tab_home.png"
          ),
          width: 22.0,
          height: 22.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}