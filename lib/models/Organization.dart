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

/** This is an auto generated class representing the Organization type in your schema. */
@immutable
class Organization extends Model {
  static const classType = const _OrganizationModelType();
  final String id;
  final List<String> organizationIds;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Organization._internal({@required this.id, this.organizationIds});

  factory Organization({String id, List<String> organizationIds}) {
    return Organization._internal(
        id: id == null ? UUID.getUUID() : id,
        organizationIds: organizationIds != null
            ? List<String>.unmodifiable(organizationIds)
            : organizationIds);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Organization &&
        id == other.id &&
        DeepCollectionEquality().equals(organizationIds, other.organizationIds);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Organization {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("organizationIds=" +
        (organizationIds != null ? organizationIds.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Organization copyWith({String id, List<String> organizationIds}) {
    return Organization(
        id: id ?? this.id,
        organizationIds: organizationIds ?? this.organizationIds);
  }

  Organization.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        organizationIds = json['organizationIds']?.cast<String>();

  Map<String, dynamic> toJson() =>
      {'id': id, 'organizationIds': organizationIds};

  static final QueryField ID = QueryField(fieldName: "organization.id");
  static final QueryField ORGANIZATIONIDS =
      QueryField(fieldName: "organizationIds");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Organization";
    modelSchemaDefinition.pluralName = "Organizations";

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
        key: Organization.ORGANIZATIONIDS,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));
  });
}

class _OrganizationModelType extends ModelType<Organization> {
  const _OrganizationModelType();

  @override
  Organization fromJson(Map<String, dynamic> jsonData) {
    return Organization.fromJson(jsonData);
  }
}
