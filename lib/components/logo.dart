import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({ this.size });
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'P&W',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF4DB6AC),
          fontFamily: 'Quicksand'
        ),
      ),
    );
  }
}