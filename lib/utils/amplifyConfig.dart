  // Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';

// Amplify plugins
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';


// amplify generated files
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';


Future<void> configureAmplify() async {
  final _dsPlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
  final _analyticsPlugin = AmplifyAnalyticsPinpoint();
  final _authPlugin = AmplifyAuthCognito();
  final _api = AmplifyAPI();

  await Amplify.addPlugins([ _api, _dsPlugin, _authPlugin, _analyticsPlugin]);

  try {
    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    // print(e);
  }
}
