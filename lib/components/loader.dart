import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  Loader({ @required this.color });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      )
    );
  }
}