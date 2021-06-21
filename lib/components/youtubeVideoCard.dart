import 'package:flutter/material.dart';
import '../models/YoutubeDataModel.dart';

class YoutubeVideoCard extends StatelessWidget {
  YoutubeVideoCard({ 
    @required this.video,
    @required this.color,
    this.margin = const EdgeInsets.only(bottom: 30),
  });

  final VideoDetail video;
  final Color color;
  final EdgeInsets margin;

  final TextStyle style = TextStyle(
    fontSize: 20, 
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: EdgeInsets.all(10),
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 10,),
                child: Image(
                  image: NetworkImage(video.thumbNail.defaultUrl),
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Text(
                  video.title, // from youtube api
                  style: style
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}