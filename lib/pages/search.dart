import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/arrowBack.dart';
import 'package:lgcogpraiseteam/components/flexText.dart';
import 'package:lgcogpraiseteam/components/loader.dart';
import 'package:lgcogpraiseteam/components/songCard.dart';
import 'package:lgcogpraiseteam/models/SongModel.dart';
import 'package:lgcogpraiseteam/pages/searchYoutube.dart';
import 'package:lgcogpraiseteam/services/dbSongsQuery.dart';

import './songPage.dart';
import '../components/button.dart';
import '../components/textField.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String searchText = '';
  List<QueryDocumentSnapshot> songs = [];
  DbSongsQuery dbSongQ = DbSongsQuery();

  void toSearchYoutubePage(text) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchYoutube(searched: text,))
    );
  }

  @override
  void initState() {
    dbSongQ.getFirstFewSongs().then((snapshot) => {
      setState(() {
        songs = snapshot.docs;
      })
    });

    super.initState();
  }

  onSearchTextChanged(text) {
    dbSongQ.getSearchedSongs(text).then((snapshot) => {
      setState(() {
        songs = snapshot.docs;
        searchText = text;
      })
    });
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
                toSearchYoutube: () => toSearchYoutubePage(searchText),
                songs: songs,
              )
            ),
            TextFieldCop(
              margin: EdgeInsets.only(bottom: 20, top: 10),
              obscureText: false,
              onChange: onSearchTextChanged,
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
  final List<QueryDocumentSnapshot> songs;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: songs.length == 0 ?
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
        children: songs.map((s) {
          SongModel song = SongModel.fromMap(s.data());

          return Container(
            height: 210,
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

// class BottomModelContent extends StatelessWidget {
//   BottomModelContent({ this.song });

//   final SongModel song;

//   @override
//   Widget build(BuildContext context) {
//     YoutubePlayerController _controller = YoutubePlayerController(
//       initialVideoId: song.videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//     ThemeData _theme = Theme.of(context);
//     TextStyle style = TextStyle(
//       fontSize: 18,
      
//     );
//     TextStyle style2 = TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.bold
//     );
//     return Container(
//       child: Column(
//         children: [
//           YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//           ),
//           SizedBox(height: 10),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Title: ${song.videoTitle}',
//                   textAlign: TextAlign.start, 
//                   style: style2,
//                 ),
//                 Text(
//                   'Channel: ${song.channelTitle}', 
//                   textAlign: TextAlign.start, 
//                   style: style2,
//                 ),
//                 Text(
//                   'Original Key: ${song.originalkey}', 
//                   textAlign: TextAlign.start, 
//                   style: style2,
//                 ),
//                 Text(
//                   'transposed: ${song.transposedNumber}', 
//                   textAlign: TextAlign.start, 
//                   style: style2,
//                 ),
//                 Text(
//                   'Transposed Key: ${song.transposedKey}', 
//                   textAlign: TextAlign.start, 
//                   style: style2,
//                 ),
//               ],
//             )
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
