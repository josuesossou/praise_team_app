import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:lgcogpraiseteam/components/loader.dart';
import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
import 'package:lgcogpraiseteam/components/textField.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';

class ConfirmScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  ConfirmScreen({@required this.data});

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final _controller = TextEditingController();
  bool _isEnabled = false;
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  void _verifyCode(BuildContext context,
  Map<String, dynamic> data, String code) async {
    setState(() {
      _showLoader = true;
    });
    try {
      final res = await Amplify.Auth.confirmSignUp(
        username: data['username'],
        confirmationCode: code,
      );

      if (res.isSignUpComplete) {
        // Login user
        final user = await Amplify.Auth.signIn(
          username: data['username'], password: data['password']);

        if (user.isSignedIn) {
          await DbUserQuery().saveUserData();
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
    } on AuthException catch (e) {
      setState(() {
        _showLoader = false;
      });
      showError(context, e.message);
    }
  }

  void _resendCode(BuildContext context,
        Map<String, dynamic> data) async {
    setState(() {
      _showLoader = true;
    });

    try {
      await Amplify.Auth.resendSignUpCode(username: data['username']);

      showSuccess(context, 'Confirmation code resent. Check your email');
      setState(() {
        _showLoader = false;
      });
    } on AuthException catch (e) {
      showError(context, e.message);
      setState(() {
        _showLoader = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DB6AC),
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _showLoader ? 
                Loader(color: Colors.white,) : 
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
                          controller: _controller, 
                          labelText: 'Enter confirmation code', 
                          icon: Icon(Icons.account_circle_rounded),
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          onPressed: _isEnabled
                              ? () {
                                  _verifyCode(
                                      context, widget.data, _controller.text);
                                }
                              : null,
                          elevation: 4,
                          color: Color(0xFF4DB6AC),
                          disabledColor: Colors.teal.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            'VERIFY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            _resendCode(context, widget.data);
                          },
                          child: Text(
                            'Resend code',
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



