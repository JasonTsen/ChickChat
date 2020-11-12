import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoad;
  CustomBtn({this.text, this.onPressed, this.outlineBtn, this.isLoad});
  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoad = isLoad ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoad ? false : true,
            child: Center(
              child: Text(
                text ?? "Text",
                style: TextStyle(
                  fontSize: 16.0,
                  color: _outlineBtn ?  Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ),
            Visibility(
              visible: _isLoad,
              child: Center(
                child: SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator()

                ),
              ),
            ),
          ],
        ),
      )


    );

  }
}

