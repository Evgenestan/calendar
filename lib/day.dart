class Day {
  DateTime dateTime;
  bool isHoliday;
  bool isDisabled;
  Day(this.dateTime, {this.isHoliday = false, this.isDisabled = false}) {
    if (dateTime.weekday == 6 || dateTime.weekday == 7) {
      isHoliday = true;
      isDisabled = true;
    }
  }
}
