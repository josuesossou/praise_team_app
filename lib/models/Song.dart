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

/** This is an auto generated class representing the Song type in your schema. */
@immutable
class Song extends Model {
  static const classType = const _SongModelType();
  final String id;
  final String songId;
  final String channelId;
  final String channelTitle;
  final String etag;
  final String videoTitle;
  final String videoTitleLowercase;
  final String videoId;
  final String videoDescription;
  final int videoThumDefaultH;
  final int videoThumbDefaultW;
  final String videoThumbDefaultUrl;
  final int videoThumbMediumH;
  final String videoThumbMediumUrl;
  final int videoThumbMediumW;
  final String lastDatePlayed;
  final List<String> musicSheets;
  final TemporalTimestamp createdAt;
  final String originalkey;
  final int numOfTimePlayed;
  final String transposedKey;
  final int transposedNumber;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Song._internal(
      {@required this.id,
      @required this.songId,
      this.channelId,
      this.channelTitle,
      this.etag,
      @required this.videoTitle,
      @required this.videoTitleLowercase,
      @required this.videoId,
      this.videoDescription,
      this.videoThumDefaultH,
      this.videoThumbDefaultW,
      this.videoThumbDefaultUrl,
      this.videoThumbMediumH,
      this.videoThumbMediumUrl,
      this.videoThumbMediumW,
      this.lastDatePlayed,
      this.musicSheets,
      this.createdAt,
      this.originalkey,
      this.numOfTimePlayed,
      this.transposedKey,
      this.transposedNumber});

