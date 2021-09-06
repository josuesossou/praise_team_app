import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lgcogpraiseteam/components/button.dart';
import 'package:lgcogpraiseteam/components/colorCard.dart';
import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
import 'package:lgcogpraiseteam/models/UserData.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';
import '../utils/colorStrings.dart';
import '../components/arrowBack.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isDisabled = false;

  void _signOut() async {
    await Amplify.Auth.signOut();
    Phoenix.rebirth(context);
  }

  void _upDateUserData(int color) async {
    if (isDisabled) return;
    var _dbQuery = DbUserQuery();

    setState(() {
      isDisabled = true;
    });

    UserData _userData = await _dbQuery.getMyUserData();

    if (_userData != null) {
      var _newUserData = _userData.copyWith(
        color: color.toString(),
      );

      await _dbQuery.updateMyUserData(_newUserData);

      showSuccess(context, 'Restart the app to see changes');
    } else {
      showError(context, 'Unable to set color, check your internet connection');
    }

    setState(() {
      isDisabled = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    List<Widget> colorCards = colorStrings.map((color) => MaterialButton(
      onPressed: () {
        _upDateUserData(color);
      }, 
      child: ColorCard(color: color, isDisabled: isDisabled),
      padding: EdgeInsets.only(bottom: 10),
      minWidth: (_size.width -40) / 4,
      // color: Colors.transparent,
    )).toList();

    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      appBar: AppBar(
        leading: ArrowBack(),
        elevation: 0,
        title: Text('Personal Info'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.70 * _size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Personalize',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: colorCards,

            ),
            SizedBox(height: 40,),
            RectButton(
              onPress: () {
                _signOut();
              }, 
              color: Colors.redAccent,
              elevation: 5,
              child: Text('Sign Out')
            )
          ],
        ),
      ),
    )
    );
  }
}