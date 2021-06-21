import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/arrowBack.dart';
import '../components/loader.dart';
import '../services/dbEventsQuery.dart';
import 'package:uuid/uuid.dart';

import '../components/button.dart';
import '../components/songCard.dart';
import '../components/textField.dart';
import '../models/EventModel.dart';
import '../models/SongModel.dart';
import '../services/dbSongsQuery.dart';
import '../components/flexText.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime selectedDate = DateTime.now();
  List<SongModel> _songs = [];
  String searchText = ''; 
  String nameText = '';
  bool showSearchResult = false;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2045),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _onChangedSearchSongText(val) {
    setState(() {
      if (searchText != val) {
        showSearchResult = true;
      }
      searchText = val;
    });
  }
  _onChangedNameText(val) {
    setState(() {
      nameText = val;
    });
  }

  _addNewSong(song) {
    List<SongModel> newSongs = _songs;
    bool exist = false;

    _songs.forEach((s) {
      if (s.songId == song.songId) exist = true;
    });
    
    if (!exist) {
      newSongs.add(song);
    }
    
    setState(() {
      _songs = newSongs;
      showSearchResult = false;
    });
  }

  _closeSearchResult() {
    setState(() => {
      showSearchResult = false
    });
  }

  _addEvent() {
    Uuid uuid = Uuid();
    List<String> songIdList = _songs.map((song) => song.songId).toList();

    EventModel event = EventModel(
      id: uuid.v1(),
      date: selectedDate.toString(),
      name: nameText,
      songIds: songIdList,
      bgCover: _songs[0].videoThumbDefaultUrl
    );

    DbEventsQuery().addEvent(event);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.primaryColorLight,
      appBar: AppBar(
        title: Text('Add Event'),
        backgroundColor: _theme.accentColor,
        centerTitle: true,
        elevation: 0,
        leading: ArrowBack(),
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            child: AddEventComponent(
              selectDate: () => _selectDate(context),
              selectedDate: selectedDate,
              songs: _songs,
              theme: _theme,
              onChangedSearchText: (val) {
                _onChangedSearchSongText(val);
              },
              onChangedName: (val) {
                _onChangedNameText(val);
              },
            )
          ),
          showSearchResult ? SearchedSongLists(
            keyword: searchText.toLowerCase(),
            theme: _theme,
            closeSearchResult: () => _closeSearchResult(), 
            addNewSong: _addNewSong,
          ) : Container(),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 10),
            child: RectButton(
              onPress: () => _addEvent(),
              elevation: 5,
              color: _theme.accentColor,
              child: Container(
                height: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlexText(
                      text: 'Add New Event',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    )
                  ]
                )
              )
            ),
          ),
        ],
      )
    );
  }
}

class AddEventComponent extends StatelessWidget {
  AddEventComponent({ 
    @required this.theme, 
    @required this.selectedDate, 
    @required this.selectDate, 
    @required this.songs,
    @required this.onChangedSearchText,
    @required this.onChangedName
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final VoidCallback selectDate;
  final List<SongModel> songs;
  final Function onChangedSearchText;
  final Function onChangedName;

  @override
  Widget build(BuildContext context) {
    SizedBox _sizedBox = SizedBox(height: 30,width: 30,);
    BorderSide _border = BorderSide(width: 2, color: theme.primaryColorDark);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.80 * size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldCop(
              margin: EdgeInsets.all(0),
              obscureText: false,
              onChange: onChangedName,
              radius: 0,
              hintText: 'Enter Event Name',
              color: Theme.of(context).primaryColor,
              border: _border
            ),
            _sizedBox,
            RectButton(
              onPress: () => selectDate(),
              raduis: 0,
              elevation: 2,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Event Date:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                  _sizedBox,
                  Text(
                    DateFormat.yMMMd().format(selectedDate).toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]
              ),
            ),
            _sizedBox,
            TextFieldCop(
              margin: EdgeInsets.all(0),
              obscureText: false,
              onChange: onChangedSearchText,
              radius: 0,
              hintText: 'Search a Song',
              color: Theme.of(context).primaryColor,
              border: _border
            ),
            _sizedBox,
          ] + songs.map((song) => (
            Container(
              color: theme.primaryColor,
              height: 200,
              margin: EdgeInsets.only(bottom: 10),
              child: SongCard(
                song: song,
                color: theme.primaryColor,
                margin: EdgeInsets.zero,
              ),
            )
          )).toList(),
        )
      ),
    );
  }
}


/// for the search results that shows up on top
class SearchedSongLists extends StatelessWidget {
  SearchedSongLists({ 
    this.keyword, this.theme, this.closeSearchResult,
    @required this.addNewSong
  });

  final String keyword;
  final ThemeData theme;
  final Function closeSearchResult;
  final Function addNewSong;

  Future<QuerySnapshot> searchedSongs() => DbSongsQuery().getSearchedSongs(keyword);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 7,
            color: Colors.black45,
          )
        ]
      ),
      height: 215,
      child: FutureBuilder(
        future: searchedSongs(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget child;
        
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> songs = snapshot.data.docs;

          if (songs.isEmpty) {
            child = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ 
                FlexText(
                  alignment: Alignment.center,
                  text: 'No match found',
                  style: TextStyle()
                )
              ]
            );
          } else {
            child = ListView(
              clipBehavior: Clip.hardEdge,
              scrollDirection: Axis.horizontal,
              children: songs.map((s) { 
                SongModel song = SongModel.fromMap(s.data());

                return RectButton(
                  padding: EdgeInsets.zero,
                  raduis: 0,
                  color: theme.primaryColor,
                  width: size.width * 0.9,
                  onPress: () => addNewSong(song),
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: SongCard(
                    song: song,
                    color: Colors.transparent,
                    margin: EdgeInsets.zero,
                  )
                );
              }).toList(),
            );
          }
        } else if (snapshot.hasError) {
          child = Container(
            child: Column(
              children: [
                FlexText(
                  alignment: Alignment.center,
                  text: 'an error occured',
                )
              ]
            )
          );
        } else {
          child = Loader();
        }

        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            child,
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(10),
              child: CirButton(
                child: Center(
                  child: Icon(Icons.close),
                ),
                size: 20,
                onPress: closeSearchResult,
                color: theme.primaryColorLight,
                elevation: 3,
                padding: EdgeInsets.zero,
                padding2: EdgeInsets.zero,
              )
            )
          ],
        );
      })
    );
  }
}