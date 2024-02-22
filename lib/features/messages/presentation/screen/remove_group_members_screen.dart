import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/params/screen_params/remove_group_member_params.dart';

import '../screen/../state_m/provider/remove_group_members_screen_notifier.dart';
import 'remove_group_members_screen_content.dart';

class RemoveGroupMembersScreen extends StatefulWidget {
  static const String routeName = "/RemoveGroupMembersScreen";
  final RemoveGroupMemberParams params;
  const RemoveGroupMembersScreen({Key? key, required this.params})
      : super(key: key);

  @override
  _RemoveGroupMembersScreenState createState() =>
      _RemoveGroupMembersScreenState();
}

class _RemoveGroupMembersScreenState extends State<RemoveGroupMembersScreen> {
  final sn = RemoveGroupMembersScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.params = widget.params;
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RemoveGroupMembersScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColorLight,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: RemoveGroupMembersScreenContent(initialNotifier: sn,),
      ),
    );
  }
}
