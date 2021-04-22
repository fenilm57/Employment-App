import 'package:employment_app/auth/SignIn.dart';
import 'package:employment_app/auth/authenticate.dart';
import 'package:employment_app/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This file will check for permanent user logged in or not

Authenticate authenticate = Authenticate();

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    if (authenticate.loggedIn() == 0) {
      print('Sign in');
      return SignIn();
    } else {
      print('Home screen');
      return HomeScreen();
    }
  }
}
