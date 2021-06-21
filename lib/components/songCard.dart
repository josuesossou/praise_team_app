import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/flexText.dart';
import '../models/SongModel.dart';

class SongCard extends StatelessWidget {
  SongCard({
    @required this.song,
    @required this.color,
    this.margin = const EdgeInsets.only(bottom: 30),
  });

  final SongModel song;
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                text: song.videoTitle, // from youtube api
                style: style
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
          Container(
            height: 1,
            color: Colors.black12,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexText(
                text: 'Transposed: ' + song.transposedNumber.toString(),
                style: style2,
              ),
              FlexText(
                text: 'Key: ' + song.transposedKey,
                style: style2,
              ),
            ],
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexText(
                text: 'Last Date Played:',
                style: style2,
              ),
              FlexText(
                text: song.lastDatePlayed,
                style: style2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}