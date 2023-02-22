import 'package:flutter/material.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final workoutNames = ["Push", "Pull", "Legs"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Workout"),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          Center(
            child: ListView.builder(
              itemCount: workoutNames.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 15),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.fromLTRB(20, 40, 40, 20),
                    ),
                    child: Text(workoutNames[index]),
                  ),
                );
              }),
            ),
          ),
          Text("Hello world"),
          Text("Hello world"),
          Text("Hello world"),
        ],
      ),
    );
  }
}
