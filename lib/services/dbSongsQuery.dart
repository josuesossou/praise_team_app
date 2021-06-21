import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lgcogpraiseteam/models/SongModel.dart';
import './db.dart';

class DbSongsQuery {
  final FirebaseFirestore db = Db().db;
  final String collectionPath = 'songs';

  Future<void> addSong(SongModel song) async {
    Map<String, dynamic> songData = {
      'songId': song.songId,
      'etag': song.etag,
      'videoTitle': song.videoTitle,
      'videoTitleLowercase': song.videoTitleLowercase,
      'videoId': song.videoId,
      'videoDescription': song.videoDescription,
      'videoThumDefaultH': song.videoThumDefaultH,
      'videoThumbDefaultW': song.videoThumbDefaultW,
      'videoThumbDefaultUrl': song.videoThumbDefaultUrl,
      'videoThumbMediumH': song.videoThumbMediumH,
      'videoThumbMediumUrl': song.videoThumbMediumUrl,
      'videoThumbMediumW': song.videoThumbMediumW,
      'channelTitle': song.channelTitle,
      'channelId': song.channelId,
      'lastDatePlayed': song.lastDatePlayed,
      'musicSheets': song.musicSheets,
      'createdAt': Timestamp.now(),
      'originalkey': song.originalkey,
      'numOfTimePlayed': song.numOfTimePlayed,
      'transposedKey': song.transposedKey,
      'transposedNumber': song.transposedNumber,
    };

    QuerySnapshot check = await db.collection(collectionPath)
                      .where('videoId', isEqualTo: song.videoId)
                      .get();

    if (check.docs.isEmpty) {
      return db.collection(collectionPath)
            .doc(song.songId).set(songData);
    }
  }

  Future<void> updateSong(String id, Map<String, dynamic> data) {
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