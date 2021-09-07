import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCop extends StatelessWidget {
  TextFieldCop({ 
    Key key, 
    @required this.obscureText, 
    this.hintText, 
    @required this.onChange,
    this.radius = 32.0,
    @required this.color,
    this.margin = const EdgeInsets.only(left: 20, right: 20),
    this.padding = const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    this.border = BorderSide.none,
    this.controller,
    this.submitted,
    this.maxLength,
    this.keyboardType,
    this.textAlign = TextAlign.start
  });

  final String hintText;
  final bool obscureText;
  final Function onChange;
  final TextStyle style = TextStyle(fontSize: 20.0);
  final double radius;
  final Color color;
  final EdgeInsets margin, padding;
  final BorderSide border;
  final TextEditingController controller;
  final Function submitted;
  final int maxLength;
  final TextInputType keyboardType;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextField(
        onChanged: onChange,
        obscureText: obscureText,
        keyboardType: keyboardType,
        autofocus: false,
        style: style,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        controller: controller,
        textAlign: textAlign,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: padding,
          hintText: hintText,
          filled: true,
          fillColor: color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius), 
            borderSide: border
          )
        ),
      )
    );
  }
}

class CustomTextInput extends StatelessWidget {
  const  CustomTextInput({ 
    @required this.controller,
    @required this.labelText,
    @required this.icon,
  });
  final TextEditingController controller;
  final String labelText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 15,
        ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFF4DB6AC)
          )
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide.none,
        ),
        focusColor: Color(0xFF4DB6AC),
        filled: true,
        fillColor: Colors.teal.withOpacity(.1),
        contentPadding:
          const EdgeInsets.symmetric(vertical: 4.0),
        prefixIcon: icon,
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.grey.shade800,
          fontSize: 15,
        ),
      ),
    );
  }
}