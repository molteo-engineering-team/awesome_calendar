// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Awesome Calendar Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime initialDate = DateTime.now();

  DateTime? singleSelect;
  DateTime embeddedCalendar = DateTime.now();
  List<DateTime>? multiSelect;
  List<DateTime>? rangeSelect;
  List<DateTime>? multiOrRangeSelect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(singleSelect?.toString() ?? ''),
              ElevatedButton(
                onPressed: () => singleSelectPicker(),
                child: const Text('Single select picker'),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text(multiSelect?.toString() ?? ''),
              ElevatedButton(
                onPressed: () => multiSelectPicker(),
                child: const Text('Multi select picker'),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text(rangeSelect?.toString() ?? ''),
              ElevatedButton(
                onPressed: () => rangeSelectPicker(),
                child: const Text('Range select picker'),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text(multiOrRangeSelect?.toString() ?? ''),
              ElevatedButton(
                onPressed: () => multiOrRangeSelectPicker(),
                child: const Text('Range or Multi select picker'),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Text('Embedded calendar (single select):'),
              Text(embeddedCalendar.toString()),
              AwesomeCalendar(
                selectedSingleDate: embeddedCalendar,
                onTap: (DateTime date) {
                  setState(() {
                    embeddedCalendar = date;
                  });
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Text('Custom colors Embedded calendar (single select):'),
              AwesomeCalendar(
                selectedSingleDate: DateTime.now(),
                dayTileBuilder: CustomDayTileBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> singleSelectPicker() async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.single,
        );
      },
    );
    if (picked != null) {
      setState(() {
        singleSelect = picked;
      });
    }
  }

  Future<void> multiSelectPicker() async {
    final List<DateTime>? picked = await showDialog<List<DateTime>>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.multi,
        );
      },
    );
    if (picked != null) {
      setState(() {
        multiSelect = picked;
      });
    }
  }

  Future<void> rangeSelectPicker() async {
    final List<DateTime>? picked = await showDialog<List<DateTime>>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.range,
        );
      },
    );
    if (picked != null) {
      setState(() {
        rangeSelect = picked;
      });
    }
  }

  Future<void> multiOrRangeSelectPicker() async {
    final List<DateTime>? picked = await showDialog<List<DateTime>>(
      context: context,
      builder: (BuildContext context) {
        return const AwesomeCalendarDialog(
          selectionMode: SelectionMode.multi,
          canToggleRangeSelection: true,
        );
      },
    );
    if (picked != null) {
      setState(() {
        multiOrRangeSelect = picked;
      });
    }
  }
}

class CustomDayTileBuilder extends DayTileBuilder {
  CustomDayTileBuilder();

  @override
  Widget build(BuildContext context, DateTime date,
      void Function(DateTime datetime)? onTap) {
    return DefaultDayTile(
      date: date,
      onTap: onTap,
      selectedDayColor: Colors.cyan,
      currentDayBorderColor: Colors.grey,
    );
  }
}
