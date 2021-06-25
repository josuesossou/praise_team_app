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
    bool userExist = false;
    bool isLogin = true;

    final SizedBox sizedBox = SizedBox(
        height: 30,
    );
    Map<String, String> loginInfo = {
        'orgEmail': '',
        'orgPassword': '',
        'personalEmail': ''
    };
    AuthModel auth = AuthModel();

    @override
    void initState() {
        super.initState();
    }

    updateLoginInfo(type, changedText) {
        loginInfo[type] = changedText;
    }

    signin() {
        auth.doSigning(
            loginInfo['orgEmail'], 
            loginInfo['orgPassword'],
            loginInfo['personalEmail']
        ).then((isUserFound) => {
            if (!isUserFound) {
                setState(() {
                    userExist = true;
                    isLogin = false;
                })
            } else {

            }
        });
    }

    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        TextStyle style = TextStyle(
            fontSize: 18
        );

        return Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: 0.95 * size.height,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            isLogin? Container(
                                height: size.height * 0.7,
                                width: size.width,
                                child: LoginInfo(
                                    updateLoginInfo: updateLoginInfo,
                                    signin: signin,
                                    style: style,
                                ),
                            ) : Container(),
                            userExist? Container(
                                height: size.height * 0.7,
                                width: size.width,
                                child: AdditionalInfo(
                                    updateLoginInfo: updateLoginInfo,
                                    style: style,
                                ),
                            ) : Container(),
                        ],
                    ),
                )
            )
        );
    }
}

class LoginInfo extends StatelessWidget {
    LoginInfo({
        @required this.updateLoginInfo,
        @required this.signin,
        @required this.style
    });

    final TextStyle style;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Logo(
                    size: 30,
                ),
                Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold
                    ),
                    // alignment: Alignment.bottomCenter,
                ),

                sizedBox,
                sizedBox,
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            margin: EdgeInsets.only(left: 15, bottom: 5),
                            child: Text(
                                'Oraganiztion Email',
                                style: style,
                            ),
                        ),
                        TextFieldCop(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            obscureText: false,
                            onChange: (text) => 
                                updateLoginInfo('orgEmail', text),
                            color: theme.primaryColorDark,
                        ),
                    ],
                ),
            
                sizedBox,
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            margin: EdgeInsets.only(left: 15, bottom: 5),
                            child: Text(
                                'Oraganiztion Password',
                                style: style,
                            ),
                        ),
                        TextFieldCop(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            obscureText: true,
                            onChange: (text) => 
                                updateLoginInfo('orgPassword', text),
                            color: theme.primaryColorDark,
                        ),
                    ],
                ),
                
                sizedBox,
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            margin: EdgeInsets.only(left: 15, bottom: 5),
                            child: Text(
                                'Personal Email',
                                style: style,
                            ),
                        ),
                        
                        TextFieldCop(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            obscureText: false,
                            onChange: (text) => 
                                updateLoginInfo('personalEmail', text),
                            color: Theme.of(context).primaryColorLight,
                        ),
                    ],
                ),
            
                sizedBox,
                RectButton(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    elevation: 5.0,
                    color: Color(0xff01A0C7),
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text('Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold
                        )
                    ),
                    onPress: () => signin(),
                    width: MediaQuery.of(context).size.width,
                )
            ],
        ),
        );
    }
}

class AdditionalInfo extends StatelessWidget {
    AdditionalInfo({
        @required this.updateLoginInfo,
        @required this.style
    });

    final Function updateLoginInfo;
    final TextStyle style;

    final SizedBox sizedBox = SizedBox(
        height: 30,
    );

    @override
    Widget build(BuildContext context) {
        ThemeData theme = Theme.of(context);

        return Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Logo(
                        size: 30,
                    ),
                    Text(
                        'Additional Info',
                        style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold
                        ),
                    ),

                    sizedBox,
                    sizedBox,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                margin: EdgeInsets.only(left: 15, bottom: 5),
                                child: Text(
                                    'Name',
                                    style: style,
                                ),
                            ),
                            TextFieldCop(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                obscureText: false,
                                onChange: (text) =>
                                    updateLoginInfo('fullName', text),
                                color: theme.primaryColorDark,
                            ),
                        ],
                    ),
                    
                    sizedBox,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                margin: EdgeInsets.only(left: 15, bottom: 5),
                                child: Text(
                                    '''Role eg. Drumer, Guitarist (Optional)''',
                                    style: style,
                                ),
                            ),
                            TextFieldCop(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                obscureText: true,
                                onChange: (text) => 
                                    updateLoginInfo('role', text),
                                color: Theme.of(context).primaryColorLight,
                            ),
                        ],
                    ),
                   
                    sizedBox,
                    RectButton(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        elevation: 5.0,
                        color: Color(0xff01A0C7),
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        child: Text('Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold)
                        ),
                        onPress: () {},
                        width: MediaQuery.of(context).size.width,
                    ),
                ],
            )
        );
    }
}
