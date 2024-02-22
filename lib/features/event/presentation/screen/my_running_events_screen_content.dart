import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/event/domain/entity/my_running_events_list_entity.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/my_running_events_screen_notifier.dart';

class MyRunningEventsScreenContent extends StatefulWidget {
  @override
  State<MyRunningEventsScreenContent> createState() =>
      _MyRunningEventsScreenContentState();
}

class _MyRunningEventsScreenContentState
    extends State<MyRunningEventsScreenContent> {
  late MyRunningEventsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MyRunningEventsScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 60.w,
        vertical: 64.h,
      ),
      child: PaginationWidget<MyRunningEventEntity>(
        child: ListView.separated(
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
                bottom: index == sn.events.length - 1 ? 40.h : 0),
            child: _buildItem(sn.events.elementAt(index)),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 50.h,
          ),
          itemCount: sn.events.length,
        ),
        getItems: (unit) async {
          return sn.returnData(unit);
        },
        items: sn.events,
        onDataFetched: sn.onDataFetched,
        refreshController: sn.refreshController,
      ),
    );
  }

  Widget _buildItem(MyRunningEventEntity entity) {
    return CustomListTile(
      onTap: () => sn.gotoEventDetails(int.tryParse(entity.value ?? "") ?? -1),
      padding: EdgeInsets.all(
        50.h,
      ),
      borderRadius: BorderRadius.circular(
        20.r,
      ),
      backgroundColor: Colors.white,
      border: Border.all(
        color: Colors.grey,
      ),
      title: Text(
        entity.text ?? "",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
