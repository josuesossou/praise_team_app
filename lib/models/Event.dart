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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Event type in your schema. */
@immutable
class Event extends Model {
  static const classType = const _EventModelType();
  final String id;
  final String name;
  final String date;
  final TemporalTimestamp createdAt;
  final int dateStamp;
  final List<String> songIds;
  final String bgCover;
  final String createdBy;
  final String creatorName;
  final String orgId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Event._internal(
      {@required this.id,
      @required this.name,
      this.date,
      @required this.createdAt,
      this.dateStamp,
      this.songIds,
      this.bgCover,
      this.createdBy,
      this.creatorName,
      @required this.orgId});

  factory Event(
      {String id,
      @required String name,
      String date,
      @required TemporalTimestamp createdAt,
      int dateStamp,
      List<String> songIds,
      String bgCover,
      String createdBy,
      String creatorName,
      @required String orgId}) {
    return Event._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        date: date,
        createdAt: createdAt,
        dateStamp: dateStamp,
        songIds: songIds != null ? List<String>.unmodifiable(songIds) : songIds,
        bgCover: bgCover,
        createdBy: createdBy,
        creatorName: creatorName,
        orgId: orgId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
        id == other.id &&
        name == other.name &&
        date == other.date &&
        createdAt == other.createdAt &&
        dateStamp == other.dateStamp &&
        DeepCollectionEquality().equals(songIds, other.songIds) &&
        bgCover == other.bgCover &&
        createdBy == other.createdBy &&
        creatorName == other.creatorName &&
        orgId == other.orgId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Event {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("date=" + "$date" + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.toString() : "null") +
        ", ");
    buffer.write("dateStamp=" +
        (dateStamp != null ? dateStamp.toString() : "null") +
        ", ");
    buffer.write(
        "songIds=" + (songIds != null ? songIds.toString() : "null") + ", ");
    buffer.write("bgCover=" + "$bgCover" + ", ");
    buffer.write("createdBy=" + "$createdBy" + ", ");
    buffer.write("creatorName=" + "$creatorName" + ", ");
    buffer.write("orgId=" + "$orgId");
    buffer.write("}");

    return buffer.toString();
  }

  Event copyWith(
      {String id,
      String name,
      String date,
      TemporalTimestamp createdAt,
      int dateStamp,
      List<String> songIds,
      String bgCover,
      String createdBy,
      String creatorName,
      String orgId}) {
    return Event(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        createdAt: createdAt ?? this.createdAt,
        dateStamp: dateStamp ?? this.dateStamp,
        songIds: songIds ?? this.songIds,
        bgCover: bgCover ?? this.bgCover,
        createdBy: createdBy ?? this.createdBy,
        creatorName: creatorName ?? this.creatorName,
        orgId: orgId ?? this.orgId);
  }

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = json['date'],
        createdAt = json['createdAt'] != null
            ? TemporalTimestamp.fromSeconds(json['createdAt'])
            : null,
        dateStamp = json['dateStamp'],
        songIds = json['songIds']?.cast<String>(),
        bgCover = json['bgCover'],
        createdBy = json['createdBy'],
        creatorName = json['creatorName'],
        orgId = json['orgId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'createdAt': createdAt?.toSeconds(),
        'dateStamp': dateStamp,
        'songIds': songIds,
        'bgCover': bgCover,
        'createdBy': createdBy,
        'creatorName': creatorName,
        'orgId': orgId
      };

  static final QueryField ID = QueryField(fieldName: "event.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField DATESTAMP = QueryField(fieldName: "dateStamp");
  static final QueryField SONGIDS = QueryField(fieldName: "songIds");
  static final QueryField BGCOVER = QueryField(fieldName: "bgCover");
  static final QueryField CREATEDBY = QueryField(fieldName: "createdBy");
  static final QueryField CREATORNAME = QueryField(fieldName: "creatorName");
  static final QueryField ORGID = QueryField(fieldName: "orgId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Event";
    modelSchemaDefinition.pluralName = "Events";

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
        key: Event.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.DATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.CREATEDAT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.DATESTAMP,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.SONGIDS,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.BGCOVER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.CREATEDBY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.CREATORNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.ORGID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _EventModelType extends ModelType<Event> {
  const _EventModelType();

  @override
  Event fromJson(Map<String, dynamic> jsonData) {
    return Event.fromJson(jsonData);
  }
}
