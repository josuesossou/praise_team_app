import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:lgcogpraiseteam/models/TransposeData.dart';
import 'package:lgcogpraiseteam/models/YoutubeDataModel.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';
import 'package:uuid/uuid.dart';

import '../models/Song.dart';

class DbSongsQuery {
  final _uuid = Uuid();
  final String collectionPath = 'songs';
  final _user = User();

  /// returns true if succeeded otherwise false
  Future<bool> addSong(VideoDetail video) async {
    var _getAttributes = await _user.getUserAttributes();

    Song newSong =  Song(
      songId: _uuid.v1(),
      etag: video.etag,
      videoTitle: video.title,
      videoTitleLowercase: video.title.toLowerCase(),
      videoId: video.videoId,
      videoDescription: video.description,
      videoThumDefaultH: video.thumbNail.defaultH,
      videoThumbDefaultW: video.thumbNail.defaultW,
      videoThumbDefaultUrl: video.thumbNail.defaultUrl,
      videoThumbMediumH: video.thumbNail.mediumH,
      videoThumbMediumUrl: video.thumbNail.mediumUrl,
      videoThumbMediumW: video.thumbNail.mediumW,
      channelTitle: video.channelTitle,
      channelId: video.channelId,
      createdAt: TemporalTimestamp.now(),
      musicSheets: [],
      lastDatePlayed: 'New Song',
      numOfTimePlayed: 0,
      originalkey: 'Not Set',
      transposeList: [],
      reported: false,
      orgId: _getAttributes.orgId
    );

    try {
      // check if the video has already been add using the video id
      List<Song> songList = await Amplify.DataStore.query(
        Song.classType, where: Song.VIDEOID.eq(video.videoId));

      if (songList.isEmpty) {
        await Amplify.DataStore.save(newSong);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateSong(Song uptadedSong) async {
    try {
      await Amplify.DataStore.save(uptadedSong);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Song>> getFirstFewSongs(int pageNumber) async {
    var _getAttributes = await _user.getUserAttributes();
    try {
      List<Song> songs = await Amplify.DataStore.query(
        Song.classType,
        where: Song.ORGID.eq(_getAttributes.orgId),
        pagination: new QueryPagination(page:0, limit:25) 
      );

      return songs;
    } catch (e) {
      return [];
    }
  }

  Future<List<Song>> getSearchedSongs(String keyword) async {
    var _getAttributes = await _user.getUserAttributes();
    try {
      List<Song> songs = await Amplify.DataStore.query(
        Song.classType,
        where: Song.VIDEOTITLELOWERCASE.contains(keyword.toLowerCase())
                    .and(Song.ORGID.eq(_getAttributes.orgId))
      );  

      return songs;
    } catch (e) {
      return [];
    }
  }

  Future<Song> getOneSong(String id) async {
    try {
      List<Song> songs = await Amplify.DataStore.query(
        Song.classType,
        where: Song.SONGID.eq(id)
      );

      return songs[0];
    } catch (e) {
      return null;
    }
  }
}


class TransposeQuery {
  /// returns true if succeeded otherwise false
  Future<String> addTransposeKey(Map<String, dynamic> updateData) async {
    var _userId = updateData['userId'];
    var _returnVal;
    TransposeData _newTranData;

    try {
      List<TransposeData> tlData = await Amplify.DataStore.query(
        TransposeData.classType,
        where: TransposeData.USERID.eq(_userId)
      );

      if (tlData.isEmpty) {
        _newTranData = TransposeData(
          transposeId: updateData['id'],
          transposeKey: updateData['transposeKey'],
          transposeNum: updateData['transposeNum'],
          userName: updateData['userName'],
          songId: updateData['songId'],
          userId: _userId
        );
        _returnVal = "NEW";
      } else {
        _newTranData = tlData[0].copyWith(
          transposeKey: updateData['transposeKey'],
          transposeNum: updateData['transposeNum'],
        );
        _returnVal = "UPDATE";
      }
      await Amplify.DataStore.save(_newTranData);
      return _returnVal;
    } catch (e) {
      return "ERROR";
    }
  }

  Future<TransposeData> getOne(String tKeyId) async {
    try {
      List<TransposeData> transposeKeys = await Amplify.DataStore.query(
        TransposeData.classType,
        where: TransposeData.TRANSPOSEID.eq(tKeyId),
      );
      return transposeKeys[0];
    } catch (e) {
      return null;
    }
  }

  Future<List<TransposeData>> getMany(songId) async {
    try {
      List<TransposeData> transposeKeys = await Amplify.DataStore.query(
        TransposeData.classType,
        where: TransposeData.TRANSPOSEID.eq(songId),
      );
      return transposeKeys;
    } catch (e) {
      return [];
    }
  }

  Future<bool> remove(TransposeData transData) async {
    try {
      await Amplify.DataStore.delete(transData);
      return true;
    } catch (e) {
      return false;
    }
  }
}
