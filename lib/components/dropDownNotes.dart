import 'package:flutter/material.dart';
import '../utils/calculateTranspose.dart';

class DropDownNotes extends StatelessWidget {
  DropDownNotes({ 
    @required this.dropdownValue, 
    @required this.onValueChanged,
    @required this.items
  });

  final String dropdownValue;
  final Function onValueChanged;
  final List<String> items;
  final TransposeCalculation transpose = TransposeCalculation();
  
  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(
        Icons.arrow_downward,
        color: Colors.black,
      ),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontSize: 20),
      underline: Container(
        height: 2,
        color: Colors.black
      ),
      onChanged: onValueChanged, 
      items: items
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}