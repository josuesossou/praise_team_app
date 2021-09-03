import 'dart:developer';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/UserData.dart';

// Assumes that the user is already signs in. Only user this class
// in Widgets that has DashboardEntry in their parent tree
class User {
  Future<AuthUser> getUser() async {
    try {
      return await Amplify.Auth.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  Future<Attributes> getUserAttributes() async {
    Map<String, dynamic> _attributes = {};
    try {
      var _userAttributes = await Amplify.Auth.fetchUserAttributes();
      _userAttributes.forEach((attr) {
        _attributes[attr.userAttributeKey] = attr.value;
      });
    
      return Attributes.fromMap(_attributes);
    } catch (e) {
      return null;
    }
  }
}

class DbUserQuery {
  Future<List<UserData>> getUserData() async {
    try {
      List<UserData> _users = await Amplify.DataStore.query(
        UserData.classType
      );

      return _users;
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveUserData() async {
    try {
      var _user = User();
      var _getUser = await _user.getUser();
      var _getAttributes = await _user.getUserAttributes();

      UserData newUserData = UserData(
        uid: _getUser.userId,
        name: _getAttributes.name,
        role: _getAttributes.role,
      );

      await Amplify.DataStore.save(newUserData);

      print("@@@@@@@@@@ SAVE USERDATA @@@@@");
      print(inspect(newUserData));
      return true;
    } catch (e) {
      print("@@@@@@@@@@ SAVE USERDATA ERROR @@@@@");
      print(inspect(e));
      return true;
    }
  }
  /// TODO: check organization
}

class Attributes {
  Attributes({
    @required this.name,
    @required this.role,
  });

  final String name;
  final String role;

  factory Attributes.fromMap(Map<String, dynamic> data) {
    return Attributes(
      name: data['name'],
      role: data['custom:role'],
    );
  }
}