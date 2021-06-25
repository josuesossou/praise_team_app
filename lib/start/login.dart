import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/models/AuthModel.dart';
import '../components/flexText.dart';
import '../components/textField.dart';
import '../components/logo.dart';
import '../components/button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final SizedBox sizedBox = SizedBox(
    height: 30,
  );
  bool userExist;
  Map<String, String> loginInfo = {
    'orgEmail': '',
    'orgPassword': '',
    'personalEmail': ''
  };
  AuthModel auth = AuthModel();

  @override
  void initState() {
    setState(() {
      userExist = false;
    });
    super.initState();
  }

  updateLoginInfo(type, changedText) {
    loginInfo[type] = changedText;
  }

  signin() {
    auth
        .doSigning(loginInfo['orgEmail'], loginInfo['orgPassword'],
            loginInfo['personalEmail'])
        .then((isUserFound) => {
              setState(() {
                userExist = isUserFound;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Logo(
            size: 30,
          ),
          // sizedBox,
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: LoginInfo(
              updateLoginInfo: updateLoginInfo,
              signin: signin,
            ),
          ),
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.5,
          //   width: MediaQuery.of(context).size.width,
          //   child: AdditionalInfo(
          //     updateLoginInfo: updateLoginInfo,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class LoginInfo extends StatelessWidget {
  LoginInfo({
    @required this.updateLoginInfo,
    @required this.signin,
  });

  final Function updateLoginInfo;
  final Function signin;

  final SizedBox sizedBox = SizedBox(
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlexText(
            text: 'Login',
            alignment: Alignment.bottomCenter,
          ),
          sizedBox,
          FlexText(
            text: 'Oraganiztion Email',
            margin: EdgeInsets.only(left: 25),
          ),
          TextFieldCop(
            obscureText: false,
            onChange: (text) => updateLoginInfo('orgEmail', text),
            color: theme.primaryColorDark,
          ),
          sizedBox,
          FlexText(
            text: 'Oraganiztion Password',
            margin: EdgeInsets.only(left: 25),
          ),
          TextFieldCop(
            obscureText: true,
            onChange: (text) => updateLoginInfo('orgPassword', text),
            color: theme.primaryColorDark,
          ),
          sizedBox,
          FlexText(
            text: 'Personal Email',
            margin: EdgeInsets.only(left: 25),
          ),
          TextFieldCop(
            obscureText: true,
            onChange: (text) => updateLoginInfo('personalEmail', text),
            color: Theme.of(context).primaryColorLight,
          ),
          sizedBox,
          RectButton(
            margin: EdgeInsets.symmetric(horizontal: 20),
            elevation: 5.0,
            color: Color(0xff01A0C7),
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: Text('Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            onPress: () => signin(),
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }
}

class AdditionalInfo extends StatelessWidget {
  AdditionalInfo({@required this.updateLoginInfo});

  final Function updateLoginInfo;

  final SizedBox sizedBox = SizedBox(
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlexText(
          text: 'Additional Info',
          alignment: Alignment.bottomCenter,
        ),
        sizedBox,
        FlexText(
          text: 'Name',
          margin: EdgeInsets.only(left: 25),
        ),
        TextFieldCop(
          obscureText: false,
          onChange: (text) => updateLoginInfo('fullName', text),
          color: theme.primaryColorDark,
        ),
        sizedBox,
        FlexText(
          text: 'Role eg. Drumer, Guitarist, Pianist ... (Optional)',
          margin: EdgeInsets.only(left: 25),
        ),
        TextFieldCop(
          obscureText: true,
          onChange: (text) => updateLoginInfo('role', text),
          color: Theme.of(context).primaryColorLight,
        ),
        sizedBox,
        RectButton(
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 5.0,
          color: Color(0xff01A0C7),
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text('Register',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPress: () {},
          width: MediaQuery.of(context).size.width,
        ),
      ],
    ));
  }
}
