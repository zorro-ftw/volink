import 'package:flutter/material.dart';
import 'package:volink/screens/sing_up_screen.dart';

void main() {
  runApp(Volink());
}

class Volink extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SignUpScreen(),
    );
  }
}
