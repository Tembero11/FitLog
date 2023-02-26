import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_diary/screens/add_workout.dart';
import 'package:gym_diary/screens/tabs/calendar.dart';
import 'package:gym_diary/screens/tabs/workouts.dart';
import 'package:gym_diary/utils/data_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int tabIndex = 1;

  final dataManager = DataManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("FitLog"),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: tabIndex,
          children: const [CalendarTab(), WorkoutTab()],
        ),
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
