import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volink/screens/login_screen.dart';
import 'package:volink/models/chats_list_data.dart';

void main() {
  runApp(Volink());
}

class Volink extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatsListData(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: LoginScreen(),
      ),
    );
  }
}
