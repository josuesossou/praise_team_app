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
    return Container(child: Text('Loading...'),);
  }
}
