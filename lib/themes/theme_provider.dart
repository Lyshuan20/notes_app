import 'package:flutter/material.dart';
import 'package:notes_app/themes/theme.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = modoClaro;
  ThemeData get themeData => _themeData;
  bool get esModoOscuro => _themeData == modoOscuro;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == modoClaro){
      themeData = modoOscuro;
    }else{
      themeData = modoClaro;
    }
  }
}