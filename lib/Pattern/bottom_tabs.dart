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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          BottomTabNav(
            imagePath: Icons.chat,
            label: Text("Chat"),
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabNav(
            imagePath: Icons.announcement,
            label: Text("Chat"),
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabNav(
            imagePath: Icons.file_upload,
            label: Text("Chat"),
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomTabNav(
              imagePath: Icons.add,
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (context) => Container(

                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:  Colors.white,

                        borderRadius: BorderRadius.circular(38.0),
                      ),

                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              BottomTabNav(
                                imagePath: Icons.chat,
                                label: Text("Chat"),
                                selected: _selectedTab == 5 ? true : false,
                                onPressed: () {
                                  widget.tabPressed(5);
                                },
                              ),
                              BottomTabNav(
                                imagePath: Icons.announcement,
                                label: Text("Chat"),
                                selected: _selectedTab == 6 ? true : false,
                                onPressed: () {
                                  widget.tabPressed(6);
                                },
                              ),
                              BottomTabNav(
                                imagePath: Icons.file_upload,
                                label: Text("Chat"),
                                selected: _selectedTab == 7 ? true : false,
                                onPressed: () {
                                  widget.tabPressed(7);
                                },
                              ),
                              BottomTabNav(
                                imagePath: Icons.announcement,
                                label: Text("Chat"),
                                selected: _selectedTab == 8 ? true : false,
                                onPressed: () {
                                  widget.tabPressed(8);
                                },
                              ),
                            ],
                          ),
                    )
                );
              },
          ),
          BottomTabNav(
            imagePath: Icons.logout,
            selected: _selectedTab == 4 ? true : false,
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
  final IconData imagePath;
  final Text label;
  final bool selected;
  final Function onPressed;
  BottomTabNav({this.imagePath, this.label,this.selected, this.onPressed});
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
        child: Icon(imagePath, color: _selected ? Theme.of(context).accentColor : Colors.black, ),



      ),

    );
  }
}
