import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/UserData.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';

import '../screens/profile.dart';
import '../screens/search.dart';
import '../screens/transposePage.dart';

import '../components/logo.dart';
import '../components/bottomNavigationBar.dart';
import '../components/button.dart';
import '../screens/home.dart';
import '../screens/addEvent.dart';


class DashboardEntry extends StatefulWidget {
  DashboardEntry({ Key key }) : super(key: key);

  @override
  _DashboardEntryState createState() => _DashboardEntryState();
}

class _DashboardEntryState extends State<DashboardEntry> {
  String _color = '0xFF4DB6AC';

  void _getUserData() async {
    try {
      UserData _user = await DbUserQuery().getMyUserData();
      if (_user != null) {
        setState(() {
          _color = _user.color;
        });
      }
    } catch (e) {
    }
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorLight: Color(0xfff0f0f0),
        primaryColorDark: Color(0xffe0e0e0),
        accentColor: Color(int.parse(_color)),
        fontFamily: 'Quicksand'
      ),
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({String title});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController controller = PageController(initialPage: 1);

  void _toAddEventPage() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => AddEvent())
    );
  }

  void _toSearchPage() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Search())
    );
  }

  void _toProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile())
    );
  }

  void _toTransposePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransposePage())
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    double size = 0.20 * mediaSize.width;
    double margin = 0.05 * mediaSize.height;
    ThemeData _theme = Theme.of(context);
   
    return Scaffold(
      backgroundColor: _theme.primaryColorLight,
      appBar: AppBar(
        leading: Logo(size: 14),
        elevation: 0,
        actions: [
          CirButton(
            child: Icon(Icons.build_circle_outlined, size: 25,),
            size: 50,
            onPress: _toTransposePage,
          )
        ],
        title: Text('Events'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Stack(
        children: [
          Home(controller: controller,),

          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigation(
              toProfilePage: () => _toProfilePage(),
              toSearchPage: () => _toSearchPage(),
            )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container( 
              margin: EdgeInsets.only(bottom: margin),
              child: CirButton(
                onPress: () => _toAddEventPage(),
                size: size,
                child: Icon(Icons.add),
                color: _theme.accentColor,
              )
            )
          ),
        ]
      )
    );
  }
}