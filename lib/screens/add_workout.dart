import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_diary/components/common/workout_slider.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  late PageController _pageController;
  final int _pageCount = 4;

  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void nextPage() {
    if (_pageController.page == _pageCount - 1) {
      Navigator.pop(context);
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final workoutNames = ["Push", "Pull", "Legs"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade100,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.red.shade100,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          title: FractionallySizedBox(
            widthFactor: .6,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
            minHeight: 15,
            color: Colors.red.shade900,
            backgroundColor: Colors.red.shade200,
            value: _pageController.hasClients ? (_pageController.page! + 1) / _pageCount : 0
          ),
          ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onBackground,
          toolbarHeight: 80,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 7,
              child: PageView(
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
                          child: TextButton(
                            onPressed: nextPage,
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)))
                            ),
                            child: Text(workoutNames[index]),
                          ),
                        );
                      }),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: .9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: const Alignment(-.4, 1),
                          child: FractionallySizedBox(
                          widthFactor: .6,
                          child: Text("How was the pump?", style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900
                        ),),
                        ),
                        ),
                        const SizedBox(height: 100),
                        Column(
                          children: [
                            Text("GREAT", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            ),),
                            const SizedBox(height: 15),
                            WorkoutSlider(
                              activeTrackColor: Colors.red.shade300,
                              inactiveTrackColor: Colors.red.shade200,
                              divisionColor: Colors.red.shade400,
                            ),
                            const SizedBox(height: 15),
                            Text("BAD", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            )),
                          ],
                        ),
                      ]
                    ),
                  ),
                  Text("Hello world"),
                  Text("Hello world"),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: .8,
                child: TextButton(
                onPressed: nextPage,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)))
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Next", style: TextStyle(fontSize: 18),),
                    Icon(Icons.chevron_right, size: 30,),
                  ],
                ),
              ),
              ),
            )
          ],
        ));
  }
}
