import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/ModelProvider.dart';
// components
import '../components/arrowBack.dart';
import '../components/flexText.dart';
// import '../components/loader.dart';
import '../components/songCard.dart';
import '../components/button.dart';
import '../components/textField.dart';
// screens
import './songPage.dart';
import './searchYoutube.dart';
// services
import '../services/dbSongsQuery.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String searchText = '';
  List<Song> songs = [];
  int page = 0;
  DbSongsQuery dbSongQ = DbSongsQuery();

  void toSearchYoutubePage(text) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchYoutube(searched: text,))
    );
  }

  void getSongs() async {
    var _songs = await dbSongQ.getFirstFewSongs(page);

    setState(() {
      songs = _songs;
      page += 1;
    });
  }

  void searchSongs(text) async {
    var _songs = await dbSongQ.getSearchedSongs(text);
    setState(() {
      songs = _songs;
    });
  }

  @override
  void initState() {
    getSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ThemeData _theme = Theme.of(context);
    CirButton circleButton(Widget child, VoidCallback onPress) =>  CirButton(
      size: 20,
      onPress: onPress,
      child: child,
    );

    return Scaffold(
      backgroundColor: _theme.primaryColorLight,
      appBar: AppBar(
        title: Text('Added Songs'),
        backgroundColor: _theme.accentColor,
        centerTitle: true,
        leading:ArrowBack(),
        actions: [
          circleButton(
            Icon(Icons.add),
            () => toSearchYoutubePage('Amazing Grace')
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: SearchSongs(
                search: searchText, 
                toSearchYoutube: () => toSearchYoutubePage('Amazing Grace'),
                songs: songs,
              )
            ),
            TextFieldCop(
              margin: EdgeInsets.only(bottom: 20, top: 10),
              obscureText: false,
              onChange: searchSongs,
              radius: 0,
              hintText: 'Search Songs By Title',
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      )
    );
  }
}

class SearchSongs extends StatelessWidget {
  SearchSongs({ 
    @required this.search, 
    @required this.toSearchYoutube,
    @required this.songs,
  });

  final String search;
  final VoidCallback toSearchYoutube;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: songs.isEmpty ?
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlexText(
              text: 'No match found',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            RectButton(
              color: Theme.of(context).accentColor,
              onPress: toSearchYoutube, 
              child: Text(
                'Add New Song',
                style: TextStyle(fontSize: 18),
              )
            ),
          ],
        )
      ) 
      :
      ListView(
        scrollDirection: Axis.vertical,
        children: songs.map((song) {
          return Container(
            height: 190,
            child: RectButton(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(bottom: 10),
              raduis: 0,
              color: Theme.of(context).primaryColor,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongPage(
                      song: song,
                    )
                  )
                );
              }, 
              child: SongCard(
                song: song, 
                color: Colors.transparent, 
                margin: EdgeInsets.zero,
              )
            )
          );
        }).toList(),
      )
    );
  }
}
