import 'package:flutter/material.dart';
import 'package:gym_diary/components/common/dot_indicator.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  final workoutNames = ["Push", "Pull", "Legs"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Workout"),
        ),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
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
            Positioned(
              right: 0,
              left: 0,
              bottom: 30,
              child: DotIndicator(controller: _pageController, pageCount: 3),
            )
          ],
        ));
  }
}
