import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime dateTimeNow = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      selectedDayPredicate: (day) => isSameDay(day, DateTime.now()),
      focusedDay: dateTimeNow,
      rangeStartDay: rangeStart,
      rangeEndDay: rangeEnd,
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          rangeStart = start;
          rangeEnd = end;
          dateTimeNow = focusedDay;
        });
      },
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030),
      onDaySelected: (selectedDay, focusedDay) {},
      availableGestures: AvailableGestures.all,
      headerStyle:
          const HeaderStyle(formatButtonVisible: false, titleCentered: true),
    );
  }
}
