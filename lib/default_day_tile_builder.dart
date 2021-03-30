import './awesome_calendar.dart';
import './default_day_tile.dart';
import 'package:flutter/material.dart';

class DefaultDayTileBuilder extends DayTileBuilder {
  DefaultDayTileBuilder();

  @override
  Widget build(BuildContext context, DateTime date, DateTimeCallback onTap) {
    return AwesomeCalendarDayItem(
      date: date,
      awesomeCalendarState: AwesomeCalendar.of(context),
      onTap: onTap,
    );
  }
}
