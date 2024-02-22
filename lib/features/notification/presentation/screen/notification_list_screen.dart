import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/notification/presentation/state_m/cubit/notification_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/notification_list_screen_notifier.dart';
import 'notification_list_screen_content.dart';

class NotificationListScreen extends StatefulWidget {
  static const String routeName = "/NotificationListScreen";

  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  final sn = NotificationListScreenNotifier();

  @override
  void initState() {
    // BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false).refreshNotificationsNumber();
    sn.getNotifications();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      indicatorWidget: Material(
        color: Colors.transparent,
        child: TextWaitingWidget(
          Translation.current.claiming_rewards,
          textColor: Colors.white,
        ),
      ),
      child: ChangeNotifierProvider.value(
        value: sn,
        child: MultiBlocListener(
          listeners: [
            BlocListener<NotificationCubit, NotificationState>(
              bloc: sn.notificationCubit,
              listener: (context, state) {
                if(state is NotificationLoaded){
                  sn.NotificationsLoaded(state.notificationResultEntity);
                  sn.loading(false);
                }
                if(state is NotificationError) {
                   sn.loading(false);
                   ErrorViewer.showError(
                     context: context,
                     error: state.error,
                     callback: state.callback,
                   );
                 }
              },
            )
          ],
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: buildAppbar(
              title: Translation.current.notification,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopupMenuButton<int>(
                    itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text(Translation.current.Delete_all_notifications),
                          onTap: () {
                            sn.deleteAllMyNotification();
                          },
                        ),
                    ],
                    onSelected: (value) {

                    },
                    child: SvgPicture.asset(
                      AppConstants.SVG_MORE_VERTICAL,
                      color: Colors.black,
                    ),
                  ),
                ),
              ]
            ),
            body: BlocBuilder<NotificationCubit, NotificationState>(
              bloc: sn.notificationCubit,
              builder: (context, state) {
                if(state is NotificationLoading)
                  return  WaitingWidget();
                if(state is NotificationLoaded)
                  return  NotificationListScreenContent();
                if(state is NotificationError)
                  return ErrorScreenWidget(error: state.error, callback: state.callback);
                return const SizedBox();
              },
            ),
          ),
        ),),
    );
  }
}
