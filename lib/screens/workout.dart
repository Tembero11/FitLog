import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkoutScreen extends StatefulWidget {
  final DateTime date;
  const WorkoutScreen({super.key, required this.date});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text("Workout"),
      ),
      body: Text('${widget.date.day.toString()}.',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
