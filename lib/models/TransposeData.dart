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

/** This is an auto generated class representing the TransposeData type in your schema. */
@immutable
class TransposeData extends Model {
  static const classType = const _TransposeDataModelType();
  final String id;
  final String transposeId;
  final String transposeKey;
  final int transposeNum;
  final String userName;
  final String songId;
  final String userId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const TransposeData._internal(
      {@required this.id,
      @required this.transposeId,
      this.transposeKey,
      this.transposeNum,
      this.userName,
      @required this.songId,
      @required this.userId});

  factory TransposeData(
      {String id,
      @required String transposeId,
      String transposeKey,
      int transposeNum,
      String userName,
      @required String songId,
      @required String userId}) {
    return TransposeData._internal(
        id: id == null ? UUID.getUUID() : id,
        transposeId: transposeId,
        transposeKey: transposeKey,
        transposeNum: transposeNum,
        userName: userName,
        songId: songId,
        userId: userId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransposeData &&
        id == other.id &&
        transposeId == other.transposeId &&
        transposeKey == other.transposeKey &&
        transposeNum == other.transposeNum &&
        userName == other.userName &&
        songId == other.songId &&
        userId == other.userId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("TransposeData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("transposeId=" + "$transposeId" + ", ");
    buffer.write("transposeKey=" + "$transposeKey" + ", ");
    buffer.write("transposeNum=" +
        (transposeNum != null ? transposeNum.toString() : "null") +
        ", ");
    buffer.write("userName=" + "$userName" + ", ");
    buffer.write("songId=" + "$songId" + ", ");
    buffer.write("userId=" + "$userId");
    buffer.write("}");

    return buffer.toString();
  }

  TransposeData copyWith(
      {String id,
      String transposeId,
      String transposeKey,
      int transposeNum,
      String userName,
      String songId,
      String userId}) {
    return TransposeData(
        id: id ?? this.id,
        transposeId: transposeId ?? this.transposeId,
        transposeKey: transposeKey ?? this.transposeKey,
        transposeNum: transposeNum ?? this.transposeNum,
        userName: userName ?? this.userName,
        songId: songId ?? this.songId,
        userId: userId ?? this.userId);
  }

  TransposeData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        transposeId = json['transposeId'],
        transposeKey = json['transposeKey'],
        transposeNum = json['transposeNum'],
        userName = json['userName'],
        songId = json['songId'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'transposeId': transposeId,
        'transposeKey': transposeKey,
        'transposeNum': transposeNum,
        'userName': userName,
        'songId': songId,
        'userId': userId
      };

  static final QueryField ID = QueryField(fieldName: "transposeData.id");
  static final QueryField TRANSPOSEID = QueryField(fieldName: "transposeId");
  static final QueryField TRANSPOSEKEY = QueryField(fieldName: "transposeKey");
  static final QueryField TRANSPOSENUM = QueryField(fieldName: "transposeNum");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField SONGID = QueryField(fieldName: "songId");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TransposeData";
    modelSchemaDefinition.pluralName = "TransposeData";

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
        key: TransposeData.TRANSPOSEID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TransposeData.TRANSPOSEKEY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TransposeData.TRANSPOSENUM,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TransposeData.USERNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TransposeData.SONGID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TransposeData.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _TransposeDataModelType extends ModelType<TransposeData> {
  const _TransposeDataModelType();

  @override
  TransposeData fromJson(Map<String, dynamic> jsonData) {
    return TransposeData.fromJson(jsonData);
  }
}
