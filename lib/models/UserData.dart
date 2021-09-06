/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the UserData type in your schema. */
@immutable
class UserData extends Model {
  static const classType = const _UserDataModelType();
  final String id;
  final String uid;
  final String name;
  final String role;
  final String organizationId;
  final String color;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const UserData._internal(
      {@required this.id,
      @required this.uid,
      this.name,
      this.role,
      @required this.organizationId,
      this.color});

  factory UserData(
      {String id,
      @required String uid,
      String name,
      String role,
      @required String organizationId,
      String color}) {
    return UserData._internal(
        id: id == null ? UUID.getUUID() : id,
        uid: uid,
        name: name,
        role: role,
        organizationId: organizationId,
        color: color);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserData &&
        id == other.id &&
        uid == other.uid &&
        name == other.name &&
        role == other.role &&
        organizationId == other.organizationId &&
        color == other.color;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("uid=" + "$uid" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("role=" + "$role" + ", ");
    buffer.write("organizationId=" + "$organizationId" + ", ");
    buffer.write("color=" + "$color");
    buffer.write("}");

    return buffer.toString();
  }

  UserData copyWith(
      {String id,
      String uid,
      String name,
      String role,
      String organizationId,
      String color}) {
    return UserData(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        role: role ?? this.role,
        organizationId: organizationId ?? this.organizationId,
        color: color ?? this.color);
  }

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        uid = json['uid'],
        name = json['name'],
        role = json['role'],
        organizationId = json['organizationId'],
        color = json['color'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'role': role,
        'organizationId': organizationId,
        'color': color
      };

  static final QueryField ID = QueryField(fieldName: "userData.id");
  static final QueryField UID = QueryField(fieldName: "uid");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ROLE = QueryField(fieldName: "role");
  static final QueryField ORGANIZATIONID =
      QueryField(fieldName: "organizationId");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserData";
    modelSchemaDefinition.pluralName = "UserData";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.UID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.ROLE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.ORGANIZATIONID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.COLOR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _UserDataModelType extends ModelType<UserData> {
  const _UserDataModelType();

  @override
  UserData fromJson(Map<String, dynamic> jsonData) {
    return UserData.fromJson(jsonData);
  }
}
