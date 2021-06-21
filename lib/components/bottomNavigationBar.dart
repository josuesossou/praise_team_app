import 'package:flutter/material.dart';
import './button.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({ 
    @required this.toSearchPage, 
    @required this.toProfilePage });

  final VoidCallback toSearchPage;
  final VoidCallback toProfilePage;

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    double height = 0.10 * mediaSize.height;
    double pad = 0.08 * mediaSize.width;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(left: pad, right: pad),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black12,
            offset: Offset.fromDirection(-5),
            spreadRadius: 5
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CirButton(
            child: Icon(Icons.account_circle_outlined, size: 0.40 * height,), // will change to profile later,
            size: height,
            onPress: toProfilePage,
          ),
          CirButton(
            child: Icon(Icons.search, size: 0.40 * height,),
            size: height,
            onPress: toSearchPage,
          )
        ],
      ),
    );
  }
}