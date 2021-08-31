import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgcogpraiseteam/models/ModelProvider.dart';
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
  TextStyle style1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  TextStyle style2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal
  );

  void _onShare(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    Share.share(
      'check out my website https://google.com',
      subject: 'hello',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    );
  }

  @override
  Widget build(BuildContext context) {
    int numSong = widget.event.songIds.length;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight, 
      appBar: AppBar(
        leading: ArrowBack(),
        actions: [
          CirButton(
            child: Icon(Icons.share_outlined, size: 25,),
            size: 50,
            onPress: () {
              _onShare(context);
            },
          )
        ],
        elevation: 0,
        title: Text(widget.event.name),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.13,
              child: Column(
                children: [
                  FlexText(
                    text: '${widget.type}'.toUpperCase(),
                    style: style1,
                  ),
                  FlexText(
                    text: DateFormat.yMMMd().format(
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(widget.event.date)
                      )
                    ),
                    style: style2,
                  ),
                  SizedBox(height: 10),
                  FlexText(
                    text: '$numSong ${numSong > 1 ? 'Songs' : 'Song'} ',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              )
            ),

            Expanded(
              flex: 10,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: widget.event.songIds.map((songId) => (
                  FutureBuilder(
                    future: DbSongsQuery().getOneSong(songId),
                    builder: (BuildContext build, 
                          AsyncSnapshot<Song> snapshot) {
                      Widget child;

                      if (snapshot.hasData) {
                        Song song = snapshot.data;

                        child = Container(
                          child: Column(
                            children: [
                              SharedSoundCard(song: song),
                              SizedBox(height: 20),
                              RectButton(
                                onPress: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => 
                                    SongPage(song: song,))
                                  );
                                },
                                width: size.width * 0.65,
                                color: Theme.of(context).accentColor,
                                child: Row(children: [
                                  FlexText(
                                    alignment: Alignment.center,
                                    text: 'View More Details',
                                    style: TextStyle(fontSize: 18),
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
                        child = Loader();
                      }

                      return child;
                    }
                  )
                )).toList(),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}