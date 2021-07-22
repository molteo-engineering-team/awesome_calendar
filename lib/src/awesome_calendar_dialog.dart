part of awesome_calendar;

/// A custom date time picker that uses AwesomeCalendar
class AwesomeCalendarDialog extends StatefulWidget {
  const AwesomeCalendarDialog({
    this.initialDate,
    this.selectedDates,
    this.canToggleRangeSelection = true,
    this.selectionMode = SelectionMode.SINGLE,
    this.rangeToggleText = 'Select a date range',
    this.confirmBtnText = 'OK',
    this.cancelBtnText = 'CANCEL',
    this.dayTileBuilder,
    this.weekdayLabels,
  });

  /// Initial date of the date picker, used to know which month needs to be shown
  final DateTime? initialDate;

  /// The current selected dates
  final List<DateTime>? selectedDates;

  /// It will add a toggle to activate/deactivate the range selection mode
  final bool canToggleRangeSelection;

  /// [SINGLE, MULTI, RANGE]
  /// The user can switch between MULTI and RANGE if you set [canToggleRangeSelection] to true
  final SelectionMode selectionMode;

  /// Text of the range toggle if canToggleRangeSelection is true
  final String rangeToggleText;

  /// Text of the confirm button
  final String confirmBtnText;

  /// Text of the cancel button
  final String cancelBtnText;

  /// The builder to create a day widget
  final DayTileBuilder? dayTileBuilder;

  /// The weekdays widget to show above the calendar
  final Widget? weekdayLabels;

  @override
  _AwesomeCalendarDialogState createState() => _AwesomeCalendarDialogState(
        currentMonth: initialDate,
        selectedDates: selectedDates,
        selectionMode: selectionMode,
      );
}

class _AwesomeCalendarDialogState extends State<AwesomeCalendarDialog> {
  _AwesomeCalendarDialogState({
    this.currentMonth,
    this.selectedDates,
    this.selectionMode = SelectionMode.SINGLE,
  }) {
    currentMonth ??= DateTime.now();
  }

  List<DateTime>? selectedDates;
  DateTime? currentMonth;
  SelectionMode selectionMode;
  GlobalKey<AwesomeCalendarState> calendarStateKey =
      GlobalKey<AwesomeCalendarState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        width: 300,
        height: widget.canToggleRangeSelection ? 380 : 330,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      calendarStateKey.currentState!.setCurrentDate(DateTime(
                          currentMonth!.year, currentMonth!.month - 1));
                    },
                  ),
                  Text(DateFormat('yMMMM').format(currentMonth!)),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    onPressed: () {
                      calendarStateKey.currentState!.setCurrentDate(DateTime(
                          currentMonth!.year, currentMonth!.month + 1));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AwesomeCalendar(
                key: calendarStateKey,
                startDate: DateTime(2018),
                endDate: DateTime(2100),
                selectedSingleDate: currentMonth,
                selectedDates: selectedDates,
                selectionMode: selectionMode,
                onPageSelected: (DateTime? start, DateTime? end) {
                  setState(() {
                    currentMonth = start;
                  });
                },
                dayTileBuilder: widget.dayTileBuilder,
                weekdayLabels: widget.weekdayLabels,
              ),
            ),
            if (widget.canToggleRangeSelection &&
                selectionMode != SelectionMode.SINGLE)
              ListTile(
                title: Text(
                  widget.rangeToggleText,
                  style: const TextStyle(fontSize: 13),
                ),
                leading: Switch(
                  value: selectionMode == SelectionMode.RANGE,
                  onChanged: (bool value) {
                    setState(() {
                      selectionMode =
                          value ? SelectionMode.RANGE : SelectionMode.MULTI;
                      selectedDates = <DateTime>[];
                      calendarStateKey.currentState!.selectedDates =
                          selectedDates;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(widget.cancelBtnText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(widget.confirmBtnText),
          onPressed: () {
            final AwesomeCalendarState? calendar =
                calendarStateKey.currentState;
            Navigator.of(context).pop(
              widget.selectionMode == SelectionMode.SINGLE
                  ? calendar!.selectedSingleDate
                  : calendar!.selectedDates,
            );
          },
        ),
      ],
    );
  }
}
