import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      primaryColorDark: Color.fromARGB(255, 230, 230, 230),
      highlightColor: Color.fromARGB(255, 194, 194, 194),
      scaffoldBackgroundColor: Color.fromARGB(255, 22, 21, 21),
      colorScheme: ColorScheme.dark(),
      primaryColor: Color.fromARGB(255, 53, 53, 53),
      secondaryHeaderColor: Color.fromARGB(255, 53, 53, 53),
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 255, 81, 0),
      ),
      canvasColor: Color.fromARGB(255, 255, 255, 255),
      hintColor: Color.fromARGB(255, 39, 39, 39),
      cardColor: Color.fromARGB(255, 39, 39, 39),
      shadowColor: Color.fromARGB(255, 82, 82, 82),
      primaryColorLight: Color.fromARGB(121, 255, 166, 0),
      selectedRowColor: Colors.grey
      // focusColor: Color.fromARGB(255, 114, 114, 114),
      );

  static final lightTheme = ThemeData(
      primaryColorDark: Color.fromARGB(255, 24, 24, 24),
      highlightColor: Color.fromARGB(174, 0, 0, 0),
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      colorScheme: ColorScheme.light(),
      primaryColor: Color.fromARGB(255, 235, 232, 255),
      secondaryHeaderColor: Color.fromARGB(255, 111, 1, 255),
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 140, 0, 255),
      ),
      canvasColor: Color.fromARGB(255, 75, 75, 75),
      hintColor: Color.fromARGB(255, 239, 234, 255),
      cardColor: Color.fromARGB(255, 241, 241, 241),
      shadowColor: Color.fromARGB(255, 209, 209, 209),
      primaryColorLight: Colors.black54,
      selectedRowColor: Colors.grey
      // focusColor: Color.fromARGB(255, 131, 112, 255),
      );
}
