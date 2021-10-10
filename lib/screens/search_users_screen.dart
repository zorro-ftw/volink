import 'package:flutter/material.dart';
import 'package:volink/constants.dart';

class SearchUsersScreen extends StatefulWidget {
  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kButtonBackgroundColor,
        centerTitle: true,
        title: Text("Search"),
      ),
    );
  }
}
