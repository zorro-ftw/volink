import 'package:flutter/foundation.dart';
import 'package:volink/models/chat.dart';

class ChatsListData extends ChangeNotifier {
  List<Chat> _userChats = [];
  get userChatsCount {
    return _userChats.length;
  }

  get userChats {
    return _userChats;
  }
}
