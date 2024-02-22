extension dt on DateTime {
  DateTime setTime(String time) {
    final extractedTime = time.split(":");
    final hour = int.tryParse(extractedTime[0])!;
    final minute = int.tryParse(extractedTime[1])!;
    return DateTime(this.year, this.month, this.day, hour, minute);
  }
}
