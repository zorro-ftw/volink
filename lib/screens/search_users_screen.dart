import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:volink/firebase_services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/models/search_result_user.dart';
import 'package:volink/widgets/custom_avatar.dart';
import 'package:volink/widgets/custom_textfield.dart';

class SearchUsersScreen extends StatefulWidget {
  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  Future<List<SearchResultUser>> getUSerSuggestions(String query) async {
    List<SearchResultUser> result = [];
    if (query != null && query.length != 0) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dummyData =
          await DataService().getStringIncludesQuery(
              queryString: query, collection: 'users', field: 'userName');

      for (var snapshot in dummyData) {
        result.add(SearchResultUser(
            userName: snapshot.data()['userName'],
            profilePhotoURL: snapshot.data()['profilePhotoURL']));
      }
    } else {
      result = null;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final kTextFieldDecoration = InputDecoration(
      hintText: 'Enter username',
      hintStyle: TextStyle(color: Colors.grey),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF1D1D1F), width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kButtonBackgroundColor,
        centerTitle: true,
        title: Text("Search"),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          TypeAheadField(
              textFieldConfiguration:
                  TextFieldConfiguration(decoration: kTextFieldDecoration),
              suggestionsCallback: (query) async {
                return await getUSerSuggestions(query);
              },
              itemBuilder: (context, SearchResultUser user) {
                return ListTile(
                  leading: CustomAvatar(
                    chat: Chat(
                        chatID: '',
                        peerID: '',
                        messages: [],
                        lastMessageAt: DateTime.now(),
                        peerName: user.userName,
                        peerPhotoURL: user.profilePhotoURL),
                    radius: 15,
                  ),
                  title: Text(user.userName),
                );
              },
              onSuggestionSelected: (SearchResultUser user) {})
        ],
      ),
    );
  }
}
