// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gocar/signup.dart';
import 'package:gocar/splachscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gocar/test.dart';
import 'package:gocar/uploadcar.dart';
import 'firebase_options.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); 
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp(),
    );
  }
}
