import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:lgcogpraiseteam/components/textField.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';

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

    return null;
  }

  Future<String> _onLogin(LoginData data) async {
    try {
      final res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );

      if (res.isSignedIn) {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return null;
      }

      return 'Something went wrong, Try again';
    } on AuthException catch (e) {
      if (e.message.contains('already a user which is signed in')) {
        await Amplify.Auth.signOut();
        return 'Problem logging in. Please try again.';
      }

      if (e.message.contains('User not found in the system')) {
        showError(context, 'Email may not be verified, please confirm.');
        Navigator.pushReplacementNamed(
          context, 
          '/confirm', 
          arguments: {
            'username': data.name.split('@')[0]
                                  .toLowerCase(), 
            'email': data.name,
            'password': data.password 
          }
        );
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
        primaryColor: Color(0xFF4DB6AC),
        textFieldStyle: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 15,
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.teal.withOpacity(.1),
          labelStyle: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 15
          ),
        ),
        errorColor: Colors.redAccent,
        titleStyle: TextStyle(
          color: Colors.white,
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
    String username = loginData.name.split('@')[0].toLowerCase();
    bool isOrgExist = await DbUserQuery().checkOrganization(
      _orgIdController.text
    );

    if (_nameController.text.isEmpty) {
      showError(context, 'A name is required');
      return;
    }

    if (!isOrgExist) {
      showError(context, 'Organization Id does not exist');
      return;
    }

    try {
      await Amplify.Auth.signUp(
        username: username,
        password: loginData.password,
        options: CognitoSignUpOptions(userAttributes: {
          'email': loginData.name,
          'name': _nameController.text.toString(),
          'custom:role': _roleController.text.isEmpty ? 'Musician' : 
                          _roleController.text.toString(),
          'custom:organizationID': _orgIdController.text.toString()
        }),
      );

      showSuccess(context, 'A confirmation code was sent to your email');
      Navigator.pushReplacementNamed(
        context, 
        '/confirm', 
        arguments: {
          'username': username, 
          'email': loginData.name,
          'password': loginData.password 
        }
      );
    } on AuthException catch (_) {
      showError(
        context, 
        'Something went wrong, please check internet connection and try again'
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DB6AC),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 0.70 * MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ADDITIONAL INFO',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Quicksand',
                  color: Colors.white,
                  letterSpacing: 4
                ),
              ),
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
                      CustomTextInput(
                        controller: _nameController, 
                        labelText: 'Your Name (Required)', 
                        icon: Icon(
                          Icons.account_circle_rounded,
                        )
                      ),
                      sizedBox,
                      CustomTextInput(
                        controller: _roleController, 
                        labelText: 'Musician Role (optional)', 
                        icon: Icon(Icons.account_circle_rounded),
                      ),
                      sizedBox,
                      CustomTextInput(
                        controller: _orgIdController, 
                        labelText: 'Organization ID (Required)', 
                        icon: Icon(Icons.verified_user_rounded),
                      ),
                      sizedBox,
                      MaterialButton(
                        onPressed: () {
                          _onSignup(context);
                        },
                        elevation: 4,
                        color: Color(0xFF4DB6AC),
                        disabledColor: Colors.teal.shade200,
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
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'Quicksand'
                          ),
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
