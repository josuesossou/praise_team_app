import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {
  RectButton({ 
    Key key, 
    @required this.onPress, 
    @required this.child, 
    this.elevation = 0, 
    this.color, 
    this.padding = const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    this.margin = const EdgeInsets.all(0),
    this.raduis = 30.0,
    this.width,
  });

  final VoidCallback onPress;
  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final double elevation, raduis, width;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(raduis),
        color: color,
        clipBehavior: Clip.hardEdge,
        child: MaterialButton(
          minWidth: width,
          onPressed: onPress,
          child: child,
          padding: padding,
        ),
      )
    );
  }
}

class CirButton extends StatelessWidget {
  CirButton({ 
    Key key,
    @required this.size, 
    @required this.onPress, 
    this.elevation = 0,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.padding2 = const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    this.color = Colors.transparent,
    @required this.child,
  });

  final double size;
  final VoidCallback onPress;
  final double elevation;
  final EdgeInsets margin, padding, padding2;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(size),
        color: color,
        clipBehavior: Clip.hardEdge,
        child: MaterialButton(
          focusColor: Colors.transparent,
          height: size,
          minWidth: size,
          padding: padding2,
          onPressed: onPress,
          child: child
        ),
      )
    );
  }
}