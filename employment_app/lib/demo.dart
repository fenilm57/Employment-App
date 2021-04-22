import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  final String firstname;
  Demo({this.firstname});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(firstname),),
    );
  }
}
