import 'package:flutter/material.dart';
import '../components/arrowBack.dart';
import '../components/dropDownNotes.dart';
import '../components/flexText.dart';
import '../components/textField.dart';
import '../utils/calculateTranspose.dart';

class TransposePage extends StatefulWidget {
  @override
  _TransposePageState createState() => _TransposePageState();
}

class _TransposePageState extends State<TransposePage> {

  int transposedNumber = 0;
  List<String> notes = [
    'Not Set', 
    'Not Set',
    'Not Set', 
    'Not Set',
    'Not Set'
  ];
  List<String> transposeResults = [
    'Not Set', 
    'Not Set',
    'Not Set', 
    'Not Set',
    'Not Set'
  ]; 

  onChangeTranspose(val) {
    setState(() {
      transposedNumber = int.parse(val);
    });
  }

  onDropdownValChanged(val, i) {
    String transposekey = Transpose().getTransposedKey(val, transposedNumber);
    setState(() {
      notes[i] = val;
      transposeResults[i] = transposekey;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      appBar: AppBar(
        leading: ArrowBack(),
        elevation: 0,
        title: Text('Transpose'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body:  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.80 * size.height,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlexText(
                    text: 'Transpose:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFieldCop(
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.zero,
                      obscureText: false,
                      onChange: onChangeTranspose,
                      keyboardType: TextInputType.number,
                      radius: 0,
                      hintText: transposedNumber.toString(),
                      color: Colors.white,
                      border: BorderSide(width: 2, color: Colors.black),
                    ),
                  )
                ]
              ),
            ),

            Column(
              children: notes.asMap().entries.map((entry) => (
                Container(
                  height: 70,
                  color: theme.primaryColor,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownNotes(
                        dropdownValue: entry.value,
                        onValueChanged: (val) => onDropdownValChanged(val, entry.key),
                      ),

                      Icon(Icons.arrow_right_alt_sharp),

                      FlexText(
                        text: transposeResults[entry.key],
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
                )
              )).toList(),
            ),
          ],
        ),
      ),
      )
    );
  }
}