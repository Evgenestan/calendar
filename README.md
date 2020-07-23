Flutter calendar use a overlay window to select a range of date on mobile.

You can choose a date range.

![alt tag](https://sun9-62.userapi.com/c855016/v855016763/23fda4/jLh3BMwIkhE.jpg "date range selected.")​

Or you can choose one date.

![alt tag](https://sun9-55.userapi.com/c855016/v855016763/23fdb4/gJHQSNhge9c.jpg "One date selected.")​



Usage 
import 'package:calendar/custom_calendar.dart';
...


 

      GestureDetector(
          onTap:() => CustomCalendar(context,disabledDate: disabledDate),
          child: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: StreamBuilder<List<DateTime>>(
                stream: selectedDates,
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.hasData) {
                    final text = dateFormat(snapshot);
                    return Text(text);
                  }
                  return const Text('Выберите дату');
                },
              ),
            ),
          ),
        )

...

Properties

borderColor - Color
Color for calendar border.

enabledWorkdayColor - Color
Text color for selectable workday days.

disabledWorkdayColor - Color
Text color for unavailable workday days.

enabledHolidayColor - Color
Text color for selectable weekends.

disabledHolidayColor - Color
Text color for unavailable holidays.

Please note that Saturday and Sunday are always unavailable weekends.

inversionWorkdayColor - Color
Text color for the selected workday.

inversionHolidayColor - Color
Text color for the selected weekend.

primaryTextColor - Color
Text color for the month.

secondaryTextColor - Color
Text color for year.

roundColor - Color
Fill color of the selected date.

disabledRoundColor - Color
Fill color for a date that is not selectable but falls within the range.

disabledDate - List<Day>
List of non-selectable days or holidays.

class Day {
  DateTime dateTime;
  bool isHoliday;
  bool isDisabled;
}







  

