import 'package:flutter/material.dart';

class ChatsViewModel extends ChangeNotifier {
  bool _showUnread = true;

  bool get showUnread => _showUnread;

  void toggleShowUnread() {
    _showUnread = !_showUnread;
    notifyListeners();
  }
}
