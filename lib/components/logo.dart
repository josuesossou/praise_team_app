import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({ this.size });
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: Replace text with lgcog logo
      child: Text('LGCOG', style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size
      ),),
    );
  }
}