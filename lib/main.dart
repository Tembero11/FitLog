import 'package:flutter/material.dart';
import 'package:gym_diary/screens/home.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  static const primaryColor = Color(0xff5372DC);
  static const secondaryColor = Color(0xffC3C4D8);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FitLog",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: primaryColor
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white
        ),
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(primary: primaryColor)
      ),
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Material(child: HomeScreen()),
    );
  }
}
