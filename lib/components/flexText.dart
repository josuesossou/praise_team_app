import 'package:flutter/material.dart';

class FlexText extends StatelessWidget {
  FlexText({ 
    this.text, 
    this.style, 
    this.alignment, 
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  final String text;
  final TextStyle style;
  final Alignment alignment;
  final EdgeInsets padding;
  final EdgeInsets margin;
  
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        alignment: alignment,
        padding: padding,
        margin: margin,
        child: Text(
          text,
          style: style
        ),
      )
    );
  }
}