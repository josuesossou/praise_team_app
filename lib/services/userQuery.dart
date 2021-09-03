import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/UserData.dart';

// Assumes that the user is already signs in. Only user this class
// in Widgets that has DashboardEntry in their parent tree
class User {
  AuthUser _user;
  List<AuthUserAttribute> _userAttributes;


  User() {
    if (_user == null) {
      _setUser();
    }
  }

  // Assumes that the user is already signed in
  void _setUser() async {
    _user = await Amplify.Auth.getCurrentUser();
    _userAttributes = await Amplify.Auth.fetchUserAttributes();
    print(_userAttributes);
  }

  AuthUser get getUser {
    if (_user == null) {
      _setUser();
    }
    return _user;
  }

  Attributes get getUserAttributes {
    Map<String, dynamic> _attributes = {};
    if (_userAttributes == null) {
      _setUser();
    } 
    _userAttributes.forEach((attr) {
      _attributes[attr.userAttributeKey] = attr.value;
    });
    
    print(_attributes);
    return Attributes.fromMap(_attributes);
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