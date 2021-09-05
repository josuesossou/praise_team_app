import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lgcogpraiseteam/components/button.dart';
import '../components/arrowBack.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  void _signOut() async {
    await Amplify.Auth.signOut();
    Phoenix.rebirth(context);
  }
  
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      appBar: AppBar(
        leading: ArrowBack(),
        elevation: 0,
        title: Text('Personal Info'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        child: Column(
          children: [
            RectButton(
              onPress: () {
                _signOut();
              }, 
              child: Text('Sign Out')
            )
          ],
        ),
      ),
    );
  }
}