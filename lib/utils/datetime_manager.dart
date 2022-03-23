class DateTimeManager {
  final DateTime _dateTime = DateTime.now();

  String getDate() {
    return '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}';
  }

  String getTime() {
    return '${_dateTime.hour}:${_dateTime.minute}:${_dateTime.second}';
  }

  String getDateTime() {
    return '${getDate()} ${getTime()}';
  }

}
