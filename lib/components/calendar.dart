import 'package:flutter/material.dart';
import 'package:gym_diary/screens/workout.dart';
import 'package:gym_diary/utils/extra_date_utils.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static const startYear = 2015;

  late GlobalKey firstMonthKey;
  late ScrollController controller;
  final itemCount = (DateTime.now().year - startYear + 2) * 12;
  final double itemExtent = 395;

  @override
  void initState() {
    controller = ScrollController();
    firstMonthKey = GlobalKey();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _scrollToToday());

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _getDifferenceInMonths(DateTime date) {
    return (date.year - startYear) * 12 + date.month - 1;
  }

  _scrollToToday({bool animate = false}) {
    DateTime now = DateTime.now();
    // Get the amount of months since the calendar start year
    int months = _getDifferenceInMonths(now);
    double offset = itemExtent * months;

    if (animate) {
      controller.animateTo(offset,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    } else {
      controller.jumpTo(offset);
    }
  }

  _getYearFromScroll(double scrollOffset) {
    int months = scrollOffset ~/ itemExtent;
    int years = months ~/ 12;
    return startYear + years;
  }

  _weekBuilder(int index, int monthIndex, int year, int weekdayIndex) {
    if (index < weekdayIndex) {
      return const SizedBox();
    }
    int day = index - weekdayIndex + 1;
    var date = DateTime(year, monthIndex + 1, day);
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var isToday = date.difference(today).inDays == 0;

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
            border: isToday
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2)
                : null,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Center(
            child: Text(day.toString()),
          ),
        ),
      ),
    );
  }

  Widget _monthBuilder(BuildContext context, int index) {
    int yearIndex = (index / 12).floor();
    int monthIndex = index % 12;
    int year = startYear + yearIndex;

    DateTime firstDayDate = DateTime(year, monthIndex + 1, 1);
    int weekdayIndex = firstDayDate.weekday - 1;

    int daysInMonth = DateUtils.getDaysInMonth(year, monthIndex + 1);
    var days = List<Widget>.generate(
      daysInMonth + weekdayIndex,
      (index) => _weekBuilder(index, monthIndex, year, weekdayIndex),
    );

    return Column(
      key: index == 0 ? firstMonthKey : null,
      children: [
        Text(
          ExtraDateUtils.getMonthName(monthIndex),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 7),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          physics: const NeverScrollableScrollPhysics(),
          children: days,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarAppBar(
          scrollController: controller,
          getYear: _getYearFromScroll,
          scrollHome: _scrollToToday,
        ),
        Expanded(
          child: ListView.builder(
            itemExtent: itemExtent,
            controller: controller,
            itemCount: itemCount,
            itemBuilder: _monthBuilder,
          ),
        )
      ],
    );
  }
}

class CalendarAppBar extends StatefulWidget {
  final Function getYear;
  final Function scrollHome;
  final ScrollController scrollController;
  const CalendarAppBar({
    super.key,
    required this.getYear,
    required this.scrollHome,
    required this.scrollController,
  });

  @override
  State<CalendarAppBar> createState() => _CalendarAppBarState();
}

class _CalendarAppBarState extends State<CalendarAppBar> {
  late int currentYear;
  @override
  void initState() {
    currentYear = DateTime.now().year;
    widget.scrollController.addListener(() {
      setState(() {
        currentYear = widget.getYear(widget.scrollController.offset);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentYear.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => widget.scrollHome(animate: true),
                      tooltip: 'Show today',
                      icon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  ],
                )),
            GridView.count(
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
          ],
        ));
  }
}
