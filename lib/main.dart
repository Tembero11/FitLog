import 'package:flutter/material.dart';
import 'package:gym_diary/screens/home.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Gym Diary",
      home: Material(child: HomeScreen()),
    );
  }
}
