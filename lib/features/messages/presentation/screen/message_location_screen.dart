import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/message_location_screen_notifier.dart';
import 'message_location_screen_content.dart';

class LocationMessageScreen extends StatefulWidget {
  static const String routeName = "/LocationMessageScreen";

  const LocationMessageScreen({Key? key}) : super(key: key);

  @override
  _LocationMessageScreenState createState() => _LocationMessageScreenState();
}

class _LocationMessageScreenState extends State<LocationMessageScreen> {
  final sn = MessageLocationScreenNotifier();
  final customMapModel = CustomMapModel();
  late final mapFuture;

  @override
  void initState() {
    super.initState();
    mapFuture = _buildMapScreenContent();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    customMapModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageLocationScreenNotifier>.value(
      value: sn,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<MessageLocationScreenNotifier>.value(
            value: sn,
          ),
          ChangeNotifierProvider.value(
            value: customMapModel,
          ),
        ],
        child: Scaffold(
          appBar: buildCustomAppbar(
            title: Text(
              Translation.current.share_location,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50.sp,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppConstants.SVG_SEARCH,
                      color: AppColors.white,
                      height: 70.h,
                      width: 70.h,
                    ),
                    Gaps.hGap16,
                    SvgPicture.asset(
                      AppConstants.SVG_REFRESH,
                      color: AppColors.white,
                      height: 70.h,
                      width: 70.h,
                    ),
                  ],
                ),
              ),
            ],
            gradient: const LinearGradient(
              begin: AlignmentDirectional.topEnd,
              end: AlignmentDirectional.topStart,
              colors: AppColors.healthOrangeGradiant,
            ),
            forgroundColor: AppColors.white,
          ),
          body: Container(
            height: 1.sh,
            width: 1.sw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topEnd,
                end: AlignmentDirectional.topStart,
                colors: AppColors.healthOrangeGradiant,
              ),
            ),
            child: _buildMapScreenFutureBuilder(),
          ),
        ),
      ),
    );
  }

  Widget _buildMapScreenFutureBuilder() {
    return FutureBuilder<Widget>(
        future: mapFuture,
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return WaitingWidget();
          }
        });
  }

  Future<Widget> _buildMapScreenContent() async {
    await sn.setMarkersIcons();

    return const MessageLocationScreenContent();
  }
}
