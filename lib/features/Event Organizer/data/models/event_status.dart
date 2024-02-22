



import 'package:flutter/material.dart';

class EventStatus {
  final String? avatar;
  final String? userName;
  final String? eventId;
  final String? status;
  final Color? color;

  EventStatus({this.avatar,this.userName,this.eventId,this.color = const Color(0xFFF2F4F7), this.status});
}