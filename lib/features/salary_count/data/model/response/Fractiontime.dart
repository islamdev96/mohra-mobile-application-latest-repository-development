class Fractiontime {
  Fractiontime({
      required this.date,
    required this.month,
    required this.year,
    required  this.hour,
    required  this.minute,
    required   this.second,});

  Fractiontime.fromJson(dynamic json) {
    date = json['date'];
    month = json['month'];
    year = json['year'];
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
  }
  late String date;
  late String month;
  late String year;
  late String hour;
  late String minute;
  late String second;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['month'] = month;
    map['year'] = year;
    map['hour'] = hour;
    map['minute'] = minute;
    map['second'] = second;
    return map;
  }

}