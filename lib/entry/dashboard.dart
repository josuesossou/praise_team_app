import 'package:flutter/material.dart';
// import 'package:lgcogpraiseteam/models/AuthModel.dart';
import '../screens/profile.dart';
import '../screens/search.dart';
import '../screens/transposePage.dart';
// import '../utils/auth_status.dart';
// import '../utils/calculateTranspose.dart';
// import 'package:provider/provider.dart';
import '../components/logo.dart';
import '../components/bottomNavigationBar.dart';
import '../components/button.dart';
import '../screens/home.dart';
import '../screens/addEvent.dart';

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
   
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
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
                color: Color(0xff01A0C7),
              )
            )
          ),
        ]
      ),
    );
  }
}