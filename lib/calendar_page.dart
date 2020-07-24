import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'closeAndSave.dart';
import 'day.dart';
import 'global_variables.dart';

class CalendarPage extends StatefulWidget {
  final TextStyle greenSmallText;
  final TextStyle blackSmallText;
  final Color borderColor;
  final Color inversionHolidayColor;
  final Color inversionWorkdayColor;
  final Color disabledHolidayColor;
  final Color disabledWorkdayColor;
  final Color enabledHolidayColor;
  final Color enabledWorkdayColor;
  final Color greenRoundColor;
  final Color disabledRoundColor;
  final List<Day> disabledDate;
  const CalendarPage({
    Key key,
    this.greenSmallText,
    this.blackSmallText,
    this.borderColor,
    this.inversionHolidayColor,
    this.disabledHolidayColor,
    this.disabledWorkdayColor,
    this.enabledHolidayColor,
    this.enabledWorkdayColor,
    this.greenRoundColor,
    this.disabledRoundColor,
    this.disabledDate,
    this.inversionWorkdayColor,
  }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final daysInWeek = 7;
  Map<int, bool> choice = {};
  DateTime initDate;
  List<Row> calendar = [];
  List<Widget> choiceWidget = [];
  Map<int, Color> colorChoiceWidget = {};

//  Widget _build<ЛОГИЧЕСКОЕ НАЗВАНИЕ ТВОЕГО ВИДЖЕТА> {
//    return ТВОЙ ВИДЖЕТ;
//  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () => closeCalendarAndSave(choice),
            ),
          ),
          Center(
            child: Container(
              width: 343,
              height: 318,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: widget.borderColor),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(26, 20, 190, 10),
                      alignment: Alignment.topLeft,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        text: TextSpan(children: [
                          // Стоит выносить отдельно, так ты усложняешь чтение
                          // Хотя бы в виде функции _build<ЛОГИЧЕСКОЕ НАЗВАНИЕ ТВОЕГО ВИДЖЕТА>
                          TextSpan(
                              text: DateFormat.MMM('ru').format(DateTime.now()).substring(0, 1).toUpperCase() + DateFormat.MMM('ru').format(DateTime.now()).substring(1), style: widget.blackSmallText),
                          TextSpan(text: ' ${DateFormat.y('ru').format(DateTime.now())}', style: widget.greenSmallText),
                        ]),
                      ),
                    ),
                    Container(
                      //color: Colors.red,
                      width: 308.0,
                      height: 40.0,
                      //alignment: Alignment.centerLeft,
                      child: CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              childAspectRatio: 308 / 290,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    DateFormat.E('ru').format(date[index].dateTime).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: widget.disabledWorkdayColor,
                                    ),
                                  ),
                                );
                              },
                              childCount: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: Container(
                          //color: Colors.red,
                          width: 308.0,
                          height: 215.0,
                          //alignment: Alignment.center,
                          child: CustomScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverGrid(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  childAspectRatio: 308 / 280,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  // Тоже самое с вынесением
                                  (BuildContext context, int index) {
                                    Color setColor() {
                                      if (date[index].dateTime.isBefore(DateTime.now())) {
                                        return widget.disabledWorkdayColor;
                                      }
                                      if (choice[index] && !date[index].isHoliday) {
                                        return widget.inversionWorkdayColor;
                                      }
                                      if (choice[index] && date[index].isHoliday) {
                                        return widget.inversionHolidayColor;
                                      }
                                      if (date[index].isHoliday && date[index].isDisabled) {
                                        return widget.disabledHolidayColor;
                                      }
                                      if (!date[index].isHoliday && date[index].isDisabled) {
                                        return widget.disabledWorkdayColor;
                                      }
                                      if (date[index].isHoliday && !date[index].isDisabled) {
                                        return widget.enabledHolidayColor;
                                      }
                                      return widget.enabledWorkdayColor;
                                    }

                                    indexDay[index] = date[index].dateTime;

                                    final color = setColor();

                                    return GestureDetector(
                                      onTap: () => setChoice(index),
                                      child: Stack(
                                        children: [
                                          choiceWidget[index],
                                          Container(
                                            width: 40,
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: Text(
                                              DateFormat.d().format(date[index].dateTime),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount: 42,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dayOnWeek() {
    final DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int weekDay = date.weekday;
    weekDay = (weekDay - 1) * -1;
    initDate = date.add(Duration(days: weekDay));
  }

  void disableDate() {
    for (int i = 0; i < 42; i++) {
      if (widget.disabledDate.isNotEmpty) {
        for (int j = 0; j < widget.disabledDate.length; j++) {
          if (date[i].dateTime == widget.disabledDate[j].dateTime) {
            date[i].isDisabled = widget.disabledDate[j].isDisabled;
            date[i].isHoliday = widget.disabledDate[j].isHoliday;
          }
        }
      }
      if (date[i].dateTime.isBefore(DateTime.now())) {
        date[i].isDisabled = true;
      }
    }
  }

  void fillChoice() {
    for (int i = 0; i < 42; i++) {
      choice[i] = false;
    }
  }

  void initCalendar() {
    initializeDateFormatting();
    dayOnWeek();
    if (choice.isEmpty) {
      fillChoice();
      choiceWidget = setChoiceWidget(0);
    }

    for (int j = 0; j < 6; j++) {
      for (var i = 0; i < daysInWeek; i++) {
        final DateTime dateTime = initDate.add(Duration(days: (daysInWeek * j) + i));
        date.add(Day(dateTime));
      }
    }
    disableDate();
  }

  @override
  void initState() {
    initCalendar();
    super.initState();
  }

  // Эту тоже можно разбить на несколько
  void setChoice(int number) {
    void setRange(int min, int max) {
      for (int i = min; i <= max; i++) {
        if (!date[i].isDisabled && !date[i].isHoliday) {
          choice[i] = true;
          colorChoiceWidget[i] = widget.greenRoundColor;
        } else {
          colorChoiceWidget[i] = widget.disabledRoundColor;
        }
      }
      setState(() {
        choiceWidget = setChoiceWidget(min, max);
      });
    }

    int firstTrueKey;

    if (!date[number].isDisabled) {
      if (choice.containsValue(true)) {
        for (int i = 0; i < 42; i++) {
          if (choice[i]) {
            if (firstTrueKey == null) {
              firstTrueKey = i;
            } else {
              setState(() {
                fillChoice();
                colorChoiceWidget = {};
                choice[number] = true;
                colorChoiceWidget[number] = widget.greenRoundColor;
                choiceWidget = setChoiceWidget(number);
              });
              return;
            }
          }
        }
        if (firstTrueKey == number) {
          setState(() {
            choice[number] = false;
            colorChoiceWidget = {};
            choiceWidget = setChoiceWidget(number);
          });
          return;
        }

        if (firstTrueKey > number) {
          setRange(number, firstTrueKey);
        } else {
          setRange(firstTrueKey, number);
        }
      } else {
        setState(() {
          choice[number] = true;
          colorChoiceWidget[number] = widget.greenRoundColor;
          choiceWidget = setChoiceWidget(number);
        });
      }
    }
  }

  // Довольно больная функция получилась, разбей ее на несколько
  List<Widget> setChoiceWidget(int start, [int end]) {
    final List<Widget> list = [];
    if (end == null) {
      for (int i = 0; i < 42; i++) {
        list.add(Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: colorChoiceWidget[i] == null ? Colors.transparent : colorChoiceWidget[i],
            borderRadius: const BorderRadius.all(Radius.circular(22.5)),
          ),
        ));
      }
    } else {
      for (int i = 0; i < 42; i++) {
        if (i == start) {
          list.add(Container(
            height: 40,
            width: 44,
            decoration: BoxDecoration(
              color: colorChoiceWidget[i] == null ? Colors.transparent : colorChoiceWidget[i],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(22.5), bottomLeft: Radius.circular(22.5)),
            ),
          ));
        }
        if (i == end) {
          if (date[i].dateTime.weekday == 1) {
            list.add(Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: colorChoiceWidget[i] == null ? Colors.transparent : colorChoiceWidget[i],
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ));
          } else {
            list.add(Container(
              height: 40,
              width: 44,
              decoration: BoxDecoration(
                color: colorChoiceWidget[i] == null ? Colors.transparent : colorChoiceWidget[i],
                borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
            ));
          }
        }
        if (i != start && i != end) {
          if (date[i].dateTime.weekday == 1) {
            list.add(Container(
              height: 40,
              width: 44,
              decoration: BoxDecoration(
                color: colorChoiceWidget[i] == null ? Colors.transparent : colorChoiceWidget[i],
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
              ),
            ));
          }
          if (date[i].dateTime.weekday == 7) {
            list.add(Container(
              height: 40,
              width: 44,
              decoration: BoxDecoration(
                color: colorChoiceWidget[i] == null ? Colors.transparent : colorChoiceWidget[i],
                borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
            ));
          }
          if (date[i].dateTime.weekday != 1 && date[i].dateTime.weekday != 7) {
            list.add(Container(
              height: 40,
              width: 44,
              decoration: BoxDecoration(
                color: colorChoiceWidget[i] == null ? Colors.transparent : colorChoiceWidget[i],
              ),
            ));
          }
        }
      }
    }

    return list;
  }
}
