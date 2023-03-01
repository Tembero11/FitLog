import 'package:flutter/material.dart';
import 'package:gym_diary/components/common/dot_indicator.dart';
import 'package:gym_diary/components/common/workout_slider.dart';

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

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  final workoutNames = ["Push", "Pull", "Legs"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Workout"),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: 'prevBtn',
              onPressed: prevPage,
              child: const Icon(Icons.chevron_left),
            ),
            const SizedBox(width: 40),
            DotIndicator(controller: _pageController, pageCount: 3),
            const SizedBox(width: 40),
            FloatingActionButton(
              heroTag: 'mainBtn',
              onPressed: nextPage,
              child: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                          onPressed: nextPage,
                          child: Text(workoutNames[index]),
                        ),
                      );
                    }),
                  ),
                ),
                const Center(
                  child: WorkoutSlider(),
                ),
                Text("Hello world"),
                Text("Hello world"),
              ],
            ),
          ],
        ));
  }
}
