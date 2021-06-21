import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lgcogpraiseteam/models/EventModel.dart';
import 'package:lgcogpraiseteam/services/dbSongsQuery.dart';

import './db.dart';

class DbEventsQuery {
  final FirebaseFirestore db = Db().db;
  final String collectionPath = 'events';

  Future<void> addEvent(EventModel event) async {
    DateTime date = DateTime.parse(event.date);

    Map<String, dynamic> eventData = {
      'id': event.id,
      'createdAt': Timestamp.now(),
      'name': event.name,
      'date': event.date,
      'dateStamp': Timestamp.fromDate(date),
      'songIds': event.songIds,
      'bgCover': event.bgCover
    };

    event.songIds.forEach((id) {
      DbSongsQuery().updateSong(id, {
        'lastDatePlayed': event.date
      });
    });

    return db.collection(collectionPath)
          .doc(event.id).set(eventData);
  }

  Stream<QuerySnapshot> getUpcomingEvent() {
    return db.collection(collectionPath)
    .orderBy('dateStamp', descending: false)
    .where('dateStamp', isGreaterThan: Timestamp.now())
    .snapshots();
  }
  
  Future<QuerySnapshot> getPreviousEvent() async {
    return db.collection(collectionPath)
    .orderBy('dateStamp', descending: true)
    .where('dateStamp', isLessThan: Timestamp.now())
    .limit(20)
    .get();
  }
}