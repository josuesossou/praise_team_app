import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/flexText.dart';
import 'package:lgcogpraiseteam/models/ModelProvider.dart';

class TransposeCard extends StatelessWidget {
  const TransposeCard({ Key key, @required this.data });

  final TransposeData data;
  // Transpose number goes my half step
  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}