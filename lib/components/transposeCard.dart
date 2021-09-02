import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/flexText.dart';
import 'package:lgcogpraiseteam/components/loader.dart';
import 'package:lgcogpraiseteam/models/ModelProvider.dart';
import 'package:lgcogpraiseteam/services/dbSongsQuery.dart';

// Transpose number goes my half step
class TransposeCard extends StatelessWidget {
  const TransposeCard({ Key key, @required this.transDataKey });

  final String transDataKey;

  @override
  Widget build(BuildContext context) {
    return Container(
    
    child: FutureBuilder(
      future: TransposeQuery().getOne(transDataKey),
      builder: (BuildContext context, AsyncSnapshot<TransposeData> snap) {
        Widget widget;

        if (snap.hasData) {
          TransposeData data = snap.data;

          widget = Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),

              child: Column(
                children: [
                  FlexText(
                    margin: EdgeInsets.only(bottom: 15),
                    text: data.userName + ' Key',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  FlexText(
                    text: 'Transposed Key' + data.transposeKey,
                  ),
                  FlexText(
                    text: 'Transpose ' + data.userName,
                  ),
                ],
              ),
            ),
          );
          
        } else if (snap.hasError) {
          widget = Container(
            child: Text('Could not get transpose data'),
          );
        } else {
          widget = Loader();
        }

        return widget;
      }
    )
    );
  }
}