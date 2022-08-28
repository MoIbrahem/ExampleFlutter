import 'package:example/BottomNavigation/home.dart';
import 'package:example/homeScreen.dart';
import 'package:example/messengerScreen.dart';
import 'package:example/store/createUser.dart';
import 'package:example/store/readUser.dart';
import 'package:example/userScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:example/auth/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter demo',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: CreateUser(),
    );
  }
}
