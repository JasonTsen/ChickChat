import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            imagePath: Icons.chat_outlined,
            label: Text("Chat"),
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabNav(
            imagePath: Icons.work_outline,
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabNav(
            imagePath: Icons.event,
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomTabNav(
              imagePath: Icons.announcement_outlined,
            selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                widget.tabPressed(3);
              },
          ),
          BottomTabNav(
            imagePath: Icons.more_vert,
            selected: _selectedTab == 7 ? true : false,
            onPressed: () async{
              showModalBottomSheet(
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
                          imagePath: CupertinoIcons.doc_text,

                          selected: _selectedTab == 4 ? true : false,
                          onPressed: () {
                            Navigator.pop(context);
                            widget.tabPressed(4);
                          },
                        ),
                        BottomTabNav(
                          imagePath: Icons.insert_drive_file_outlined,
                          label: Text("Chat"),
                          selected: _selectedTab == 5 ? true : false,
                          onPressed: () {
                            Navigator.pop(context);
                            widget.tabPressed(5);
                          },
                        ),

                        BottomTabNav(
                          imagePath: Icons.info_outline,
                          label: Text("Chat"),
                          selected: _selectedTab == 6 ? true : false,
                          onPressed: () {
                            Navigator.pop(context);
                            widget.tabPressed(6);
                          },
                        ),

                      ],
                    ),
                  )
              );
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
          vertical: 20.0,
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
