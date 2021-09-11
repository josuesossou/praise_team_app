import 'package:flutter/material.dart';
// import 'package:lgcogpraiseteam/components/flexText.dart';
import 'package:lgcogpraiseteam/components/loader.dart';
import 'package:lgcogpraiseteam/models/ModelProvider.dart';
import 'package:lgcogpraiseteam/services/dbSongsQuery.dart';

// Transpose number goes my half step
class TransposeCard extends StatelessWidget {
  const TransposeCard({ Key key, @required this.transDataKey });

  final String transDataKey;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 18, 
      fontWeight: FontWeight.normal
    );

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // margin: EdgeInsets.only(bottom: 15),
                      data.userName,
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Sing in ' + data.transposeKey,
                      style: style,
                    ),
                    Text(
                      data.transposeNum == 0 ? "No Capo" :
                        'Capo ' + data.transposeNum.toString(),
                      style: style,
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
            widget = Loader(color: Theme.of(context).accentColor,);
          }
          return widget;
        }
      )
    );
  }
}