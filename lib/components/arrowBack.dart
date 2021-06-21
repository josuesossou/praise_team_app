import 'package:flutter/material.dart';

import 'button.dart';

class ArrowBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CirButton(
        size: 40,
        onPress: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}