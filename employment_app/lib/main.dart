import 'package:employment_app/home_screen.dart';
import 'package:employment_app/introduction/Introduction.dart';
import 'package:employment_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:employment_app/style/Style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/SignIn.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employment_app',
      home: Wrapper(),
      theme: ThemeData(
        scaffoldBackgroundColor: secondryBackColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
    );
  }
}
