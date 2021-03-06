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
import 'Event.dart';
import 'FileURL.dart';
import 'Organization.dart';
import 'Song.dart';
import 'TransposeData.dart';
import 'UserData.dart';

export 'Event.dart';
export 'FileURL.dart';
export 'Organization.dart';
export 'Song.dart';
export 'TransposeData.dart';
export 'UserData.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "5d3d6fc665c67816f52b30f0963e7623";
  @override
  List<ModelSchema> modelSchemas = [
    Event.schema,
    FileURL.schema,
    Organization.schema,
    Song.schema,
    TransposeData.schema,
    UserData.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Event":
        {
          return Event.classType;
        }
        break;
      case "FileURL":
        {
          return FileURL.classType;
        }
        break;
      case "Organization":
        {
          return Organization.classType;
        }
        break;
      case "Song":
        {
          return Song.classType;
        }
        break;
      case "TransposeData":
        {
          return TransposeData.classType;
        }
        break;
      case "UserData":
        {
          return UserData.classType;
        }
        break;
      default:
        {
          throw Exception(
              "Failed to find model in model provider for model name: " +
                  modelName);
        }
    }
  }
}
