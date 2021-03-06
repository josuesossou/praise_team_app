import 'package:flutter/material.dart';
import '../components/flexText.dart';
import '../components/loader.dart';
import '../models/Event.dart';
import '../services/dbEventsQuery.dart';
import '../components/eventCard.dart';

class Events extends StatefulWidget {
  Events({ this.events });

  final List<Event> events;

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

  DbEventsQuery dbEventsQuery = DbEventsQuery();

  int upcomingEventsAmount = 0;
  PageController _controller = PageController(
    initialPage: 0, viewportFraction: 0.8, keepPage: true
  );
  SizedBox sizedBox = SizedBox(height: 10); // used to separate content in column
  SizedBox sizedBoxL = SizedBox(height: 25); // larger separator
  TextStyle style = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  Stream<List<Event>> upcomingEvents() =>  dbEventsQuery.getUpcomingEvent;
  Future<List<Event>> previousEvents() => dbEventsQuery.getPreviousEvent();

  @override
  void initState() {
    dbEventsQuery.setSubscription();
    super.initState();
  }

  @override
  void dispose() {
    dbEventsQuery.cancelSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData _theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 40),
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
              child:Text('Upcoming Events', style: style,),
            ),
            sizedBox,
            Container(
              height: size.height * 0.20,
              child: StreamBuilder(
                stream: upcomingEvents(),
                builder: (BuildContext context, 
                                AsyncSnapshot<List<Event>> snapshot) {
                  Widget child;

                  if (snapshot.hasData) {
                    List<Event> docs = snapshot.data;
                    upcomingEventsAmount = docs.length;

                    if (docs.isEmpty) {
                      child = Container(
                        height: size.height * 0.17,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "No upcoming events",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    } else {
                      child = PageView(
                        scrollDirection: Axis.horizontal,
                        controller: _controller,
                        children: docs.map((doc) => EventCard(
                          isLargeCard: true,
                          event: doc,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          type: "Comming up",
                        )).toList(),
                      );
                    }
                  } else if (snapshot.hasError) {
                    child = Column(
                      children: [FlexText(text: snapshot.error.toString(),)],
                    );
                  } else {
                    child = Loader(color: _theme.accentColor);
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
              builder: (BuildContext context, 
                        AsyncSnapshot<List<Event>> snapshot) {
                Widget child;

                if (snapshot.hasData) {
                  List<Event> docs = snapshot.data;
                  if (docs.isEmpty) {
                    child =  Container(
                      height: size.height *0.3,
                      alignment: Alignment.center,
                      child: Text("Start by scheduling new events",),
                    );
                  } else {
                    child = Column(
                      children: docs.map((doc) => EventCard(
                        type: "Previous Event",
                        height: 100,
                        event: doc,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10, 
                          vertical: 5
                        ),
                      )).toList(),
                    );
                  }
                } else if (snapshot.hasError) {
                  child = Column(
                    children: [
                      FlexText(text: snapshot.error.toString(),)
                    ],
                  );
                } else {
                  child = Loader(color: _theme.accentColor,);
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