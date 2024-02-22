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
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/food_details/food_details_nut_indecator.dart';
import 'package:starter_application/features/health/presentation/widget/food_details/nut_info_widget.dart';
import 'package:starter_application/features/health/presentation/widget/food_info.dart';
import 'package:starter_application/features/health/presentation/widget/health_amount_unit_picker.dart';

import '../screen/../state_m/provider/food_details_screen_notifier.dart';

class FoodDetailsScreenContent extends StatefulWidget {
  @override
  State<FoodDetailsScreenContent> createState() =>
      _FoodDetailsScreenContentState();
}

class _FoodDetailsScreenContentState extends State<FoodDetailsScreenContent> {
  late FoodDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FoodDetailsScreenNotifier>(context);
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
                      tag: 'hero${sn.dishEntity.id}',
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${sn.dishEntity.imageUrl}",
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
                  "${sn.dishEntity.name}",
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
                      data: sn.dishEntity.about,

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
                      color: sn.colorList[index +1],
                    );
                  },
                ),
              ),
              Gaps.vGap32,
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, .95),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: BlocConsumer<HealthCubit, HealthState> (
              bloc: sn.healthCubit,
              listener: (context, state) {
                if(state is DailyDishCreated){
                  sn.onDailyDisheat();
                }
              },
              builder: (context, state) {
                return state.maybeMap(
                  checkHealthProfileDone: (s)=> const ScreenNotImplementedError()  ,
                  healthDashboardLoaded:(s)=> const ScreenNotImplementedError()  ,
                  updateDailyWater: (s)=> const ScreenNotImplementedError() ,
                  updateGoal: (s)=> const ScreenNotImplementedError() ,
                  dailyWaterUpdated: (s)=> const ScreenNotImplementedError()  ,
                  goalUpdated: (s)=> const ScreenNotImplementedError()  ,
                  recommendedSessionLoaded:(s)=> const ScreenNotImplementedError()  ,
                  favoriteSessionsLoaded:(s)=> const ScreenNotImplementedError() ,
                  dailySessionCreated: (s)=> const ScreenNotImplementedError() ,
                  dailySessionsLoaded: (s)=> const ScreenNotImplementedError() ,
                  recommendedFoodLoaded:(s)=> const ScreenNotImplementedError() ,
                  favoriteDishesLoaded: (s)=> const ScreenNotImplementedError() ,
                  favoriteRecipesLoaded: (s)=> const ScreenNotImplementedError() ,
                  profileUpdated:(s)=> const ScreenNotImplementedError() ,
                  updateProfile: (s)=> const ScreenNotImplementedError(),
                  createProfile:  (s)=> const ScreenNotImplementedError(),
                  answerQuestion:  (s)=> const ScreenNotImplementedError(),
                  questionAnswered:  (s)=> const ScreenNotImplementedError(),
                  profileCreated:   (s)=> const ScreenNotImplementedError(),
                  questionLoaded:   (s)=> const ScreenNotImplementedError(),
                  recipeListLoaded: (s)=> const ScreenNotImplementedError() ,
                  dishListLoaded: (s)=> const ScreenNotImplementedError(),
                  healthInitState: (s) =>  CustomMansourButton(
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
                  createDailyDish: (s) =>
                  const TextWaitingWidget(
                    'Create your Daily Dish',
                    textColor: AppColors.mansourDarkOrange,
                  ),
                  uploadImage: (s) => const  TextWaitingWidget(
                    'Eating this dish',
                  ),
                  dailyDishCreated: (s) =>  CustomMansourButton(
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
                  foodCategoriesLoaded: (s) =>  const ScreenNotImplementedError(),
                  dailyDishListLoaded: (s) =>  const ScreenNotImplementedError(),
                  dishLoaded:  (s) =>  const ScreenNotImplementedError(),
                  recipeLoaded:  (s) =>  const ScreenNotImplementedError(),
                  sessionListLoaded: (s) =>  const ScreenNotImplementedError(),
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
      "standard servings (${sn.dishEntity.standardServingAmount}gr)",
    ], hint: "servings");
  }

}
