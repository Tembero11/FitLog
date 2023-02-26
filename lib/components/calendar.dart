import 'package:flutter/material.dart';
import 'package:gym_diary/screens/workout.dart';
import 'package:gym_diary/utils/extra_date_utils.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static const startYear = 2022;

  late final itemCount;
  @override
  void initState() {
    itemCount = (DateTime.now().year - startYear) * 12;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.secondary,
          child: GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            children: ExtraDateUtils.weekdayNames
                .map((day) => Center(
                        child: Text(
                      day[0],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    )))
                .toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              int yearIndex = (index / 12).floor();
              int monthIndex = index % 12;
              int year = startYear - yearIndex;

              DateTime firstDayDate = DateTime(year, monthIndex + 1, 1);
              int weekdayIndex = firstDayDate.weekday - 1;

              int daysInMonth = DateUtils.getDaysInMonth(year, monthIndex + 1);
              var days =
                  List<Widget>.generate(daysInMonth + weekdayIndex, (index) {
                if (index < weekdayIndex) {
                  return const SizedBox();
                }
                int day = index - weekdayIndex + 1;
                var date = DateTime(year, monthIndex + 1, day);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutScreen(
                            date: date,
                          ),
                        ));
                  },
                  child: Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Center(
                        child: Text(day.toString()),
                      ),
                    ),
                  ),
                );
              });

              return Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    ExtraDateUtils.getMonthName(monthIndex),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 7,
                    physics: const NeverScrollableScrollPhysics(),
                    children: days,
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
