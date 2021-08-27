import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
// import 'package:lgcogpraiseteam/models/AuthModel.dart';
// import '../components/flexText.dart';
import '../components/textField.dart';
import '../components/logo.dart';
import '../components/button.dart';
import 'package:flutter_login/flutter_login.dart';

// import 'dashboard.dart';


class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
    bool _isSignupAction = false;
    LoginData _data; 

    final SizedBox sizedBox = SizedBox(
        height: 30,
    );
    Map<String, String> loginInfo = {
        'orgEmail': '',
        'orgPassword': '',
        'personalEmail': ''
    };
    // AuthModel auth = AuthModel();

    @override
    void initState() {
      super.initState();
    }

    updateLoginInfo(type, changedText) {
      loginInfo[type] = changedText;
    }

    Future<String> _doSignup(LoginData data) async {
      _isSignupAction = true;
      _data = data;
      print(data.name);
      return null;
    }

    Future<String> _onLogin(LoginData data) async {
      try {
        final res = await Amplify.Auth.signIn(
          username: data.name,
          password: data.password,
        );

        if (res.isSignedIn) {
          return null;
        }

        return 'Something went wrong, Try again';
      } on AuthException catch (e) {
        if (e.message.contains('already a user which is signed in')) {
          await Amplify.Auth.signOut();
          return 'Problem logging in. Please try again.';
        }

        return '${e.message} - ${e.recoverySuggestion}';
      }
    }

    Future<String> _recoverPassword(String name) {
      return Future.delayed(Duration(microseconds: 100))
              .then((value) => 'recover working');
    }

    @override
    Widget build(BuildContext context) {
      return FlutterLogin(
        title: 'P&W TEAM',
        // logo: 'assets/images/ecorp-lightblue.png',
        onLogin: _onLogin,
        onSignup: _doSignup,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => _isSignupAction ?
                    AdditionalInfo(loginData: _data,)
                    : Container(),
          ));
        },
        onRecoverPassword: _recoverPassword,
        theme: LoginTheme(
          primaryColor: Colors.teal,
          accentColor: Colors.yellow,
          errorColor: Colors.deepOrange,
          titleStyle: TextStyle(
            color: Colors.greenAccent,
            fontFamily: 'Quicksand',
            letterSpacing: 4,
          ),
        ),
      );
    }
}


class AdditionalInfo extends StatelessWidget {
  AdditionalInfo({ @required this.loginData });

  final LoginData loginData;

  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _orgIdController = TextEditingController();

  final SizedBox sizedBox = SizedBox(
    height: 10,
  );

  void _onSignup(context) async {
    try {
      await Amplify.Auth.signUp(
        username: _nameController.text.replaceAll(' ', '').toLowerCase(),
        password: loginData.password,
        options: CognitoSignUpOptions(userAttributes: {
          'email': loginData.name,
          'name': _nameController.text,
          'custom:role': _roleController.text,
          'custom:organizationID': _orgIdController.text
        }),
      );

      // _data = data;
      // print(data.name);
      showSuccess(context, 'An email with a verification code was sent');
      Navigator.pushReplacementNamed(context, '/confirm');
    } on AuthException catch (e) {
      showError(context, '${e.message} - ${e.recoverySuggestion}');
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Additional Info'),
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          labelText: 'First and Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      sizedBox,
                      TextField(
                        controller: _roleController,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          labelText: 'Musician Role (optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      sizedBox,
                      TextField(
                        controller: _orgIdController,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          prefixIcon: Icon(Icons.verified_user_rounded),
                          labelText: 'Organization ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      sizedBox,
                      MaterialButton(
                        onPressed: () {
                          _onSignup(context);
                        },
                        elevation: 4,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Colors.deepPurple.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                              builder: (context) => Auth(),
                            ));
                        },
                        child: Text(
                          'Go back',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
