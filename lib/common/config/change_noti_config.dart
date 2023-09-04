import 'package:flutter/material.dart';

class ChangeNotiConfig extends ChangeNotifier {
  bool autoMute = false;

  bool isDarkMode = false;

  void onToggleMute() {
    autoMute = !autoMute;
    notifyListeners();
  }

  void onToggleDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

final changeNotiConfig = ChangeNotiConfig();
