import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_stepper.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/food_details/food_details_nut_indecator.dart';
import 'package:starter_application/features/health/presentation/widget/food_details/ingeredient_item.dart';
import 'package:starter_application/features/health/presentation/widget/food_details/nut_info_widget.dart';
import 'package:starter_application/features/health/presentation/widget/food_info.dart';
import 'package:starter_application/features/health/presentation/widget/health_amount_unit_picker.dart';
import 'package:starter_application/features/health/presentation/widget/how_to_cook_stepper.dart';

import '../screen/../state_m/provider/reciepe_details_screen_notifier.dart';

class ReciepeDetailsScreenContent extends StatefulWidget {
  @override
  State<ReciepeDetailsScreenContent> createState() =>
      _ReciepeDetailsScreenContentState();
}

class _ReciepeDetailsScreenContentState
    extends State<ReciepeDetailsScreenContent>
    with SingleTickerProviderStateMixin {
  late ReciepeDetailsScreenNotifier sn;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ReciepeDetailsScreenNotifier>(context);
    sn.context = context;

    return Stack(
      children: [
        Container(
          height: .8.sh,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    30.r,
                  ),
                  child: Container(
                    height: 0.25.sh,
                    width: .9.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30.r,
                      ),
                    ),
                    child: Hero(
                      tag: 'hero${sn.recipeEntity.id}',
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${sn.recipeEntity.imageUrl}",
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error)),
                    ),
                  ),
                ),
              ),
              Gaps.vGap40,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${sn.recipeEntity.name}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 60.sp,
                  ),
                ),
              ),
              Gaps.vGap40,
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: _buildStandardServingPicker(),
              ),
              Gaps.vGap40,
              Align(
                alignment: AlignmentDirectional.center,
                child: TabBar(
                  controller: tabController,
                  labelStyle: TextStyle(
                    color: AppColors.mansourLightGreenColor,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  labelColor: AppColors.mansourLightGreenColor,
                  unselectedLabelStyle: TextStyle(
                    color: AppColors.accentColorLight,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: AppColors.accentColorLight,
                  indicatorColor: AppColors.mansourLightGreenColor,
                  indicatorWeight: 3,
                  labelPadding: EdgeInsetsDirectional.only(
                    bottom: 64.h,
                    end: 70.w,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  tabs: [
                    const Text(
                      "Food Info",
                    ),
                    const Text(
                      "Ingredients",
                    ),
                    const Text(
                      "How to Cook",
                    ),
                  ],
                ),
              ),
              Gaps.vGap40,
              _buildTabBarView()
              /*  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About the food",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                      ),
                    ),
                    Gaps.vGap32,
                    Text(
                      '${sn.recipeEntity.about}',
                      style: TextStyle(
                        color: AppColors.accentColorLight,
                        fontSize: 37.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap40,
              const Divider(
                height: 1,
                color: AppColors.accentColorLight,
                thickness: 0.5,
              ),
              Gaps.vGap40,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Nutritions Info",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp,
                  ),
                ),
              ),
              Gaps.vGap40,
              Container(
                height: 300.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sn.nutritionModels.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FoodDetailsNutIndecator(
                        height: 180.h,
                        width: 180.h,
                        title: sn.nutritionModels[index].title,
                        value: sn.nutritionModels[index].value,
                        totalValue: sn.nutritionModels[index].totalValue,
                        color: sn.colorList[index],
                        showPercent: sn.nutritionModels[index].showPercent,
                      ),
                    );
                  },
                ),
              ),
              Gaps.vGap32,
              const Divider(
                height: 1,
                color: AppColors.accentColorLight,
                thickness: 0.5,
              ),
              Gaps.vGap32,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sn.nutritionModels.length - 1,
                  itemBuilder: (context, index) {
                    return NutInfoWidget(
                      nutritionModelUi: sn.nutritionModels[index + 1],
                    );
                  },
                ),
              ),
              Gaps.vGap32,*/
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, .95),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<HealthCubit, HealthState>(
              bloc: sn.healthCubit,
              listener: (context, state) {
                if (state is DailyDishCreated) {
                  sn.onDailyDisheat();
                }
              },
              builder: (context, state) {
                return state.maybeMap(
                  checkHealthProfileDone: (s)=> const ScreenNotImplementedError()  ,
                  healthDashboardLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  updateDailyWater: (s) => const ScreenNotImplementedError(),
                  updateGoal: (s) => const ScreenNotImplementedError(),
                  dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
                  goalUpdated: (s) => const ScreenNotImplementedError(),
                  recommendedSessionLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  favoriteSessionsLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  dailySessionCreated: (s) => const ScreenNotImplementedError(),
                  dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
                  recommendedFoodLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  favoriteDishesLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  favoriteRecipesLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  profileUpdated: (s) => const ScreenNotImplementedError(),
                  updateProfile: (s) => const ScreenNotImplementedError(),
                  createProfile: (s) => const ScreenNotImplementedError(),
                  answerQuestion: (s) => const ScreenNotImplementedError(),
                  questionAnswered: (s) => const ScreenNotImplementedError(),
                  profileCreated: (s) => const ScreenNotImplementedError(),
                  questionLoaded: (s) => const ScreenNotImplementedError(),
                  recipeListLoaded: (s) => const ScreenNotImplementedError(),
                  dishListLoaded: (s) => const ScreenNotImplementedError(),
                  healthInitState: (s) => CustomMansourButton(
                    titleText: "Eat This",
                    textColor: Colors.white,
                    backgroundColor: AppColors.mansourDarkGreenColor2,
                    titleFontWeight: FontWeight.bold,
                    onPressed: () {
                      sn.eatFood();
                    },
                    height: 150.h,
                  ),
                  healthLoadingState: (s) => WaitingWidget(),
                  createDailyDish: (s) => const TextWaitingWidget(
                    'Create your Daily Dish',
                    textColor: AppColors.mansourDarkOrange,
                  ),
                  uploadImage: (s) => const TextWaitingWidget(
                    'Eating this dish',
                  ),
                  dailyDishCreated: (s) => CustomMansourButton(
                    titleText: "Eat This",
                    textColor: Colors.white,
                    backgroundColor: AppColors.mansourDarkGreenColor2,
                    titleFontWeight: FontWeight.bold,
                    onPressed: () {
                      sn.eatFood();
                    },
                    height: 150.h,
                  ),
                  healthErrorState: (s) => ErrorScreenWidget(
                    error: s.error,
                    callback: s.callback,
                  ),
                  foodCategoriesLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
                  dishLoaded: (s) => const ScreenNotImplementedError(),
                  recipeLoaded: (s) => const ScreenNotImplementedError(),
                  sessionListLoaded: (s) => const ScreenNotImplementedError(),
                  orElse: ()=> CustomMansourButton(
                    titleText: "Eat This",
                    textColor: Colors.white,
                    backgroundColor: AppColors.mansourDarkGreenColor2,
                    titleFontWeight: FontWeight.bold,
                    onPressed: () {
                      sn.eatFood();
                    },
                    height: 150.h,
                  )
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStandardServingPicker() {
    return HealthAmountUnitPicker(units: [
      "standard servings (${sn.recipeEntity.standardServingAmount}gr)",
    ], hint: "servings");
  }

  Widget _buildTabBarView() {
    switch (tabController.index) {
      case 0:
        return _buildFoodInfo();
      case 1:
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sn.recipeEntity.ingredients.length,
          itemBuilder: (context, index) {
            return IngredientItem(
              name: '${sn.recipeEntity.ingredients[index].name}',
              amount: sn.recipeEntity.ingredients[index].amount,
              unitOfMeasurement:
                  '${sn.recipeEntity.ingredients[index].unitOfMeasurement}',
            );
          },
        );
      case 2:
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomStepper(
              steps: sn.howToCookSteps,
              selectedLineColor: AppColors.accentColorLight,
            ),
          ),
        );
    }
    return const SizedBox.shrink();
  }

  Widget _buildFoodInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About the food",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                ),
              ),
              Gaps.vGap32,
              Html(
                data: sn.recipeEntity.about,
              ),

            ],
          ),
        ),
        Gaps.vGap40,
        const Divider(
          height: 1,
          color: AppColors.accentColorLight,
          thickness: 0.5,
        ),
        Gaps.vGap40,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Nutritions Info",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 50.sp,
            ),
          ),
        ),
        Gaps.vGap40,
        Container(
          height: 300.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: sn.nutritionModels.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FoodDetailsNutIndecator(
                  height: 180.h,
                  width: 180.h,
                  title: sn.nutritionModels[index].title,
                  value: sn.nutritionModels[index].value,
                  totalValue: sn.nutritionModels[index].totalValue,
                  color: sn.colorList[index],
                  showPercent: sn.nutritionModels[index].showPercent,
                ),
              );
            },
          ),
        ),
        Gaps.vGap32,
        const Divider(
          height: 1,
          color: AppColors.accentColorLight,
          thickness: 0.5,
        ),
        Gaps.vGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: sn.nutritionModels.length - 1,
            itemBuilder: (context, index) {
              return NutInfoWidget(
                nutritionModelUi: sn.nutritionModels[index + 1],
                color: sn.colorList[index + 1],
              );
            },
          ),
        ),
        Gaps.vGap32,
      ],
    );
  }
}
