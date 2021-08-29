import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import '../models/Event.dart';
import '../models/Song.dart';
import '../services/dbSongsQuery.dart';

class DbEventsQuery {
  Future<bool> addEvent(Event event) async {
    int date = DateTime.parse(event.date).second;
    DbSongsQuery songQuery = DbSongsQuery();
    StreamSubscription _subscription;    

    Event newEvent = Event(
      id: event.id,
      createdAt: TemporalTimestamp.now(),
      name: event.name,
      date: event.date,
      dateStamp: TemporalDateTime.fromString(event.date),
      songIds: event.songIds,
      bgCover: event.bgCover
    );

    try {
      for (var id in event.songIds) {
        Song song = await songQuery.getOneSong(id);
        Song updatedSong = song.copyWith(lastDatePlayed: event.date);

        await songQuery.updateSong(updatedSong);
      }

      await Amplify.DataStore.save(newEvent);
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getUpcomingEvent() {

    // return db.collection(collectionPath)
    // .orderBy('dateStamp', descending: false)
    // .where('dateStamp', isGreaterThan: Timestamp.now())
    // .snapshots();
  }
  
  Future<QuerySnapshot> getPreviousEvent() async {
    try {
      await Amplify.DataStore.query(
        Event.classType, 
        where: Event.
      )
    } catch (e) {
    }
  }
}