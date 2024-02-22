import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/section_intro.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/health_intro_screen_notifier.dart';

class HealthIntroScreenContent extends StatefulWidget {
  @override
  State<HealthIntroScreenContent> createState() =>
      _HealthIntroScreenContentState();
}

class _HealthIntroScreenContentState extends State<HealthIntroScreenContent> {
  late HealthIntroScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HealthIntroScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<HealthCubit, HealthState>(
        bloc: sn.healthCubit,
        listener: (context, state) {
          if (state is CheckHealthProfileDone) {
            sn.onHealthProfileChecked(state.checkHealthProfileEntity);
          }
        },
        builder: (context, state) {
          return state.maybeMap(
            dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
            goalUpdated: (s) => const ScreenNotImplementedError(),
            recommendedSessionLoaded: (s) => const ScreenNotImplementedError(),
            favoriteSessionsLoaded: (s) => const ScreenNotImplementedError(),
            dailySessionCreated: (s) => const ScreenNotImplementedError(),
            dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
            recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
            favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
            favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
            healthDashboardLoaded: (s) => const ScreenNotImplementedError(),
            updateDailyWater: (s) => const ScreenNotImplementedError(),
            updateGoal: (s) => const ScreenNotImplementedError(),
            profileUpdated: (s) => const ScreenNotImplementedError(),
            updateProfile: (s) => const ScreenNotImplementedError(),
            createProfile: (s) => const ScreenNotImplementedError(),
            profileCreated: (s) => const ScreenNotImplementedError(),
            questionLoaded: (s) => const ScreenNotImplementedError(),
            answerQuestion: (s) => const ScreenNotImplementedError(),
            questionAnswered: (s) => const ScreenNotImplementedError(),
            recipeListLoaded: (s) => const ScreenNotImplementedError(),
            dishListLoaded: (s) => const ScreenNotImplementedError(),
            healthInitState: (s) => const ScreenNotImplementedError(),
            healthLoadingState: (s) => const TextWaitingWidget(
              'Checking Data, please wait',
            ),
            createDailyDish: (s) => const ScreenNotImplementedError(),
            uploadImage: (s) => const ScreenNotImplementedError(),
            dailyDishCreated: (s) => const ScreenNotImplementedError(),
            healthErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            foodCategoriesLoaded: (s) => const ScreenNotImplementedError(),
            dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
            dishLoaded: (s) => const ScreenNotImplementedError(),
            recipeLoaded: (s) => const ScreenNotImplementedError(),
            sessionListLoaded: (s) => const ScreenNotImplementedError(),
            checkHealthProfileDone: (s) => SectionIntro(
              title: "${dayTimeTitle()}\n${UserSessionDataModel.name}",
              bottomDescription: Translation.current.health_intro_message,
              image: AppConstants.IMG_HEALTH_INTRO2,
              buttonTitle: Translation.current.start,
              buttonColor: AppColors.mansourDarkGreenColor,
              onTap: sn.onStartTap,
            ),
            orElse: ()=> SectionIntro(
              title: "${dayTimeTitle()}\n${UserSessionDataModel.name}",
              bottomDescription: Translation.current.health_intro_message,
              image: AppConstants.IMG_HEALTH_INTRO2,
              buttonTitle: Translation.current.start,
              buttonColor: AppColors.mansourDarkGreenColor,
              onTap: sn.onStartTap,
            )
          );
        });
  }
}
