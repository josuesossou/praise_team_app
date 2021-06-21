import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  SongModel({
    @required this.songId,
    this.createdAt,
    this.transposedNumber = 0,
    this.transposedKey = 'Not Set',
    this.lastDatePlayed = 'New Song',
    this.originalkey = 'Not Set',
    @required this.etag,
    @required this.videoId,
    @required this.videoDescription,
    @required this.videoThumDefaultH,
    @required this.videoThumbDefaultW,
    @required this.videoThumbDefaultUrl,
    @required this.videoThumbMediumH,
    @required this.videoThumbMediumUrl,
    @required this.videoThumbMediumW,
    @required this.videoTitle,
    @required this.videoTitleLowercase,
    @required this.channelId,
    @required this.channelTitle,
    this.musicSheets = const [],
    this.numOfTimePlayed = 0,
  });

  String transposedKey, originalkey, videoTitleLowercase,
          lastDatePlayed, videoId, videoTitle, etag,
          channelId, channelTitle, videoDescription,
          videoThumbDefaultUrl, videoThumbMediumUrl, songId;
  int transposedNumber, numOfTimePlayed, videoThumDefaultH,
      videoThumbDefaultW, videoThumbMediumH, videoThumbMediumW;
  List musicSheets;
  Timestamp createdAt; // needs to be timestamp so that query order to work

  factory SongModel.fromMap(Map data) {
    return SongModel(
      songId: data['songId'],
      channelId: data['channelId'],
      channelTitle: data['channelTitle'],
      etag: data['etag'],
      videoTitle: data['videoTitle'],
      videoTitleLowercase: data['videoTitleLowercase'],
      videoId: data['videoId'],
      videoDescription: data['videoDescription'],
      videoThumDefaultH: data['videoThumDefaultH'],
      videoThumbDefaultW: data['videoThumbDefaultW'],
      videoThumbDefaultUrl: data['videoThumbDefaultUrl'],
      videoThumbMediumH: data['videoThumbMediumH'],
      videoThumbMediumUrl: data['videoThumbMediumUrl'],
      videoThumbMediumW: data['videoThumbMediumW'],
      lastDatePlayed: data['lastDatePlayed'],
      musicSheets: data['musicSheets'],
      createdAt: data['createdAt'],
      originalkey: data['originalkey'],
      numOfTimePlayed: data['numOfTimePlayed'],
      transposedKey: data['transposedKey'],
      transposedNumber: data['transposedNumber'],
    );
  }
}
 