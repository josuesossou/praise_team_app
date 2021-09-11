import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({ Key key }) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  void _isUserExist() async {
    try {
      await Amplify.Auth.getCurrentUser();
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      Navigator.pushReplacementNamed(context, '/auth');
    }
  }

  @override
  void initState() {
    super.initState();
    _isUserExist();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width/4;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: _width,
          height: _width,
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
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Color(0xFF4DB6AC)),
            borderRadius: BorderRadius.all(Radius.circular(_width))
          ),
        ),
      )
    );
  }
}
