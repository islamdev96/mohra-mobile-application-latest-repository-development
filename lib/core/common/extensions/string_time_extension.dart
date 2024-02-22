
extension StringToDate on String {
  DateTime setTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    return dateTime;
  }
}
