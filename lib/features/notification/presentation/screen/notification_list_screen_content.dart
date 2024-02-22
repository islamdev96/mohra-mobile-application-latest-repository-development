import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/notification_type.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/notification/presentation/widget/notification_card.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/notification_list_screen_notifier.dart';

class NotificationListScreenContent extends StatefulWidget {
  @override
  State<NotificationListScreenContent> createState() => _NotificationListScreenContentState();
}

class _NotificationListScreenContentState extends State<NotificationListScreenContent> {
  late NotificationListScreenNotifier sn;

  double vLineStart = 0.083.sw;

  double vLineTop = 0.05.sh;

  double vLineWidth = 7.w;

  double _headerHeight = 0.23.sh;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NotificationListScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          if(sn.notifications.isNotEmpty)
            _buildVLine(color: AppColors.greyHelp),
          sn.isLoading
              ? WaitingWidget()
              : PaginationWidget<NotificationEntity>(
            items: sn.notifications,
            getItems: sn.getNotificationsItems,
            onDataFetched: sn.onNotificationsItemsFetched,
            refreshController: sn.momentsRefreshController,
            footer: ClassicFooter(
              loadingText: "",
              noDataText: Translation.of(context).noDataRefresher,
              failedText: Translation.of(context).failedRefresher,
              idleText: "",
              canLoadingText: "",
              /*  loadingIcon: Padding(
                    padding: EdgeInsets.only(
                      bottom: AppConstants.bottomNavigationBarHeight + 300.h,
                    ),
                    child: const CircularProgressIndicator.adaptive(),
                  ), */
              height: AppConstants.bottomNavigationBarHeight + 300.h,
            ),
            child: ListView.separated(
              itemCount: sn.notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  key: const ValueKey(1),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    // dismissible: DismissiblePane(onDismissed: () {
                    //   sn.deleteNotificationById(sn.notifications[index].id!);
                    // }),
                    children:  [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        onPressed: (context){
                          sn.deleteNotificationById(sn.notifications[index].id!);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.close,
                      ),
                    ],
                  ),
                  child: NotificationCard(
                    notificationEntity: sn.notifications[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Gaps.vGap64;
              },
            ),



          )
        ],
      ),
    )
    ;
  }

  /// Vertical line
  Widget _buildVLine({double? height, required Color? color}) {
    return Positioned.fill(
        right: AppConfig().isLTR ? 0 : vLineStart,
        left: AppConfig().isLTR ? vLineStart : 0,
        // right: AppConfig().isLTR ? 0 : vLineStart,
        top: vLineTop,
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: SizedBox(
            height: height,
            child: VerticalDivider(
              thickness: vLineWidth,
              width: 0,
              // color: AppColors.mansourLightGreyColor,
              color: color,
            ),
          ),
        ));
  }

  /// Content
  Widget _buildContent() {
    return Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      child: RefreshConfiguration(
        headerBuilder: () => ClassicHeader(
          refreshingIcon: Padding(
            padding: EdgeInsets.only(top: _headerHeight),
            child: SizedBox(
              height: 70.h,
              width: 70.h,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          releaseIcon: Padding(
            padding: EdgeInsets.only(top: _headerHeight),
            child: SizedBox(
              height: 70.h,
              width: 70.h,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 0,
          ),
        ),
        child: PaginationWidget<NotificationEntity>(
          items: sn.notifications,
          getItems: sn.getNotificationsItems,
          onDataFetched: sn.onNotificationsItemsFetched,
          refreshController: sn.momentsRefreshController,
          footer: ClassicFooter(
            loadingText: "",
            noDataText: Translation.of(context).noDataRefresher,
            failedText: Translation.of(context).failedRefresher,
            idleText: "",
            canLoadingText: "",
            /*  loadingIcon: Padding(
              padding: EdgeInsets.only(
                bottom: AppConstants.bottomNavigationBarHeight + 300.h,
              ),
              child: const CircularProgressIndicator.adaptive(),
            ), */
            height: AppConstants.bottomNavigationBarHeight + 300.h,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            child: sn.notifications.length  > 0 ? Stack(
              children: [
                _buildVLine(color: AppColors.greyHelp),
                Container(
                  width: 1.sw,
                  height: 0.9.sh,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.separated(
                    itemCount: sn.notifications.length,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationCard(
                        notificationEntity: sn.notifications[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Gaps.vGap64;
                    },
                  ),
                ),
              ],
            ) : SizedBox(),
          ),
        ),
      ),
    );
  }
}
