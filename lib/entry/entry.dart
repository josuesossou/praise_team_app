import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';


class EntryScreen extends StatefulWidget {
  const EntryScreen({ Key key }) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

  // AuthUser _user;

  void _isUserExist() async {
    try {
      var user = await Amplify.Auth.getCurrentUser();
      print(user);
      print(user.username);

      // Navigator.pushReplacementNamed(context, '/mainApp');
      
      // setState(() {
      //   _user = user;
      // });
    } catch (e) {
      // setState(() {
      //   _user = null;
      // });
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
    return Container(child: Text('Loading...'),);
  }
}

      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Colors.white,
      //   primaryColorLight: Color(0xfff0f0f0),
      //   primaryColorDark: Color(0xffe0e0e0),
      //   accentColor: Color(0xff01A0C7)
      // ),