import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
import '../components/arrowBack.dart';
import '../components/loader.dart';
import '../services/dbEventsQuery.dart';
import '../components/button.dart';
import '../components/songCard.dart';
import '../components/textField.dart';
import '../models/Song.dart';
import '../services/dbSongsQuery.dart';
import '../components/flexText.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime selectedDate;
  List<Song> _songs = [];
  String searchText = ''; 
  String nameText = '';
  bool showSearchResult = false;
  DbEventsQuery eventsQuery = DbEventsQuery();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2045),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    print("@@@@@@@@ data !!@@@@@!@");
    print(selectedDate);
    print(picked.add(const Duration(hours: 20)));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked.add(const Duration(hours: 20));
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
    List<Song> newSongs = _songs;
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

  _addEvent(context) {
    List<String> songIdList = _songs.map((song) => song.songId).toList();

    if (songIdList.isEmpty) {
      showError(context, 'Need to add at least one song');
    } else if (selectedDate == null) {
      showError(context, 'Need to set Event Date');
    } else {
      var event = {
        'name': nameText,
        'songIds': songIdList,
        'bgCover': _songs[0].videoThumbDefaultUrl,
        'date': selectedDate.millisecondsSinceEpoch
      };

      eventsQuery.addEvent(event)
        .then((isSuccess) {
          Navigator.pop(context);

          if (isSuccess) {
            showSuccess(context, 'Added a New Event Successfully');
          } else {
            showError(context, 'Failed to add new event');
          }   
        }
      );
    }
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
            margin: EdgeInsets.only(bottom: 20),
            child: RectButton(
              onPress: () {
                _addEvent(context);
              },
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
  final List<Song> songs;
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
                  Text('Event Date:', 
                    style: TextStyle(fontSize: 18, 
                    fontWeight: FontWeight.normal),
                  ),
                  _sizedBox,
                  Text(
                    selectedDate == null ? '' :
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
              height: 190,
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

  Future<List<Song>> searchedSongs() => DbSongsQuery()
                        .getSearchedSongs(keyword);

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
      height: 200,
      child: FutureBuilder(
        future: searchedSongs(),
        builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
        Widget child;
        
        if (snapshot.hasData) {
          List<Song> songs = snapshot.data;

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
              children: songs.map((song) =>  RectButton(
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
                )
              ).toList(),
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