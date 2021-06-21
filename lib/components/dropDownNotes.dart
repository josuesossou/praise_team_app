import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/utils/calculateTranspose.dart';

class DropDownNotes extends StatelessWidget {
  DropDownNotes({ 
    @required this.dropdownValue, 
    @required this.onValueChanged
  });

  final String dropdownValue;
  final Function onValueChanged;
  final Transpose transpose = Transpose();
  
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
      items: transpose.listOfNotes
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}