import './awesome_calendar.dart';
import 'date_helper.dart';
import 'package:flutter/material.dart';

class AwesomeCalendarDayItem extends StatelessWidget {
  AwesomeCalendarDayItem({this.date, this.awesomeCalendarState, this.onTap});

  DateTime date;
  AwesomeCalendarState awesomeCalendarState;
  DateTimeCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool isWeekend = DateHelper.isWeekend(date);
    var textColor = isWeekend ? Colors.grey : Colors.black;
    bool isToday = DateHelper.isToday(date);
    awesomeCalendarState = AwesomeCalendar.of(context);

    bool daySelected = awesomeCalendarState.isDateSelected(date);

    BoxDecoration boxDecoration;
    if (daySelected) {
      boxDecoration = BoxDecoration(color: Colors.blue, shape: BoxShape.circle);
    } else if (isToday) {
      boxDecoration = BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
          shape: BoxShape.circle);
    }

    return Expanded(
        child: GestureDetector(
      child: Container(
          height: 40.0,
          decoration: boxDecoration,
          child: Center(
              child: Text(
            "${date.day}",
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ))),
      onTap: handleTap,
      behavior: HitTestBehavior.translucent,
    ));
  }

  void handleTap() {
    if (onTap != null) {
      onTap(date);
    }

    awesomeCalendarState.setSelectedDate(date);
    awesomeCalendarState.setCurrentDate(date);
  }
}
