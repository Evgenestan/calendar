import 'custom_calendar.dart';
import 'global_variables.dart';

void closeCalendarAndSave(Map<int, bool> choice) {
  print(choice.containsValue(true));
  final List<DateTime> selectedDatesLocal = [];
  if (choice.containsValue(true)) {
    for (int i = 0; i < choice.length; i++) {
      if (choice[i]) {
        selectedDatesLocal.add(indexDay[i]);
      }
    }
    selectedDates.add(selectedDatesLocal);
  }
  overlayEntry.remove();
}
