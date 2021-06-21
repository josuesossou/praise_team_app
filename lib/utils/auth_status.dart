import 'package:flutter/foundation.dart';

class MyModel with ChangeNotifier { 
  String authStatus = 'good';

  doSomething() {
    authStatus = 'Goodbye';
    print(authStatus);

    notifyListeners();
  }
}