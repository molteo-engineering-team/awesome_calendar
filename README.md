# Awesome Calendar

![](https://img.shields.io/github/license/molteo-engineering-team/awesome_calendar)
![](https://img.shields.io/pub/v/awesome_calendar)

An easy to use and customizable calendar for Flutter.

The calendar can be used with the provided AlertDialog or as a Widget embedded the way you want. It allows single, multi and range selection.

![](https://github.com/molteo-engineering-team/awesome_calendar/blob/main/demo.gif)

## Basic usage

```
final List<DateTime>? picked = await showDialog<List<DateTime>>(
  context: context,
  builder: (BuildContext context) {
    return const AwesomeCalendarDialog(
      selectionMode: SelectionMode.MULTI,
      canToggleRangeSelection: true,
    );
  },
);
```

Check out [examples](https://github.com/molteo-engineering-team/awesome_calendar/tree/main/example/lib/main.dart) to see more usage samples

The dates are translated automatically according to your `Intl.defaultLocale` value, the other string values can be overriden in the constructor.

## Found this project useful? ❤️

If you found this project useful, then please consider giving it a ⭐️ on Github: [https://github.com/molteo-engineering-team/awesome_calendar](https://github.com/molteo-engineering-team/awesome_calendar)

## Issues and feedback 💭

If you have any suggestions for including a feature or if something doesn't work, feel free to open a Github [issue](https://github.com/molteo-engineering-team/awesome_calendar/issues) or to open a [pull request](https://github.com/molteo-engineering-team/awesome_calendar/pulls), you are more than welcome to contribute!
