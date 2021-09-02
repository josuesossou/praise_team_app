import 'package:flutter/material.dart';

// entry screens
import 'entry/entry.dart';
import 'entry/dashboard.dart';
import 'entry/auth.dart';
import 'entry/confirm.dart';

// amplify configuration
import 'utils/amplifyConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praise&Worship Team',
      onGenerateRoute: (settings) {
        // home
        if (settings.name == '/dashboard') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => 
              DashboardEntry(),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }

        // signup
        if (settings.name == '/auth') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                Auth(),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }

        // // login
        // if (settings.name == '/login') {
        //   return PageRouteBuilder(
        //     pageBuilder: (_, __, ___) =>
        //         ConfirmScreen(data: settings.arguments as LoginData),
        //     transitionsBuilder: (_, __, ___, child) => child,
        //   );
        // }

        if (settings.name == '/confirm') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
              ConfirmScreen(data: settings.arguments as Map<String, dynamic>),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }


        return MaterialPageRoute(builder: (_) => EntryScreen());
      },
    );
  }
}


















// class SwitchNavigator extends StatefulWidget {
//   const SwitchNavigator({ Key key }) : super(key: key);

//   @override
//   _SwitchNavigatorState createState() => _SwitchNavigatorState();
// }

// class _SwitchNavigatorState extends State<SwitchNavigator> {
//   void doSignup() async {
//     try {
//       Map<String, String> userAttributes = {
//         'email': 'lometogovi1@gmail.com',
//         'name': 'John Doe',
//       };
//       SignUpResult res = await Amplify.Auth.signUp(
//         username: 'lometogovi',
//         password: 'mysupersecure',
//         options: CognitoSignUpOptions(
//           userAttributes: userAttributes
//         )
//       );
//       print(res.isSignUpComplete);
//     } on AuthException catch (e) {
//       print(e.message);
//     }
//   }

//   void doConfirmSignup() async {
//     try {
//       SignUpResult res = await Amplify.Auth.confirmSignUp(
//         username: 'lometogovi',
//         confirmationCode: '299032'
//       );
//       // setState(() {
//       //   isSignUpComplete = res.isSignUpComplete;
//       // });
//     } on AuthException catch (e) {
//       print(e.message);
//     }
//   }

//   void _login() async {
//     try {
//       SignInResult res = await Amplify.Auth.signIn(
//         username: 'lometogovi',
//         password: 'mysupersecure',
//       );

//     } on AuthException catch (e) {
//       print(e.message);
//     }
//   }

//   void _fetchUserAttributes() async {
//     try {
//       AuthUser res = await Amplify.Auth.getCurrentUser();
//       // String identityId = (res as CognitoAuthSession).identityId;
//       print(res.username );

//       // print('identityId: $identityId');
//       // print(res);
//     } catch (e) {
//       print(e.message);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     // _fetchSession();
//     _fetchUserAttributes();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: TodosList(todos: [],)
//     );
//   }
// }

// class TodosList extends StatelessWidget {
//   final List<Todo> todos;

//   TodosList({@required this.todos});

//   @override
//   Widget build(BuildContext context) {
//     return todos.isEmpty ?
//         Center(child: Text('Tap button below to add a todo!'))
//         : ListView(
//             padding: EdgeInsets.all(8),
//             children: todos.map((todo) => TodoItem(todo: todo)).toList());
//   }
// }



// class TodoItem extends StatelessWidget {
//   final double iconSize = 24.0;
//   final Todo todo;

//   TodoItem({@required this.todo});

//   void _deleteTodo(BuildContext context) async {
//     // to be filled in a later step
//      try {
//       // to delete data from DataStore, we pass the model instance to
//       // Amplify.DataStore.delete()
//       await Amplify.DataStore.delete(todo);
//     } catch (e) {
//       print('An error occurred while deleting Todo: $e');
//     }
//   }

//   Future<void> _toggleIsComplete() async {
//     // to be filled in a later step
//       // copy the Todo we wish to update, but with updated properties
//     // Todo updatedTodo = todo.copyWith(isComplete: !todo.isComplete);
//     // try {

//     //   // to update data in DataStore, we again pass an instance of a model to
//     //   // Amplify.DataStore.save()
//     //   await Amplify.DataStore.save(updatedTodo);
//     // } catch (e) {
//     //   print('An error occurred while saving Todo: $e');
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () {
//           _toggleIsComplete();
//         },
//         onLongPress: () {
//           _deleteTodo(context);
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(todo.name,
//                       style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   Text(todo.description ?? 'No description'),
//                 ],
//               ),
//             ),
//             // Icon(
//             //     todo.isComplete
//             //         ? Icons.check_box
//             //         : Icons.check_box_outline_blank,
//             //     size: iconSize),
//           ]),
//         ),
//       ),
//     );
//   }
// }



// class AddTodoForm extends StatefulWidget {
//   @override
//   _AddTodoFormState createState() => _AddTodoFormState();
// }

// class _AddTodoFormState extends State<AddTodoForm> {
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();

//   Future<void> _saveTodo() async {
//     // get the current text field contents
//     String name = _nameController.text;
//     String description = _descriptionController.text;

//     // create a new Todo from the form values
//     // `isComplete` is also required, but should start false in a new Todo
//     Todo newTodo = Todo(
//       name: name,
//       description: description.isNotEmpty ? description : null,
//     );

//     try {
//       // to write data to DataStore, we simply pass an instance of a model to
//       // Amplify.DataStore.save()
//       await Amplify.DataStore.save(newTodo);

//       // after creating a new Todo, close the form
//       Navigator.of(context).pop();
//     } catch (e) {
//       print('An error occurred while saving Todo: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Todo'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(filled: true, labelText: 'Name')),
//               TextFormField(
//                   controller: _descriptionController,
//                   decoration:
//                       InputDecoration(filled: true, labelText: 'Description')),
//               ElevatedButton(onPressed: _saveTodo, child: Text('Save'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }