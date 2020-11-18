import 'package:flutter/material.dart';
import 'design.dart';
class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}