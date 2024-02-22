import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import '../../domain/entity/event_tickets_entity.dart';
import '../screen/../state_m/provider/attendance_screen_notifier.dart';
import 'attendance_screen_content.dart';

class AttendanceScreen extends StatefulWidget {
  static const String routeName = "/AttendanceScreen";
  late EventTickettEntity eventTickettEntity;
  AttendanceScreen({Key? key,required this.eventTickettEntity}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final sn = AttendanceScreenNotifier();

  @override
  void initState() {
    sn.eventTickettEntity = widget.eventTickettEntity;
    sn.getTicketDetails();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AttendanceScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AttendanceScreenContent(),
      ),
    );
  }
}
