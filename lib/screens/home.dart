import 'package:flutter/material.dart';
import 'package:gym_diary/screens/add_workout.dart';
import 'package:gym_diary/screens/tabs/calendar.dart';
import 'package:gym_diary/screens/tabs/workouts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gym Diary"),
      ),
      body: IndexedStack(
        index: tabIndex,
        children: const [CalendarTab(), WorkoutTab()],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'mainBtn',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddWorkoutScreen()));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (tab) {
          setState(() {
            tabIndex = tab;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Calendar',
            icon: Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            label: 'History',
            icon: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}
