import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgcogpraiseteam/components/flexText.dart';
import 'package:lgcogpraiseteam/models/EventModel.dart';
import 'package:lgcogpraiseteam/pages/eventPage.dart';
import './button.dart';

class EventCard extends StatelessWidget {
  EventCard({ 
    @required this.event, 
    this.height, 
    this.margin , 
    this.isLargeCard = false,
    @required this.type,
  });

  final double height;
  final EdgeInsets margin;
  final EventModel event; 
  final bool isLargeCard;
  final String type;

  @override
  Widget build(BuildContext context) {
    TextStyle style1 =  TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.white
    );
    TextStyle style2 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: Colors.white
    );
    TextStyle style3 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white
    );
    SizedBox sizedBox = SizedBox(height: 10,);

    return Container(
      height: height,
      margin: margin,
      child: RectButton(
        color: Theme.of(context).primaryColorDark,
        padding: EdgeInsets.zero,
        onPress: () {
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventPage(
                event: event,
                type: type,
              )
            )
          );
        },
        elevation: 0,
        width:  MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [ 
            Container(
              child: Image(
                image: NetworkImage(event.bgCover),
                fit: BoxFit.cover,
              )            
            ),
            // overlay on top of image
            Container(
              color: Color(0xaa000000),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlexText(
                  text: event.name.toUpperCase(), 
                  style: style1,
                ), 
                FlexText(
                  text: DateFormat.yMMMd().format(DateTime.parse(event.date)), 
                  style: style2
                ),
                sizedBox,
                isLargeCard ? FlexText(
                  text: '${event.songIds.length} ${event.songIds.length > 1 ? "Songs" : "Song"}', 
                  // alignment: Alignment.center,
                  style: style3,
                ) : Container(), // name of the event
                isLargeCard ? FlexText(
                  // alignment: Alignment.center,
                  text: 'Posted By: creator', 
                  style: style3,
                ) : Container(),
                // date of event
              ],
            ),
          ],
        )
      )
    );
  }
}