import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/dbUsersQuery.dart';

class AuthModel with ChangeNotifier { 
  User authUser;
  String personalEmail;
  FirebaseAuth auth = FirebaseAuth.instance;
  DbUsers dbusers = DbUsers();

  AuthModel() {
    auth.authStateChanges()
      .listen((User user) {
        if (user == null) {
          authUser = null;
        } else {
          // check if email already exist
          //no need to use local storage, save user info in the db
          DbUsers().getUser(authUser.uid, personalEmail);
          authUser = user;
        }
        notifyListeners();
      });
  }

  Future<bool> doSigning(email, password, pEmail) async {
    personalEmail = pEmail;

    UserCredential organizationInfo = await auth.signInWithEmailAndPassword(email: email, password: password);
    bool isUser = await dbusers.checkUser(pEmail, organizationInfo.user.uid);
    // authUser.sendEmailVerification()

    //add personal email to login view
    return isUser;
  }
  
}