import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/button.dart';


class TestYoutubePlayer extends StatefulWidget {
  @override
  _TestYoutubePlayerState createState() => _TestYoutubePlayerState();
}

class _TestYoutubePlayerState extends State<TestYoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
   
      child: RectButton(
        onPress: () {
          // YoutubeApi().testYoutubeApi();
        },
        child: Text('my youtube')
      ),
    );
  }
}