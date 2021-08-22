import 'package:flutter/material.dart';
// import './models/AuthModel.dart';
// import 'package:provider/provider.dart';

// firebase imports
// import 'package:firebase_core/firebase_core.dart';


// dart async library we will refer to when setting up real time updates
import 'dart:async';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

// logics
// import './utils/auth_status.dart';

// // widgets
// import './start/login.dart';
// import './start/main.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'models/Todo.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

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
      child: SwitchNavigator()
      // ChangeNotifierProvider<AuthModel>(
      //   create: (_) => AuthModel(),
      //   child: SwitchNavigator()
      // )
      // FutureBuilder(
      //   future:  _fbApp,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Text(snapshot.error.toString());
      //     } else if(snapshot.hasData) {
      //       return ChangeNotifierProvider<AuthModel>(
      //         create: (_) => AuthModel(),
      //         child: SwitchNavigator()
      //       );
      //     } else {
      //       return CircularProgressIndicator();
      //     }
      //   }
      // )
    );
  }
}

class SwitchNavigator extends StatefulWidget {
  @override
  _SwitchNavigatorState createState() => _SwitchNavigatorState();
}

class _SwitchNavigatorState extends State<SwitchNavigator> {
  bool _amplifyConfigured = false;

  void _configureAmplify() async {

    // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed
    await Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthModel>(context);
    // myModel.doSomething();
    return _amplifyConfigured ? MaterialApp(

    home: Scaffold(
      appBar: AppBar(),
      body: Container(color: Colors.lightBlue,),
    ))
    // MaterialApp(
    //   theme: ThemeData(
    //     brightness: Brightness.light,
    //     primaryColor: Colors.white,
    //     primaryColorLight: Color(0xfff0f0f0),
    //     primaryColorDark: Color(0xffe0e0e0),
    //     accentColor: Color(0xff01A0C7)
    //   ),
    //   home:  auth.authUser == null ? MainApp() : Login(),
    // ) 
    : MaterialApp(
      home: Container()
    );

    
  }
}

final item = Todo(
		name: "Lorem ipsum dolor sit amet",
		description: "Lorem ipsum dolor sit amet");
await Amplify.DataStore.save(item);