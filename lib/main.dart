import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/chat_main_data.dart';
import 'package:volink/screens/login_screen.dart';
import 'package:volink/models/chats_list_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:volink/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Volink());
}

class Volink extends StatelessWidget {
  static String _firstScreen;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      _firstScreen = MainScreen.id;
    } else {
      _firstScreen = LoginScreen.id;
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatsListData(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatMainData(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: _firstScreen,
        routes: {
          MainScreen.id: (context) => MainScreen(),
          LoginScreen.id: (context) => LoginScreen()
        },
      ),
    );
  }
}
