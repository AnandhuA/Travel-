// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatefulWidget {
  DateTime? rangestart;
  DateTime? rangeend;
  bool? onGoing;
  CalenderView({super.key, this.rangestart, this.rangeend,this.onGoing});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

DateTime dateTimeNow = DateTime.now();
DateTime? rangeStart;
DateTime? rangeEnd;

class _CalenderViewState extends State<CalenderView> {
  @override
  void initState() {
    super.initState();
    if (widget.rangestart != null && widget.rangeend != null) {
      rangeStart = widget.rangestart;
      rangeEnd = widget.rangeend;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    if(widget.onGoing != null && widget.onGoing == true ){
      rangeStart = widget.rangestart;
      rangeEnd = widget.rangeend;
    }
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
      // firstDay: DateTime.utc(214),

      lastDay: DateTime.utc(2030),
      onDaySelected: (selectedDay, focusedDay) {},
      availableGestures: AvailableGestures.all,
      headerStyle:
          const HeaderStyle(formatButtonVisible: false, titleCentered: true),
    );
  }
}

DateTime? getTableCalendarRangeStart() {
  return rangeStart;
}

DateTime? getTableCalendarRangeEnd() {
  return rangeEnd;
}
