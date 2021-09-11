import 'dart:developer';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/Organization.dart';
import 'package:lgcogpraiseteam/models/UserData.dart';

// Assumes that the user is already signs in. Only user this class
// in Widgets that has DashboardEntry in their parent tree
class User {
  static AuthUser _user;
  static Attributes _userAttributes;

  Future<AuthUser> getUser() async {
    if (_user == null) {
      try {
        _user = await Amplify.Auth.getCurrentUser();
      } catch (e) {
        _user = null;
      }
      // return _user;
    } 
    return _user;
  }

  Future<Attributes> getUserAttributes() async {
    Map<String, dynamic> _attributes = {};

    if (_userAttributes == null) {
      try {
        var _getUserAttributes = await Amplify.Auth.fetchUserAttributes();
        _getUserAttributes.forEach((attr) {
          _attributes[attr.userAttributeKey] = attr.value;
        });

        _userAttributes = Attributes.fromMap(_attributes);
      
        return _userAttributes;
      } catch (e) {
        return null;
      }
    } else {
      return _userAttributes;
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
      return true;
    } catch (e) {
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
      if (_user.isEmpty) {
        return null;
      }
      
      return _user[0];
    } catch (e) {
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
    this.role = 'Musician',
    @required this.orgId
  });

  final String name, role, orgId;

  factory Attributes.fromMap(Map<String, dynamic> data) {
    return Attributes(
      name: data['name'].toString(),
      role: data['custom:role'].toString(),
      orgId: data['custom:organizationID'].toString(),
    );
  }
}