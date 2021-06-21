import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/AuthModel.dart';
import 'package:provider/provider.dart';

// firebase imports
import 'package:firebase_core/firebase_core.dart';

// logics
import './utils/auth_status.dart';

// widgets
import './start/login.dart';
import './start/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  

  @override
  Widget build(BuildContext context) {
    return Container(
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Colors.white,
      //   primaryColorLight: Color(0xfff0f0f0),
      //   primaryColorDark: Color(0xffe0e0e0),
      //   accentColor: Color(0xff01A0C7)
      // ),
      child: FutureBuilder(
        future:  _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if(snapshot.hasData) {
            return ChangeNotifierProvider<AuthModel>(
              create: (_) => AuthModel(),
              child: SwitchNavigator()
            );
          } else {
            return CircularProgressIndicator();
          }
        }
      )
    );
  }
}

class SwitchNavigator extends StatefulWidget {
  @override
  _SwitchNavigatorState createState() => _SwitchNavigatorState();
}

class _SwitchNavigatorState extends State<SwitchNavigator> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);
    // myModel.doSomething();
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorLight: Color(0xfff0f0f0),
        primaryColorDark: Color(0xffe0e0e0),
        accentColor: Color(0xff01A0C7)
      ),
      home:  auth.authUser == null ? 
            Login() : MainApp(),
    );
   


      //       MaterialApp(
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Colors.white,
      //   primaryColorLight: Color(0xfff0f0f0),
      //   primaryColorDark: Color(0xffe0e0e0),
      //   accentColor: Color(0xff01A0C7)
      // ),
  }
}

