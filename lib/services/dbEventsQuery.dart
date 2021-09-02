import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';
import '../models/Event.dart';
import '../models/Song.dart';
import '../services/dbSongsQuery.dart';
import 'package:uuid/uuid.dart';

class DbEventsQuery {
  StreamSubscription _subscription;
  int _now = DateTime.now().millisecondsSinceEpoch;
  final _streamController = StreamController<List<Event>>();
  Uuid _uuid = Uuid();
  User _user = User();

  Future<bool> addEvent(Map<String, dynamic> event) async {
    DbSongsQuery songQuery = DbSongsQuery();

    Event newEvent = Event(
      id: _uuid.v1(),
      createdAt: TemporalTimestamp.now(),
      name: event['name'],
      date: event['date'].toString(),
      dateStamp: event['date'],
      songIds: event['songIds'],
      bgCover: event['bgCover'],
      createdBy: _user.getUser.userId,
      creatorName: _user.getUserAttributes.name
    );

    try {
      for (var id in event['songIds']) {
        Song song = await songQuery.getOneSong(id);
        Song updatedSong = song.copyWith(
          lastDatePlayed: event['date'].toString());

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
    _getUpcomingEvent();
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
        where: Event.DATESTAMP.gt(_now)
      );
      _streamController.add(events);
    } catch (e) {
      print(e);
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
        where: Event.DATESTAMP.lt(_now)
      );
      return _events;
    } catch (e) {
      print(e);
      return [];
    }
  }
}