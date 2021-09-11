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

/** This is an auto generated class representing the FileURL type in your schema. */
@immutable
class FileURL extends Model {
  static const classType = const _FileURLModelType();
  final String id;
  final String url;
  final String byUser;
  final String userName;
  final String songID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const FileURL._internal(
      {@required this.id, this.url, this.byUser, this.userName, this.songID});

  factory FileURL(
      {String id, String url, String byUser, String userName, String songID}) {
    return FileURL._internal(
        id: id == null ? UUID.getUUID() : id,
        url: url,
        byUser: byUser,
        userName: userName,
        songID: songID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileURL &&
        id == other.id &&
        url == other.url &&
        byUser == other.byUser &&
        userName == other.userName &&
        songID == other.songID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("FileURL {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("url=" + "$url" + ", ");
    buffer.write("byUser=" + "$byUser" + ", ");
    buffer.write("userName=" + "$userName" + ", ");
    buffer.write("songID=" + "$songID");
    buffer.write("}");

    return buffer.toString();
  }

  FileURL copyWith(
      {String id, String url, String byUser, String userName, String songID}) {
    return FileURL(
        id: id ?? this.id,
        url: url ?? this.url,
        byUser: byUser ?? this.byUser,
        userName: userName ?? this.userName,
        songID: songID ?? this.songID);
  }

  FileURL.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        byUser = json['byUser'],
        userName = json['userName'],
        songID = json['songID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'byUser': byUser,
        'userName': userName,
        'songID': songID
      };

  static final QueryField ID = QueryField(fieldName: "fileURL.id");
  static final QueryField URL = QueryField(fieldName: "url");
  static final QueryField BYUSER = QueryField(fieldName: "byUser");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField SONGID = QueryField(fieldName: "songID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "FileURL";
    modelSchemaDefinition.pluralName = "FileURLS";

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
        key: FileURL.URL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FileURL.BYUSER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FileURL.USERNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FileURL.SONGID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _FileURLModelType extends ModelType<FileURL> {
  const _FileURLModelType();

  @override
  FileURL fromJson(Map<String, dynamic> jsonData) {
    return FileURL.fromJson(jsonData);
  }
}
