import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/flexText.dart';
import '../models/Song.dart';

class SongCard extends StatelessWidget {
  SongCard({
    @required this.song,
    @required this.color,
    this.margin = const EdgeInsets.only(bottom: 30),
  });

  final Song song;
  final Color color;
  final EdgeInsets margin;

  final TextStyle style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  final TextStyle style2 = TextStyle(
    fontSize: 18, 
    fontWeight: FontWeight.bold,
  );

  final Container lineSeparator = Container(
    height: 1,
    color: Colors.black12,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int titleLength = song.videoTitle.length;
    String missing = titleLength < 60 ? '' : '...';

    return Container(
      color: color,
      padding: EdgeInsets.all(10),
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.3,
                margin: EdgeInsets.only(right: 10,),
                child: Image(
                  image: NetworkImage(song.videoThumbDefaultUrl),
                  fit: BoxFit.cover,
                ),
              ),
              FlexText(
                text: song.videoTitle.substring(
                  0,
                  titleLength < 60 ? titleLength :60
                ) + missing,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: song.reported? Colors.grey.shade400 : Colors.black
                )
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexText(
                text: 'Original Key:',
                style: style2,
              ),
              FlexText(
                text: song.originalkey,
                style: style2,
              ),
            ],
          ),
          
          lineSeparator,
          SizedBox(height: 5),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexText(
                text: 'Date Played:',
                style: style2,
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
            ],
          ),
        ],
      ),
    );
  }
}