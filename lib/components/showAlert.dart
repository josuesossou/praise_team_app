import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
import 'package:lgcogpraiseteam/models/Song.dart';
import 'package:lgcogpraiseteam/services/dbSongsQuery.dart';

class ReportContent extends StatelessWidget{
  ReportContent({ @required this.song });

  final Song song;
  
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Text(
            "Report song for inappropriate content?",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(
                  'Report',
                  style: TextStyle(
                    color: _theme.accentColor 
                  ),
                ),
                onPressed: () {
                  var newSong = song.copyWith(
                    reported: true
                  );

                  DbSongsQuery().updateSong(newSong);

                  showSuccess(
                    context, 
                    "Report sent! Video will not be displayed in the future"
                  );
                },
              ),
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.redAccent),
                ),
                
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}