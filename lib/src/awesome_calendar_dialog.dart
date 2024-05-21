part of '../awesome_calendar.dart';

/// A custom date time picker that uses AwesomeCalendar
class AwesomeCalendarDialog extends StatefulWidget {
  const AwesomeCalendarDialog({
    this.initialDate,
    this.selectedDates,
    this.startDate,
    this.endDate,
    this.canToggleRangeSelection = false,
    this.selectionMode = SelectionMode.single,
    this.rangeToggleText = 'Select a date range',
    this.confirmBtnText = 'OK',
    this.cancelBtnText = 'CANCEL',
    this.dayTileBuilder,
    this.weekdayLabels,
    this.title,
  });

  /// Initial date of the date picker, used to know which month needs to be shown
  final DateTime? initialDate;

  /// The current selected dates
  final List<DateTime>? selectedDates;

  /// First date of the calendar
  final DateTime? startDate;

  /// Last date of the calendar
  final DateTime? endDate;

  /// It will add a toggle to activate/deactivate the range selection mode
  final bool canToggleRangeSelection;

  /// [single, multi, range]
  /// The user can switch between multi and range if you set [canToggleRangeSelection] to true
  final SelectionMode selectionMode;

  /// Text of the range toggle if canToggleRangeSelection is true
  final String rangeToggleText;

  /// Text of the confirm button
  final String confirmBtnText;

  /// Text of the cancel button
  final String cancelBtnText;

  /// The builder to create a day widget
  final DayTileBuilder? dayTileBuilder;

  /// A Widget that will be shown on top of the Dialog as a title
  final Widget? title;

  /// The weekdays widget to show above the calendar
  final Widget? weekdayLabels;

  @override
  State<AwesomeCalendarDialog> createState() => _AwesomeCalendarDialogState(
        currentMonth: initialDate,
        selectedDates: selectedDates,
        selectionMode: selectionMode,
      );
}

class _AwesomeCalendarDialogState extends State<AwesomeCalendarDialog> {
  _AwesomeCalendarDialogState({
    this.currentMonth,
    this.selectedDates,
    this.selectionMode = SelectionMode.single,
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
      content: SizedBox(
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.title != null) widget.title!,
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
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
                  startDate: widget.startDate ?? DateTime(2018),
                  endDate: widget.endDate ?? DateTime(2100),
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
                  selectionMode != SelectionMode.single)
                ListTile(
                  title: Text(
                    widget.rangeToggleText,
                    style: const TextStyle(fontSize: 13),
                  ),
                  leading: Switch(
                    value: selectionMode == SelectionMode.range,
                    onChanged: (bool value) {
                      setState(() {
                        selectionMode =
                            value ? SelectionMode.range : SelectionMode.multi;
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
              widget.selectionMode == SelectionMode.single
                  ? calendar!.selectedSingleDate
                  : calendar!.selectedDates,
            );
          },
        ),
      ],
    );
  }
}
