part of awesome_calendar;

class AwesomeCalendarPage extends StatelessWidget {
  const AwesomeCalendarPage({
    required this.pageStartDate,
    required this.pageEndDate,
    required this.weekdayLabels,
    required this.dayTileBuilder,
    this.onTap,
  });

  /// The maximum number of rows that we can have on a month
  static const int maxRowsCount = 6;

  /// The start date of the month to show
  final DateTime pageStartDate;

  /// The end date of the month to show
  final DateTime pageEndDate;

  /// The weekdays widget to show above the calendar
  final Widget weekdayLabels;

  /// The builder to create a day widget
  final DayTileBuilder dayTileBuilder;

  /// The function when the user clicks on a day
  final void Function(DateTime datetime)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: buildRows(context),
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  List<Widget> buildRows(BuildContext context) {
    final int startDayOffset = pageStartDate.weekday - DateTime.monday;
    final List<Widget> rows = <Widget>[];
    rows.add(weekdayLabels);

    // First week
    final DateTime rowLastDayDate =
        CalendarHelper.addDaysToDate(pageStartDate, 6 - startDayOffset);
    rows.add(
      Row(
        children: buildCalendarRow(context, pageStartDate, rowLastDayDate),
      ),
    );

    // Each row is a week
    for (int i = 1; i < maxRowsCount; i++) {
      final DateTime rowFirstDayDate =
          CalendarHelper.addDaysToDate(pageStartDate, 7 * i - startDayOffset);
      if (rowFirstDayDate.isAfter(pageEndDate)) {
        /// The entire page is done
        break;
      }
      DateTime rowLastDayDate =
          CalendarHelper.addDaysToDate(rowFirstDayDate, 6);
      if (rowLastDayDate.isAfter(pageEndDate)) {
        rowLastDayDate = pageEndDate;
      }
      rows.add(
        Row(
          children: buildCalendarRow(context, rowFirstDayDate, rowLastDayDate),
        ),
      );
    }
    return rows;
  }

  /// Create one line of days (a week)
  List<Widget> buildCalendarRow(
      BuildContext context, DateTime rowStartDate, DateTime rowEndDate) {
    final List<Widget> items = <Widget>[];

    DateTime currentDate = rowStartDate;
    for (int i = 0; i < 7; i++) {
      if (i + 1 >= rowStartDate.weekday && i + 1 <= rowEndDate.weekday) {
        final Widget dayTile =
            dayTileBuilder.build(context, currentDate, onTap);
        items.add(dayTile);
        currentDate = currentDate.add(const Duration(days: 1));
      } else {
        // Adds empty spaces at the begining and end of the page if necessary
        items.add(
          const Expanded(
            child: Text(''),
          ),
        );
      }
    }

    return items;
  }
}
