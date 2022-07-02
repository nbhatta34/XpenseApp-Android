import 'package:xpense_android/themes/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkThemeToggle extends StatelessWidget {
  const DarkThemeToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      activeColor: Color.fromARGB(255, 201, 154, 253),
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
