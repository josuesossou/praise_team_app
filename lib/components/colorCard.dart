import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  ColorCard({ 
    Key key, 
    @required this.color,
    this.isDisabled = false,
  });
  final int color;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(color),
      elevation: isDisabled ? 0 : 5,
      child: Container(
        height: 50,
        width: 50,
      ),
    );
  }
}