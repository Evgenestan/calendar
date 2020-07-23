import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'calendar_page.dart';
import 'day.dart';

OverlayEntry overlayEntry;

OverlayState overlayState;
final selectedDates = PublishSubject<List<DateTime>>();

class CustomCalendar {
  BuildContext context;

  Color primaryTextColor;
  Color secondaryTextColor;
  Color borderColor;
  Color inversionHolidayColor;
  Color inversionWorkdayColor;
  Color disabledHolidayColor;
  Color disabledWorkdayColor;
  Color enabledHolidayColor;
  Color enabledWorkdayColor;
  Color roundColor;
  Color disabledRoundColor;
  TextStyle greenSmallText;
  TextStyle blackSmallText;
  List<Day> disabledDate;
  CustomCalendar(
    this.context, {
    this.borderColor = const Color(0xFF777777),
    this.enabledWorkdayColor = const Color(0xFF2d2d2d),
    this.disabledWorkdayColor = const Color(0xFF9a9a9a),
    this.enabledHolidayColor = Colors.red,
    this.disabledHolidayColor = const Color(0xFFeeccce),
    this.inversionHolidayColor = Colors.red,
    this.primaryTextColor = Colors.black,
    this.secondaryTextColor = Colors.green,
    this.roundColor = const Color(0xFF47a73c),
    this.disabledRoundColor = const Color(0xFF42a046),
    this.disabledDate,
    this.inversionWorkdayColor = Colors.white,
  }) {
    disabledDate ??= [];
    greenSmallText = TextStyle(
        color: secondaryTextColor, fontWeight: FontWeight.w600, fontSize: 15);
    blackSmallText = TextStyle(
        color: primaryTextColor, fontWeight: FontWeight.w600, fontSize: 15);

    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
        builder: (context) => Center(
              child: CalendarPage(
                greenRoundColor: roundColor,
                blackSmallText: blackSmallText,
                greenSmallText: greenSmallText,
                inversionHolidayColor: inversionHolidayColor,
                disabledHolidayColor: disabledHolidayColor,
                disabledWorkdayColor: disabledWorkdayColor,
                borderColor: borderColor,
                enabledHolidayColor: enabledHolidayColor,
                enabledWorkdayColor: enabledWorkdayColor,
                disabledDate: disabledDate,
                disabledRoundColor: disabledRoundColor,
              ),
            ));

    overlayState.insert(overlayEntry);
  }
}
