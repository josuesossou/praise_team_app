import 'package:flutter/material.dart';
// import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
// import 'package:lgcogpraiseteam/models/Song.dart';
// import 'package:lgcogpraiseteam/services/dbSongsQuery.dart';

class AlertContent extends StatelessWidget{
  AlertContent({ 
    @required this.func,
    @required this.content,
    @required this.aproveKeyWord,
  });

  final VoidCallback func;
  final String content, aproveKeyWord;
  
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
            content,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(
                  aproveKeyWord,
                  style: TextStyle(
                    color: _theme.accentColor 
                  ),
                ),
                onPressed: func
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