import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/health_count_screen_notifier.dart';

class HealthCountScreenContent extends StatefulWidget {
  @override
  State<HealthCountScreenContent> createState() =>
      _HealthCountScreenContentState();
}

class _HealthCountScreenContentState extends State<HealthCountScreenContent>
    with SingleTickerProviderStateMixin {
  late HealthCountScreenNotifier sn;

  final animationDuration = const Duration(
    milliseconds: 300,
  );

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        sn.startInitialTimer();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HealthCountScreenNotifier>(context);
    sn.context = context;
    return WillPopScope(
      onWillPop: (){
        return sn.onWillPopScope();
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return IgnorePointer(
      ignoring: sn.isPaused || sn.isFinishPhase,
      child: AnimatedOpacity(
        opacity: sn.isFinishPhase ? 0 : 1,
        duration: animationDuration,
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    _buildInitIalPhaseWidget(),
                  /*  _buildMainPhaseWidget(),*/
                  ],
                ),
              ),
              TextButton(
                onPressed: sn.onStopTap,
                child: Text.rich(
                  TextSpan(
                    text: Translation.current.cancel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Gaps.vGap128,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitIalPhaseWidget() {
    return IgnorePointer(
      ignoring: sn.isInitialPhase ? false : true,
      child: Visibility(
        visible: sn.isInitialPhase,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: "${sn.currentInitialTimerCount}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.4.sw,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                text: sn.getTitle(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.1.sw,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*  Widget _buildMainPhaseWidget()  {
    return IgnorePointer(
      ignoring: sn.isInitialPhase ? true : false,
      child: AnimatedOpacity(
        opacity: sn.isInitialPhase ? 0 : 1,
        duration: animationDuration,
        child: Column(
          children: [
            Gaps.vGap64,

          ],
        ),
      ),
    );
  }*/

  _buildPlayer(){
    return Container(
        constraints: BoxConstraints(
          maxHeight: 0.8.sh,
          minHeight: 0.8.sh
        ),
        child: Chewie(
          controller: sn.chewieController,
        ));
  }

}
