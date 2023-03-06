import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_diary/screens/add_workout.dart';
import 'package:gym_diary/screens/tabs/calendar.dart';
import 'package:gym_diary/screens/tabs/profile.dart';
import 'package:gym_diary/screens/tabs/workouts.dart';
import 'package:gym_diary/utils/data/month_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int tabIndex = 1;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black.withOpacity(0.002),
      ),
    );
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
          children: const [CalendarTab(), WorkoutTab(), ProfileTab()],
        ),
      ),
      floatingActionButton: tabIndex != 2 ? (tabIndex == 0 ? FloatingActionButton(
        onPressed: () {},
        heroTag: 'mainBtn',
        child: const Icon(Icons.add),
      ) : FloatingActionButton.extended(
        heroTag: 'mainBtn',
        label: tabIndex == 0 ? const Text("New") : const Text("New workout"),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddWorkoutScreen()));
        },
      )) : null,
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
            label: 'Recent Activity',
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}
