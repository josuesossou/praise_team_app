import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// entry screens
import 'entry/entry.dart';
import 'entry/dashboard.dart';
import 'entry/auth.dart';
import 'entry/confirm.dart';

// amplify configuration
import 'utils/amplifyConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(
    Phoenix(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praise&Worship Team',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        // home
        if (settings.name == '/dashboard') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => 
              DashboardEntry(),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }

        // signup
        if (settings.name == '/auth') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
              Auth(),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }

        if (settings.name == '/confirm') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
              ConfirmScreen(data: settings.arguments as Map<String, dynamic>),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }

        return MaterialPageRoute(builder: (_) => EntryScreen());
      },
    );
  }
}