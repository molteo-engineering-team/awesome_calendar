part of awesome_calendar;

abstract class DayTileBuilder {
  Widget build(BuildContext context, DateTime date,
      void Function(DateTime datetime)? onTap);
}
