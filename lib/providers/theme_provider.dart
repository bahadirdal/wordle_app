import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  bool isDark = false;


  setTheme({required bool turn0n}){
    isDark = turn0n;
    notifyListeners();
  }

}