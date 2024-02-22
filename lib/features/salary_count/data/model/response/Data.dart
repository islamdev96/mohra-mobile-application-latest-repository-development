import 'Fractiontime.dart';

class Data {
  Data({
      required this.id,
    required  this.title,
    required  this.eventtime,
    required this.userid,
    required this.createdtime,
    required this.modifiedtime,
    required this.displaytime,
    required this.fractiontime,
    required  this.isPast,
    required  this.remainingdays,});


  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    eventtime = json['eventtime'];
    userid = json['userid'];
    createdtime = json['createdtime'];
    modifiedtime = json['modifiedtime'];
    displaytime = json['displaytime'];
    fractiontime = (json['fractiontime'] != null ? Fractiontime.fromJson(json['fractiontime']) : null)!;
    isPast = json['isPast'];
    remainingdays = json['remainingdays'];
  }
  late String id;
  late String title;
  late String eventtime;
  late  String userid;
  late String createdtime;
  dynamic modifiedtime;
  late String displaytime;
  late Fractiontime fractiontime;
  late  bool isPast;
  late  int remainingdays;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['eventtime'] = eventtime;
    map['userid'] = userid;
    map['createdtime'] = createdtime;
    map['modifiedtime'] = modifiedtime;
    map['displaytime'] = displaytime;
    if (fractiontime != null) {
      map['fractiontime'] = fractiontime.toJson();
    }
    map['isPast'] = isPast;
    map['remainingdays'] = remainingdays;
    return map;
  }

}