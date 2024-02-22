import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/info_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/to_stay_fit_stepper.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/health_result_screen_notifier.dart';

class HealthResultScreenContent extends StatefulWidget {
  @override
  State<HealthResultScreenContent> createState() =>
      _HealthResultScreenContentState();
}

class _HealthResultScreenContentState extends State<HealthResultScreenContent> {
  late HealthResultScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HealthResultScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<HealthCubit , HealthState>(
      bloc: sn.healthCubit,
      listener: (context,state){
        if(state is HealthResultsLoaded){
          sn.onResultsLoaded(state.healthResultResponseEntity);
        }
      },
      builder: (context,state){
          return state.maybeMap(
            healthLoadingState: (s)=> WaitingWidget(),
            healthInitState: (s)=> WaitingWidget(),
            healthErrorState: (s)=> ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            orElse: ()=> buildScreen(),
          );
      },
    ) ;
  }


  buildScreen(){
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: AppConstants.hPadding,
        right: AppConstants.hPadding,
        bottom: 32.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap96,
          Text(
            Translation.current.to_stay_fit,
            style: TextStyle(
              color: Colors.black,
              fontSize: 60.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.vGap64,
           ToStayFitStepper(
             caloriesBrun: sn.getCaloriesToBurn(),
             caloriesEat: sn.getCaloriesToEat(),
             steps: sn.getStepsToWalk(),
             water: sn.getWaterGlassesNumber(),
           ),
          Gaps.vGap64,
          _buildInfoWidget(),
          Gaps.vGap96,
          _buildContinueButton(),
        ],
      ),
    );
  }
  /// Widgets
  Widget _buildInfoWidget() {
    return InfoWidget(
      content: Translation.current.tracking_your_food,
      forgroundColor: AppColors.mansourDarkGreenColor,
      backgroundColor: AppColors.mansourDarkGreenColor,
      backgroundOpacity: 0.06,
      icon: SizedBox(
        height: 60.h,
        width: 60.h,
        child: SvgPicture.asset(
          AppConstants.SVG_INFO2,
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: CustomMansourButton(
        width: 300.h,
        borderRadius: Radius.circular(
          20.r,
        ),
        titleText: Translation.current.finish,
        backgroundColor: AppColors.mansourDarkGreenColor,
        onPressed: sn.onFinishTap,
      ),
    );
  }
}
