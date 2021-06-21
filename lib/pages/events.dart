import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/flexText.dart';
import 'package:lgcogpraiseteam/components/loader.dart';
import 'package:lgcogpraiseteam/models/EventModel.dart';
import '../services/dbEventsQuery.dart';
import '../components/eventCard.dart';

class Events extends StatefulWidget {
  Events({ this.events });

  final List<EventModel> events;

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

  DbEventsQuery dbEventsQuery = DbEventsQuery();

  PageController controller = PageController(initialPage: 0);
  SizedBox sizedBox = SizedBox(height: 10); // used to separate content in column
  SizedBox sizedBoxL = SizedBox(height: 25); // larger separator
  TextStyle style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  Stream<QuerySnapshot> upcomingEvents() =>  dbEventsQuery.getUpcomingEvent();
  Future<QuerySnapshot> previousEvents() => dbEventsQuery.getPreviousEvent();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.80 * size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            sizedBox,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Upcoming Events', style: style,),
            ),
            sizedBox,
            Container(
              height: size.height * 0.20,
              child: StreamBuilder(
                stream: upcomingEvents(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  Widget child;

                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> docs = snapshot.data.docs;
                    if (docs.isEmpty) {
                      child = Column(
                        children: [FlexText(text: "No upcoming events",)],
                      );
                    } else {
                      child = PageView(
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        children: docs.map((doc) => EventCard(
                          isLargeCard: true,
                          event: EventModel.fromMap(doc.data()),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          type: "Comming up",
                        )).toList(),
                      );
                    }
                  } else if (snapshot.hasError) {
                    child = Column(
                      children: [FlexText(text: snapshot.error.toString(),)],
                    );
                  } else {
                    child = Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Container(
                    child: child,
                  );
                }
              )
            ),
            sizedBoxL,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Previous Events', style: style,),
            ),
            sizedBox,
            FutureBuilder(
              future: previousEvents(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                Widget child;

                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> docs = snapshot.data.docs;
                  if (docs.isEmpty) {
                    child = Column(
                      children: [FlexText(text: "Start by scheduling new events",)],
                    );
                  } else {
                    child = Column(
                      children: docs.map((doc) => EventCard(
                        type: "Previous Event",
                        height: 100,
                        event: EventModel.fromMap(doc.data()),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      )).toList(),
                    );
                  }
                } else if (snapshot.hasError) {
                  child = Column(
                    children: [FlexText(text: snapshot.error.toString(),)],
                  );
                } else {
                  child = Loader();
                }

                return Container(
                  child: child,
                );
              }
            ),
            SizedBox(height: 100)
          ]
        ),
      )
    );
  }
}