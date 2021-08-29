import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import '../models/Event.dart';
import '../models/Song.dart';
import '../services/dbSongsQuery.dart';

class DbEventsQuery {
  StreamSubscription _subscription;
  TemporalDateTime  now = TemporalDateTime.now();
  final _streamController = StreamController<List<Event>>();

  Future<bool> addEvent(Event event) async {
    DbSongsQuery songQuery = DbSongsQuery();

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

  // subscription to amplify events data, 
  //watches if new events are in the store
  void setSubscription() {
    _subscription =  Amplify.DataStore
    .observe(Event.classType)
    .listen((event) {
      _getUpcomingEvent();
    });
  }

  // canceling amplify stream
  void cancelSubscription() {
    _subscription.cancel();
    _streamController.close();
  }

  // Queries the events from the amplify dbstore
  void _getUpcomingEvent() async {
    try {
      List<Event> events = await Amplify.DataStore.query(
        Event.classType, 
        where: Event.DATESTAMP.gt(now)
      );

      _streamController.sink.add(events);
    } catch (e) {
    }
  }

  // Actual stream to be used by the UI
  Stream<List<Event>> get getUpcomingEvent {
    return _streamController.stream;
  } 

  Future<List<Event>> getPreviousEvent() async {
    try {
      List<Event> _events = await Amplify.DataStore.query(
        Event.classType, 
        where: Event.DATESTAMP.lt(now)
      );
      return _events;
    } catch (e) {
      return [];
    }
  }
}