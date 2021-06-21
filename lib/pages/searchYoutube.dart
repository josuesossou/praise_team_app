import 'package:flutter/material.dart';
import '../components/arrowBack.dart';
import '../components/loader.dart';
import '../models/SongModel.dart';
import '../services/youtubeAPI.dart';
import '../components/button.dart';
import '../components/textField.dart';
import '../components/youtubeVideoCard.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/YoutubeDataModel.dart';
import '../services/dbSongsQuery.dart';
import 'package:uuid/uuid.dart';


class SearchYoutube extends StatefulWidget {
  SearchYoutube({ @required this.searched });

  final String searched;

  @override
  _SearchYoutubeState createState() => _SearchYoutubeState(searched);
}

class _SearchYoutubeState extends State<SearchYoutube> {
  _SearchYoutubeState(this.searchText);

  String searchText;
  bool textChanged = true;
  Future<YoutubeDataModel> _getSongs;

  void _getYoutubeData(search) { // makes querry to youtube api
    if (textChanged)
      setState(() {
        _getSongs = YoutubeApi(search).getYoutubeVideoData();
        textChanged = false;
      });
  }

  @override
  void initState() {
    super.initState();
    _getYoutubeData(searchText);
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
        leading: ArrowBack()
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: AddNewSongs( // displays the data from youtube api
                search: searchText,
                getYoutubeData: _getSongs,
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFieldCop(
                      obscureText: false,
                      onChange: (val) {
                        setState(() {
                          searchText = val;
                          textChanged = true;
                        });
                      },
                      radius: 0,
                      hintText: 'Search Songs By Title',
                      color: Theme.of(context).primaryColor,
                      margin: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(width: 10),
                  RectButton(
                    onPress: () => _getYoutubeData(searchText), 
                    child: Text('search'),
                    raduis: 1,
                    color: _theme.accentColor,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class AddNewSongs extends StatelessWidget {
  AddNewSongs({ @required this.search, this.getYoutubeData });

  final String search;
  final Future<YoutubeDataModel> getYoutubeData;

  void showBottomSheet(video, context) => showModalBottomSheet<void>(
    context: context,
    isDismissible: true,
    enableDrag: true,
    builder: (BuildContext context) {
      return BottomModelContent(video: video,);
    },
  );

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder(
        future: getYoutubeData,
        builder: (BuildContext context, AsyncSnapshot<YoutubeDataModel> snapshot) {
          Widget child;

          if (snapshot.hasData) {
            child = ListView(
              children: snapshot.data.items.map((video) => 
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: RectButton(
                    padding: EdgeInsets.zero,
                    raduis: 0,
                    color: Theme.of(context).primaryColor,
                    onPress: () {
                      showBottomSheet(video, context);
                    }, 
                    child: YoutubeVideoCard(
                      video: video,
                      color: Colors.transparent,
                      margin: EdgeInsets.zero,
                    )
                  )
                )
              ).toList(),
            );
          } else if (snapshot.hasError) {
            child = Center(
              child: Text('Error Occured: ${snapshot.error}'),
            );
          } else {
            child = Loader();
          }

          return child;
        }
      )
    );
  }
}


class BottomModelContent extends StatelessWidget {
  BottomModelContent({ this.video });

  final VideoDetail video;
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: video.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    ThemeData _theme = Theme.of(context);
    TextStyle style = TextStyle(
      fontSize: 18,
      
    );
    TextStyle style2 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
    );
    return Container(
      child: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              video.title, 
              textAlign: TextAlign.center, 
              style: style2,
            )
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RectButton(
                color: _theme.accentColor,
                child: Text('Add Song', style: style,),
                onPress: () {
                  SongModel song = SongModel(
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
                  );
                  DbSongsQuery().addSong(song)
                  .then((val) => Navigator.pop(context));
                },
              ),
              RectButton(
                color: _theme.primaryColorDark,
                child: Text('Cancel', style: style,),
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ]
          )
        ],
      ),
    );
  }
}


// videoProgressIndicatorColor: Colors.amber,
// progressColors: ProgressColors(
//     playedColor: Colors.amber,
//     handleColor: Colors.amberAccent,
// ),
// onReady() {
//     _controller.addListener(listener);
// },
// onReady: () {
  // _controller.addListener()
// },