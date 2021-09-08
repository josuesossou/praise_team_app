import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({ this.size });
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset('assets/logo.png', width: 30,)
      
      // Text(
      //   'P&W',
      //   style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     fontSize: 20,
      //     color: Colors.black,
      //     fontFamily: 'Noto Sans CJK SC'
      //   ),
      // ),
    );
  }
}