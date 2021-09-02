import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../components/transposeCard.dart';
import '../models/ModelProvider.dart';
import '../components/flexText.dart';

class SharedSoundCard extends StatelessWidget {
  SharedSoundCard({ @required this.song });

  final Song song;

  @override
  Widget build(BuildContext context) { 
    SizedBox columnSpacing = SizedBox(height: 10,);
    double mLeft = 5, mRight = 20;
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
      fontSize: 25,
      fontWeight: FontWeight.bold
    );
    TextStyle style1 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    ); 
    TextStyle style2 = TextStyle(
      fontSize: 20,
    ); 

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
          ),
          columnSpacing,
          Row(
            children: [
              FlexText(
                margin: EdgeInsets.only(left: mLeft),
                text: song.videoTitle,
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
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: song.transposeList.map((data) => TransposeCard(
              data: data,
            )).toList()
          ),
          
        ]
      )
    );
  }
}