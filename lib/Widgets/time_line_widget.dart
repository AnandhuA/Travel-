// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:travel/Styles/colors.dart';

class TimeLineWidget extends StatelessWidget {
  bool start;
  bool end;
  String title;
  Function? remove;
  TimeLineWidget(
      {super.key,
      required this.start,
      required this.end,
      required this.title,
       this.remove});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: start,
      isLast: end,
      beforeLineStyle: LineStyle(
        color: blue100,
        thickness: 2,
      ),
      indicatorStyle: IndicatorStyle(
        color: white,
        iconStyle: IconStyle(
          iconData: Icons.location_on_outlined,
          fontSize: 20,
          color: blue400,
        ),
      ),
      endChild: ListTile(
        title: Text(title),
        trailing: remove!=null? IconButton(
          onPressed: () => remove!(),
          icon: const Icon(Icons.horizontal_rule),
        ):null
      ),
    );
  }
}
