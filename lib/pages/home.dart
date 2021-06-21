import 'package:flutter/material.dart';
// import 'package:lgcogpraiseteam/pages/calendarEvents.dart';
import './events.dart';

class Home extends StatefulWidget {
  Home({ Key key, this.controller });

  final PageController controller;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: widget.controller,
      children: [
        // Center(
        //   child: TestYoutubePlayer()
        // ),
        Events(
          events: []
        ),
        // Center(
        //   child: Text('Third Page'),
        // )
      ],
    );
  }
}