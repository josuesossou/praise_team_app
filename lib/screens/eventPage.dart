import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgcogpraiseteam/models/ModelProvider.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';
import 'package:share_plus/share_plus.dart';
import '../components/SharedSoundCard.dart';
import '../components/arrowBack.dart';
import '../components/button.dart';
import '../components/flexText.dart';
import '../components/loader.dart';
import '../screens/songPage.dart';
import '../services/dbSongsQuery.dart';
import '../models/Event.dart';

class EventPage extends StatefulWidget {
  EventPage({ @required this.event, @required this.type });

  final Event event;
  final String type;

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DbSongsQuery _dbQuery = DbSongsQuery();
  PageController _controller = PageController(
    initialPage: 0, viewportFraction: 0.9, keepPage: true
  );
  User user = User();
  List<Map<String, String>> shareItems = [];
  String _shareItem;

  TextStyle style1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  TextStyle style2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal
  );
    TextStyle style3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal
  );

  void _onShare(BuildContext context, List<String> songIds, date) async {
    final box = context.findRenderObject() as RenderBox;
    String _shareItem = "Here are the songs for $date\n\n";

    for (var id in songIds) {
      Song song = await _dbQuery.getOneSong(id);

      _shareItem += "${song.videoTitle}" + 
      "\nhttps://youtu.be/${song.videoId}\n\n";
    }

    Share.share(
      _shareItem,
      subject: 'hello',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    );
  }

  @override
  Widget build(BuildContext context) {
    int _numSong = widget.event.songIds.length;
    Size _size = MediaQuery.of(context).size;
    Event _event = widget.event;
    ThemeData _theme = Theme.of(context);
    
    String _date = DateFormat.yMMMd().format(
      DateTime.fromMillisecondsSinceEpoch(
        int.parse(_event.date)
      )
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight, 
      appBar: AppBar(
        leading: ArrowBack(),
        actions: [
          CirButton(
            child: Icon(Icons.delete, size: 25,),
            size: 50,
            onPress: () {
              // _onShare(context, _shareItem);
            },
          )
        ],
        elevation: 0,
        title: Text(widget.event.name),
        centerTitle: true,
        backgroundColor: _theme.accentColor,
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: _theme.accentColor,
          padding: EdgeInsets.all(20)
        ),
        child: Icon(Icons.share, size: 30,),
        onPressed: () {
          _onShare(context, widget.event.songIds, _date);
        },
      ),
      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.90 * _size.height,
        ),
        child: Column(
          children: [
            Container(
              height: _size.height * 0.16,
              child: Column(
                children: [
                  FlexText(
                    text: '${widget.type}'.toUpperCase(),
                    style: style1,
                  ),
                  FlexText(
                    text: _date,
                    style: style2,
                  ),
                  SizedBox(height: 5),
                  FlexText(
                    text: 'Posted By ' + _event.creatorName.toUpperCase(),
                    style: style3,
                  ),
                  FlexText(
                    text: '$_numSong ${_numSong > 1 ? 'Songs' : 'Song'} ',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              )
            ),

            Container(
              height: _size.height *0.60,
              child:  PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: widget.event.songIds.map((songId) => (
                  FutureBuilder(
                    future: _dbQuery.getOneSong(songId),
                    builder: (BuildContext build, 
                          AsyncSnapshot<Song> snapshot) {
                      Widget child;

                      if (snapshot.hasData) {
                        Song song = snapshot.data;


                        child = Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              SharedSoundCard(song: song, isEventPage: true,),
                              SizedBox(height: 20),
                              RectButton(
                                margin: EdgeInsets.zero,
                                onPress: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => 
                                    SongPage(song: song,))
                                  );
                                },
                                width: _size.width * 0.40,
                                color: _theme.primaryColorDark,
                                child: Row(children: [
                                  FlexText(
                                    alignment: Alignment.center,
                                    text: 'More',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],)
                              )
                            ],
                          )
                        );
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
                        child = Loader(color: _theme.accentColor,);
                      }
                      return child;
                    }
                  )
                )).toList(),
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
      )
    );
  }
}