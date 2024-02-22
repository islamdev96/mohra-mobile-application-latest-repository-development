import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/food_category/food_category_grid_view.dart';
import 'package:starter_application/generated/l10n.dart';

import '../state_m/provider/food_categories_screen_notifier.dart';

class FoodCategoriesScreenContent extends StatefulWidget {
  @override
  State<FoodCategoriesScreenContent> createState() =>
      _FoodCategoriesScreenContentState();
}

class _FoodCategoriesScreenContentState
    extends State<FoodCategoriesScreenContent> {
  late FoodCategoriesScreenNotifier sn;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FoodCategoriesScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: AppConstants.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap64,
          _buildSearchTextfield(),
          Gaps.vGap96,
          _buildCategoryGridView(),
        ],
      ),
    );
  }

  /// Widgets

  Widget _buildSearchTextfield() {
    return SearchTextField(
      textKey: GlobalKey(),
      controller: TextEditingController(),
      focusNode: FocusNode(),
      backgroundColor: AppColors.mansourLightGreyColor_4,
      iconColor: AppColors.mansourLightGreyColor_8,
      hint: Translation.current.search_food,
      onChange: (value) {
        sn.searchText = value;
      },
      onFieldSubmitted: (value) {
        sn.searchFoodCategories();
      },
    );
  }

  Widget _buildCategoryGridView() {
    return BlocConsumer<HealthCubit, HealthState>(
      bloc: sn.healthCubit,
      listener: (context, state) {
        if (state is FoodCategoriesLoaded) {
          sn.onCategoriesLoaded(state.foodCategoriesEntity);
        }
      },
      builder: (context, state) {
        return state.maybeMap(
          recommendedSessionLoaded: (s) => const ScreenNotImplementedError(),
          dailySessionCreated: (s) => const ScreenNotImplementedError(),
          favoriteSessionsLoaded: (s) => const ScreenNotImplementedError(),
          checkHealthProfileDone: (s) => const ScreenNotImplementedError(),
          dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
          goalUpdated: (s) => const ScreenNotImplementedError(),
          healthDashboardLoaded: (s) => const ScreenNotImplementedError(),
          updateDailyWater: (s) => const ScreenNotImplementedError(),
          updateGoal: (s) => const ScreenNotImplementedError(),
          dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
          recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
          favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
          favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
          profileUpdated: (s) => const ScreenNotImplementedError(),
          updateProfile: (s) => const ScreenNotImplementedError(),
          answerQuestion: (s) => const ScreenNotImplementedError(),
          questionAnswered: (s) => const ScreenNotImplementedError(),
          dishLoaded: (s) => const ScreenNotImplementedError(),
          sessionListLoaded: (s) => const ScreenNotImplementedError(),
          recipeLoaded: (s) => const ScreenNotImplementedError(),
          recipeListLoaded: (s) => const ScreenNotImplementedError(),
          healthInitState: (s) => WaitingWidget(),
          healthLoadingState: (s) => WaitingWidget(),
          createDailyDish: (s) => const ScreenNotImplementedError(),
          uploadImage: (s) => const ScreenNotImplementedError(),
          dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
          dailyDishCreated: (s) => const ScreenNotImplementedError(),
          dishListLoaded: (s) => const ScreenNotImplementedError(),
          createProfile: (s) => const ScreenNotImplementedError(),
          profileCreated: (s) => const ScreenNotImplementedError(),
          questionLoaded: (s) => const ScreenNotImplementedError(),
          healthErrorState: (s) => ErrorScreenWidget(
            error: s.error,
            callback: s.callback,
          ),
          foodCategoriesLoaded: (s) => Expanded(
            child: FoodCategoryGridView(
              foodCategoryEntity: sn.categories,
              foodType: sn.foodType,
            ),
          ),
          orElse: ()=>Expanded(
            child: FoodCategoryGridView(
              foodCategoryEntity: sn.categories,
              foodType: sn.foodType,
            ),
          ),
        );
      },
    );
  }
}
