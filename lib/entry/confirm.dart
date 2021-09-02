import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:lgcogpraiseteam/components/scaffoldMessages.dart';
import 'package:lgcogpraiseteam/models/UserData.dart';
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
          User _user = User();

          UserData newUserData = UserData(
            uid: _user.getUser.userId,
            name: _user.getUserAttributes.name,
            role: _user.getUserAttributes.role,
          );

          await Amplify.DataStore.save(newUserData);
          
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
    } on AuthException catch (e) {
      showError(context, e.message);
    }
  }

  void _resendCode(BuildContext context,
    Map<String, dynamic> data) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: data['username']);

      showSuccess(context, 'Confirmation code resent. Check your email');
    } on AuthException catch (e) {
      showError(context, e.message);
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
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
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
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Enter confirmation code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
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
                        color: Theme.of(context).primaryColor,
                        disabledColor: Colors.deepPurple.shade200,
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





// class Testing extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber, 
//       body: Column(
//         children: [
//           Text('this is dashboard'),
//           MaterialButton(
//             onPressed: () {
//               Amplify.Auth.signOut();
//             },
//             child: Text(
//               'Sign out',
//               style: TextStyle(color: Colors.grey),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }