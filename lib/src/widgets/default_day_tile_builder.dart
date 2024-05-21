part of '../../awesome_calendar.dart';

class DefaultDayTileBuilder extends DayTileBuilder {
  DefaultDayTileBuilder();

  @override
  Widget build(BuildContext context, DateTime date,
      void Function(DateTime datetime)? onTap) {
    return DefaultDayTile(
      date: date,
      onTap: onTap,
    );
  }
}
