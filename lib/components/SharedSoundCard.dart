import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/flexText.dart';
import 'package:lgcogpraiseteam/models/SongModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SharedSoundCard extends StatelessWidget {
  SharedSoundCard({ @required this.song });

  final SongModel song;

  @override
  Widget build(BuildContext context) { 
    SizedBox columnSpacing = SizedBox(height: 10,);
    SizedBox rowSpacing = SizedBox(width: 15,);
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: song.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
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
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          columnSpacing,
          Row(
            children: [
              rowSpacing,
              FlexText(
                text: song.videoTitle,
                style: style3,
              ),
            ]
          ),
          columnSpacing,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
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
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlexText(
                  text: 'Transpose:',
                  style: style1,
                ),
                FlexText(
                  text: song.transposedNumber.toString(),
                  style: style2,
                ),
              ]
            ),
          ),
          columnSpacing,

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlexText(
                  text: 'Transposed Key:',
                  style: style1,
                ),
                FlexText(
                  text: song.transposedKey,
                  style: style2,
                ),
              ]
            ),
          ),
          columnSpacing,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlexText(
                  text: 'Last Played:',
                  style: style1,
                ),
                FlexText(
                  text: song.lastDatePlayed,
                  style: style2,
                ),
              ]
            )
          ),
        ]
      )
    );
  }
}