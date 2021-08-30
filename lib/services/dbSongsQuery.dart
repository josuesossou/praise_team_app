import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:lgcogpraiseteam/models/YoutubeDataModel.dart';
import 'package:uuid/uuid.dart';

import '../models/Song.dart';

class DbSongsQuery {
  final uuid = Uuid();
  final String collectionPath = 'songs';

  /// returns true if succeeded otherwise false
  Future<bool> addSong(VideoDetail video) async {
    Song newSong =  Song(
      songId: uuid.v1(),
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
      transposedKey: 'Not Set',
      transposedNumber: 0,
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
    try {
      List<Song> songs = await Amplify.DataStore.query(
        Song.classType,
        pagination: new QueryPagination(page:0, limit:25) 
      );

      return songs;
    } catch (e) {
      return [];
    }
  }

  Future<List<Song>> getSearchedSongs(String keyword) async {
    try {
      List<Song> songs = await Amplify.DataStore.query(
        Song.classType,
        where: Song.VIDEOTITLELOWERCASE.contains(keyword.toLowerCase())
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