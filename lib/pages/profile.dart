import 'package:flutter/material.dart';
import '../components/arrowBack.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
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
      body: Container(),
    );
  }
}