  factory Song(
      {String id,
      @required String songId,
      String channelId,
      String channelTitle,
      String etag,
      @required String videoTitle,
      @required String videoTitleLowercase,
      @required String videoId,
      String videoDescription,
      int videoThumDefaultH,
      int videoThumbDefaultW,
      String videoThumbDefaultUrl,
      int videoThumbMediumH,
      String videoThumbMediumUrl,
      int videoThumbMediumW,
      String lastDatePlayed,
      List<String> musicSheets,
      TemporalTimestamp createdAt,
      String originalkey,
      int numOfTimePlayed,
      String transposedKey,
      int transposedNumber}) {
    return Song._internal(
        id: id == null ? UUID.getUUID() : id,
        songId: songId,
        channelId: channelId,
        channelTitle: channelTitle,
        etag: etag,
        videoTitle: videoTitle,
        videoTitleLowercase: videoTitleLowercase,
        videoId: videoId,
        videoDescription: videoDescription,
        videoThumDefaultH: videoThumDefaultH,
        videoThumbDefaultW: videoThumbDefaultW,
        videoThumbDefaultUrl: videoThumbDefaultUrl,
        videoThumbMediumH: videoThumbMediumH,
        videoThumbMediumUrl: videoThumbMediumUrl,
        videoThumbMediumW: videoThumbMediumW,
        lastDatePlayed: lastDatePlayed,
        musicSheets: musicSheets != null
            ? List<String>.unmodifiable(musicSheets)
            : musicSheets,
        createdAt: createdAt,
        originalkey: originalkey,
        numOfTimePlayed: numOfTimePlayed,
        transposedKey: transposedKey,
        transposedNumber: transposedNumber);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Song &&
        id == other.id &&
        songId == other.songId &&
        channelId == other.channelId &&
        channelTitle == other.channelTitle &&
        etag == other.etag &&
        videoTitle == other.videoTitle &&
        videoTitleLowercase == other.videoTitleLowercase &&
        videoId == other.videoId &&
        videoDescription == other.videoDescription &&
        videoThumDefaultH == other.videoThumDefaultH &&
        videoThumbDefaultW == other.videoThumbDefaultW &&
        videoThumbDefaultUrl == other.videoThumbDefaultUrl &&
        videoThumbMediumH == other.videoThumbMediumH &&
        videoThumbMediumUrl == other.videoThumbMediumUrl &&
        videoThumbMediumW == other.videoThumbMediumW &&
        lastDatePlayed == other.lastDatePlayed &&
        DeepCollectionEquality().equals(musicSheets, other.musicSheets) &&
        createdAt == other.createdAt &&
        originalkey == other.originalkey &&
        numOfTimePlayed == other.numOfTimePlayed &&
        transposedKey == other.transposedKey &&
        transposedNumber == other.transposedNumber;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Song {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("songId=" + "$songId" + ", ");
    buffer.write("channelId=" + "$channelId" + ", ");
    buffer.write("channelTitle=" + "$channelTitle" + ", ");
    buffer.write("etag=" + "$etag" + ", ");
    buffer.write("videoTitle=" + "$videoTitle" + ", ");
    buffer.write("videoTitleLowercase=" + "$videoTitleLowercase" + ", ");
    buffer.write("videoId=" + "$videoId" + ", ");
    buffer.write("videoDescription=" + "$videoDescription" + ", ");
    buffer.write("videoThumDefaultH=" +
        (videoThumDefaultH != null ? videoThumDefaultH.toString() : "null") +
        ", ");
    buffer.write("videoThumbDefaultW=" +
        (videoThumbDefaultW != null ? videoThumbDefaultW.toString() : "null") +
        ", ");
    buffer.write("videoThumbDefaultUrl=" + "$videoThumbDefaultUrl" + ", ");
    buffer.write("videoThumbMediumH=" +
        (videoThumbMediumH != null ? videoThumbMediumH.toString() : "null") +
        ", ");
    buffer.write("videoThumbMediumUrl=" + "$videoThumbMediumUrl" + ", ");
    buffer.write("videoThumbMediumW=" +
        (videoThumbMediumW != null ? videoThumbMediumW.toString() : "null") +
        ", ");
    buffer.write("lastDatePlayed=" + "$lastDatePlayed" + ", ");
    buffer.write("musicSheets=" +
        (musicSheets != null ? musicSheets.toString() : "null") +
        ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.toString() : "null") +
        ", ");
    buffer.write("originalkey=" + "$originalkey" + ", ");
    buffer.write("numOfTimePlayed=" +
        (numOfTimePlayed != null ? numOfTimePlayed.toString() : "null") +
        ", ");
    buffer.write("transposedKey=" + "$transposedKey" + ", ");
    buffer.write("transposedNumber=" +
        (transposedNumber != null ? transposedNumber.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Song copyWith(
      {String id,
      String songId,
      String channelId,
      String channelTitle,
      String etag,
      String videoTitle,
      String videoTitleLowercase,
      String videoId,
      String videoDescription,
      int videoThumDefaultH,
      int videoThumbDefaultW,
      String videoThumbDefaultUrl,
      int videoThumbMediumH,
      String videoThumbMediumUrl,
      int videoThumbMediumW,
      String lastDatePlayed,
      List<String> musicSheets,
      TemporalTimestamp createdAt,
      String originalkey,
      int numOfTimePlayed,
      String transposedKey,
      int transposedNumber}) {
    return Song(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        channelId: channelId ?? this.channelId,
        channelTitle: channelTitle ?? this.channelTitle,
        etag: etag ?? this.etag,
        videoTitle: videoTitle ?? this.videoTitle,
        videoTitleLowercase: videoTitleLowercase ?? this.videoTitleLowercase,
        videoId: videoId ?? this.videoId,
        videoDescription: videoDescription ?? this.videoDescription,
        videoThumDefaultH: videoThumDefaultH ?? this.videoThumDefaultH,
        videoThumbDefaultW: videoThumbDefaultW ?? this.videoThumbDefaultW,
        videoThumbDefaultUrl: videoThumbDefaultUrl ?? this.videoThumbDefaultUrl,
        videoThumbMediumH: videoThumbMediumH ?? this.videoThumbMediumH,
        videoThumbMediumUrl: videoThumbMediumUrl ?? this.videoThumbMediumUrl,
        videoThumbMediumW: videoThumbMediumW ?? this.videoThumbMediumW,
        lastDatePlayed: lastDatePlayed ?? this.lastDatePlayed,
        musicSheets: musicSheets ?? this.musicSheets,
        createdAt: createdAt ?? this.createdAt,
        originalkey: originalkey ?? this.originalkey,
        numOfTimePlayed: numOfTimePlayed ?? this.numOfTimePlayed,
        transposedKey: transposedKey ?? this.transposedKey,
        transposedNumber: transposedNumber ?? this.transposedNumber);
  }

  Song.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        songId = json['songId'],
        channelId = json['channelId'],
        channelTitle = json['channelTitle'],
        etag = json['etag'],
        videoTitle = json['videoTitle'],
        videoTitleLowercase = json['videoTitleLowercase'],
        videoId = json['videoId'],
        videoDescription = json['videoDescription'],
        videoThumDefaultH = json['videoThumDefaultH'],
        videoThumbDefaultW = json['videoThumbDefaultW'],
        videoThumbDefaultUrl = json['videoThumbDefaultUrl'],
        videoThumbMediumH = json['videoThumbMediumH'],
        videoThumbMediumUrl = json['videoThumbMediumUrl'],
        videoThumbMediumW = json['videoThumbMediumW'],
        lastDatePlayed = json['lastDatePlayed'],
        musicSheets = json['musicSheets']?.cast<String>(),
        createdAt = json['createdAt'] != null
            ? TemporalTimestamp.fromSeconds(json['createdAt'])
            : null,
        originalkey = json['originalkey'],
        numOfTimePlayed = json['numOfTimePlayed'],
        transposedKey = json['transposedKey'],
        transposedNumber = json['transposedNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'songId': songId,
        'channelId': channelId,
        'channelTitle': channelTitle,
        'etag': etag,
        'videoTitle': videoTitle,
        'videoTitleLowercase': videoTitleLowercase,
        'videoId': videoId,
        'videoDescription': videoDescription,
        'videoThumDefaultH': videoThumDefaultH,
        'videoThumbDefaultW': videoThumbDefaultW,
        'videoThumbDefaultUrl': videoThumbDefaultUrl,
        'videoThumbMediumH': videoThumbMediumH,
        'videoThumbMediumUrl': videoThumbMediumUrl,
        'videoThumbMediumW': videoThumbMediumW,
        'lastDatePlayed': lastDatePlayed,
        'musicSheets': musicSheets,
        'createdAt': createdAt?.toSeconds(),
        'originalkey': originalkey,
        'numOfTimePlayed': numOfTimePlayed,
        'transposedKey': transposedKey,
        'transposedNumber': transposedNumber
      };

  static final QueryField ID = QueryField(fieldName: "song.id");
  static final QueryField SONGID = QueryField(fieldName: "songId");
  static final QueryField CHANNELID = QueryField(fieldName: "channelId");
  static final QueryField CHANNELTITLE = QueryField(fieldName: "channelTitle");
  static final QueryField ETAG = QueryField(fieldName: "etag");
  static final QueryField VIDEOTITLE = QueryField(fieldName: "videoTitle");
  static final QueryField VIDEOTITLELOWERCASE =
      QueryField(fieldName: "videoTitleLowercase");
  static final QueryField VIDEOID = QueryField(fieldName: "videoId");
  static final QueryField VIDEODESCRIPTION =
      QueryField(fieldName: "videoDescription");
  static final QueryField VIDEOTHUMDEFAULTH =
      QueryField(fieldName: "videoThumDefaultH");
  static final QueryField VIDEOTHUMBDEFAULTW =
      QueryField(fieldName: "videoThumbDefaultW");
  static final QueryField VIDEOTHUMBDEFAULTURL =
      QueryField(fieldName: "videoThumbDefaultUrl");
  static final QueryField VIDEOTHUMBMEDIUMH =
      QueryField(fieldName: "videoThumbMediumH");
  static final QueryField VIDEOTHUMBMEDIUMURL =
      QueryField(fieldName: "videoThumbMediumUrl");
  static final QueryField VIDEOTHUMBMEDIUMW =
      QueryField(fieldName: "videoThumbMediumW");
  static final QueryField LASTDATEPLAYED =
      QueryField(fieldName: "lastDatePlayed");
  static final QueryField MUSICSHEETS = QueryField(fieldName: "musicSheets");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField ORIGINALKEY = QueryField(fieldName: "originalkey");
  static final QueryField NUMOFTIMEPLAYED =
      QueryField(fieldName: "numOfTimePlayed");
  static final QueryField TRANSPOSEDKEY =
      QueryField(fieldName: "transposedKey");
  static final QueryField TRANSPOSEDNUMBER =
      QueryField(fieldName: "transposedNumber");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Song";
    modelSchemaDefinition.pluralName = "Songs";

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
        key: Song.SONGID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.CHANNELID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.CHANNELTITLE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.ETAG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTITLE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTITLELOWERCASE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEODESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTHUMDEFAULTH,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTHUMBDEFAULTW,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTHUMBDEFAULTURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTHUMBMEDIUMH,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTHUMBMEDIUMURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.VIDEOTHUMBMEDIUMW,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.LASTDATEPLAYED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.MUSICSHEETS,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.ORIGINALKEY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.NUMOFTIMEPLAYED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.TRANSPOSEDKEY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Song.TRANSPOSEDNUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));
  });
}

class _SongModelType extends ModelType<Song> {
  const _SongModelType();

  @override
  Song fromJson(Map<String, dynamic> jsonData) {
    return Song.fromJson(jsonData);
  }
}
