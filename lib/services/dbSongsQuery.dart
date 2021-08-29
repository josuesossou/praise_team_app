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
      createdAt: TemporalTimestamp.now()
    );

    // check if the video has already been add using the video id
    List<Song> songList = await Amplify.DataStore.query(
      Song.classType, where: Song.VIDEOID.eq(video.videoId));
    
    if (songList.isEmpty) {
      await Amplify.DataStore.save(newSong);
      return true;
    }

    return false;
  }

  Future<bool> updateSong(String id, Map<String, dynamic> data) {
    return db.collection(collectionPath)
      .doc(id).update(data);
  }

  Future<QuerySnapshot> getFirstFewSongs() {
    return db.collection(collectionPath)
    .orderBy('createdAt', descending: true)
    .limit(25)
    .get();
  }

  Future<QuerySnapshot> getSearchedSongs(keyword) {
    return db.collection(collectionPath)
    .limit(10)
    .where('videoTitleLowercase', isGreaterThanOrEqualTo: keyword, isLessThanOrEqualTo: keyword +'\uf8ff')
    .get();
  }

  Future<DocumentSnapshot> getOneSong(String id) {
    return db.collection(collectionPath)
    .doc(id).get();
  }
}