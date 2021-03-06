import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../components/transposeCard.dart';
import '../models/ModelProvider.dart';
import '../components/flexText.dart';

class SharedSoundCard extends StatelessWidget {
  SharedSoundCard({ @required this.song, this.isEventPage = false });

  final Song song;
  final bool isEventPage;

  @override
  Widget build(BuildContext context) { 
    SizedBox columnSpacing = SizedBox(height: 10,);
    double mLeft = 5, mRight = 20;
    int titleLength = song.videoTitle.length;
    String missing = titleLength < 20 ? '' : '...';
    YoutubePlayerController _youtubeController = YoutubePlayerController(
      initialVideoId: song.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    PageController _pageController = PageController(
      initialPage: 0, viewportFraction: 0.5, keepPage: true
    );

    TextStyle style3 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );
    TextStyle style1 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
    ); 
    TextStyle style2 = TextStyle(
      fontSize: 18,
    ); 

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          song.reported ? 
            Container(
              height: 200,
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.report, size: 50, color: Colors.grey.shade400,),
                  Text(
                    'Song contained inappropriate content',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade400
                    ),
                  ),
                ],
              )
            ) : 
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
            ),
          columnSpacing,
          Row(
            children: [
              song.reported ? Container() : FlexText(
                margin: EdgeInsets.only(left: mLeft),
                text: isEventPage ?
                  song.videoTitle.substring(
                    0,
                    titleLength < 20 ? titleLength : 20
                  ) + missing
                  : song.videoTitle,
                style: style3,
              ),
            ]
          ),
          columnSpacing,
          Container(
            margin: EdgeInsets.only(left: mLeft, right: mRight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlexText(
                  text: 'Original Key:',
                  style: style1,
                ),
                FlexText(
                  text: song.originalkey,
                  style: style2,
                ),
              ]
            )
          ),

          columnSpacing,

          Container(
            margin: EdgeInsets.only(left: mLeft, right: mRight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlexText(
                  text: 'Last Played:',
                  style: style1,
                ),
                FlexText(
                  text: song.lastDatePlayed == 'New Song' ? 
                        song.lastDatePlayed :
                        DateFormat.yMMMd()
                        .format(
                          DateTime.fromMillisecondsSinceEpoch(
                            int.parse(song.lastDatePlayed)
                          )
                        ),
                  style: style2,
                ),
              ]
            )
          ),

          columnSpacing,

          isEventPage ?
            Container()
            : 
            Container(
              height: 100,
              margin: EdgeInsets.only(top: 20),
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: song.transposeList.map((tKeys) => TransposeCard(
                  transDataKey: tKeys,
                )).toList()
              ),
            )
        ]
      )
    );
  }
}