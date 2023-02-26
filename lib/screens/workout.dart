import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_diary/utils/extra_date_utils.dart';

class WorkoutScreen extends StatefulWidget {
  final DateTime date;
  const WorkoutScreen({super.key, required this.date});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    int day = widget.date.day;
    int year = widget.date.year;
    String monthName = ExtraDateUtils.getMonthName(widget.date.month - 1);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.green,
      ),
      child: Material(
        color: Colors.green,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$day.',
                    style: const TextStyle(fontSize: 60),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(monthName), Text(year.toString())],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
