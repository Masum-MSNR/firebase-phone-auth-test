import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

String state = 'User Signed In';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          state = 'User Signed Out';
        });
      } else {
        setState(() {
          state = 'User Signed In';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+8801797246959',
              verificationCompleted: (value) {
                print('verificationCompleted');
                print(value);
              },
              verificationFailed: (value) {
                print('verificationFailed');
                print(value);
              },
              codeSent: (value, value2) {
                print('codeSent');
                print(value);
                print(value2);
              },
              codeAutoRetrievalTimeout: (value) {
                print('codeAutoRetrievalTimeout');
                print(value);
              },
            );
          },
          child: Text(state),
        ),
      ),
    );
  }
}
