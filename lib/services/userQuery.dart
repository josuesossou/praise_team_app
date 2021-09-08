import 'dart:developer';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/Organization.dart';
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
  User _user = User();

  Future<List<UserData>> getUsersData() async {
    try {
      var _orgData = await _user.getUserAttributes();
      List<UserData> _users = await Amplify.DataStore.query(
        UserData.classType,
        where: UserData.ORGANIZATIONID.eq(_orgData.orgId)
      );

      return _users;
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveUserData() async {
    try {

      var _getUser = await _user.getUser();
      var _getAttributes = await _user.getUserAttributes();

      UserData newUserData = UserData(
        uid: _getUser.userId,
        name: _getAttributes.name,
        role: _getAttributes.role,
        organizationId: _getAttributes.orgId,
        color: '0xFF4DB6AC'
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
  
  Future<bool> checkOrganization(orgId) async {
    try {
      List<Organization> _orgIds = await Amplify.DataStore.query(
        Organization.classType,
        where: Organization.ORGANIZATIONID.eq(orgId)
      );

      if (_orgIds.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserData> getMyUserData() async {
    AuthUser _userData = await _user.getUser();

    try {
      List<UserData> _user = await Amplify.DataStore.query(
        UserData.classType,
        where: UserData.UID.eq(_userData.userId)
      );

       print('@@@@@@@@@@@@@@@ USER DATA BACKEND');
    print(_user);
    print(_userData);

      if (_user.isEmpty) {
        return null;
      }
      
      return _user[0];
    } catch (e) {
       print('@@@@@@@@@@@@@@@ ERROR USER DATA');
    print(_user);
      return null;
    }
  }

  Future<bool> updateMyUserData(UserData userData) async {
    try {
      await Amplify.DataStore.save(userData);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class Attributes {
  Attributes({
    @required this.name,
    @required this.role,
    @required this.orgId
  });

  final String name;
  final String role;
  final String orgId;

  factory Attributes.fromMap(Map<String, dynamic> data) {
    return Attributes(
      name: data['name'],
      role: data['custom:role'],
      orgId: data['custom:organizationId'],
    );
  }
}