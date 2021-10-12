import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volink/screens/login_screen.dart';
import 'package:volink/models/chats_list_data.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
