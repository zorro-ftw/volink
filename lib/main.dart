import 'package:flutter/material.dart';
import 'package:volink/screens/login_screen.dart';

void main() {
  runApp(Volink());
}

class Volink extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
