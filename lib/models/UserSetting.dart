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

/** This is an auto generated class representing the UserSetting type in your schema. */
@immutable
class UserSetting extends Model {
  static const classType = const _UserSettingModelType();
  final String id;
  final String color;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const UserSetting._internal({@required this.id, this.color});

  factory UserSetting({String id, String color}) {
    return UserSetting._internal(
        id: id == null ? UUID.getUUID() : id, color: color);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSetting && id == other.id && color == other.color;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserSetting {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("color=" + "$color");
    buffer.write("}");

    return buffer.toString();
  }

  UserSetting copyWith({String id, String color}) {
    return UserSetting(id: id ?? this.id, color: color ?? this.color);
  }

  UserSetting.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        color = json['color'];

  Map<String, dynamic> toJson() => {'id': id, 'color': color};

  static final QueryField ID = QueryField(fieldName: "userSetting.id");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserSetting";
    modelSchemaDefinition.pluralName = "UserSettings";

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
        key: UserSetting.COLOR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _UserSettingModelType extends ModelType<UserSetting> {
  const _UserSettingModelType();

  @override
  UserSetting fromJson(Map<String, dynamic> jsonData) {
    return UserSetting.fromJson(jsonData);
  }
}
