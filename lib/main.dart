import 'package:flutter/material.dart';
// import './models/AuthModel.dart';
// import 'package:provider/provider.dart';

// dart async library we will refer to when setting up real time updates
import 'dart:async';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

// logics
// import './utils/auth_status.dart';

// // widgets
// import './start/login.dart';
// import './start/main.dart';

import 'models/Todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  AmplifyConfigure();
  }
}

class AmplifyConfigure extends StatefulWidget {
  @override
  _AmplifyConfigureState createState() => _AmplifyConfigureState();
}

class _AmplifyConfigureState extends State<AmplifyConfigure> {
  bool _amplifyConfigured = false;

  void _configureAmplify() async {
    
      // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed
    AmplifyDataStore dsPlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([dsPlugin, authPlugin, analyticsPlugin]);

    try {
      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);

    
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_amplifyConfigured) {
      _configureAmplify();
    }

  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthModel>(context);
    // myModel.doSomething();
    return _amplifyConfigured ? MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorLight: Color(0xfff0f0f0),
        primaryColorDark: Color(0xffe0e0e0),
        accentColor: Color(0xff01A0C7)
      ),
      home: SwitchNavigator()
      // auth.authUser == null ? MainApp() : Login(),
    ) 
    : Container(color: Colors.blue,);
  }
}

class SwitchNavigator extends StatefulWidget {
  const SwitchNavigator({ Key key }) : super(key: key);

  @override
  _SwitchNavigatorState createState() => _SwitchNavigatorState();
}

class _SwitchNavigatorState extends State<SwitchNavigator> {
  void doSignup() async {
    try {
      Map<String, String> userAttributes = {
        'email': 'email@domain.com',
        'name': 'John Doe',
      };
      SignUpResult res = await Amplify.Auth.signUp(
        username: 'myusername',
        password: 'mysupersecurepassword',
        options: CognitoSignUpOptions(
          userAttributes: userAttributes
        )
      );
      print(res.isSignUpComplete);
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void _login() async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: 'myusername',
        password: 'mysupersecurepassword',
      );

    } on AuthException catch (e) {
      print(e.message);
    }
  }
  
  void _fetchSession() async {
    try {
      var res = await Amplify.Auth.fetchUserAttributes();
      // String identityId = (res as CognitoAuthSession).identityId;
      res.forEach((element) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
      });

      // print('identityId: $identityId');
      // print(res);
    } catch (e) {
      print(e.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // _fetchSession();
    _login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TodosList(todos: [],)
    );
  }
}

class TodosList extends StatelessWidget {
  final List<Todo> todos;

  TodosList({@required this.todos});

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty ?
        Center(child: Text('Tap button below to add a todo!'))
        : ListView(
            padding: EdgeInsets.all(8),
            children: todos.map((todo) => TodoItem(todo: todo)).toList());
  }
}



class TodoItem extends StatelessWidget {
  final double iconSize = 24.0;
  final Todo todo;

  TodoItem({@required this.todo});

  void _deleteTodo(BuildContext context) async {
    // to be filled in a later step
     try {
      // to delete data from DataStore, we pass the model instance to
      // Amplify.DataStore.delete()
      await Amplify.DataStore.delete(todo);
    } catch (e) {
      print('An error occurred while deleting Todo: $e');
    }
  }

  Future<void> _toggleIsComplete() async {
    // to be filled in a later step
      // copy the Todo we wish to update, but with updated properties
    // Todo updatedTodo = todo.copyWith(isComplete: !todo.isComplete);
    // try {

    //   // to update data in DataStore, we again pass an instance of a model to
    //   // Amplify.DataStore.save()
    //   await Amplify.DataStore.save(updatedTodo);
    // } catch (e) {
    //   print('An error occurred while saving Todo: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _toggleIsComplete();
        },
        onLongPress: () {
          _deleteTodo(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.name,
                      style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(todo.description ?? 'No description'),
                ],
              ),
            ),
            // Icon(
            //     todo.isComplete
            //         ? Icons.check_box
            //         : Icons.check_box_outline_blank,
            //     size: iconSize),
          ]),
        ),
      ),
    );
  }
}



class AddTodoForm extends StatefulWidget {
  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _saveTodo() async {
    // get the current text field contents
    String name = _nameController.text;
    String description = _descriptionController.text;

    // create a new Todo from the form values
    // `isComplete` is also required, but should start false in a new Todo
    Todo newTodo = Todo(
      name: name,
      description: description.isNotEmpty ? description : null,
    );

    try {
      // to write data to DataStore, we simply pass an instance of a model to
      // Amplify.DataStore.save()
      await Amplify.DataStore.save(newTodo);

      // after creating a new Todo, close the form
      Navigator.of(context).pop();
    } catch (e) {
      print('An error occurred while saving Todo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(filled: true, labelText: 'Name')),
              TextFormField(
                  controller: _descriptionController,
                  decoration:
                      InputDecoration(filled: true, labelText: 'Description')),
              ElevatedButton(onPressed: _saveTodo, child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}