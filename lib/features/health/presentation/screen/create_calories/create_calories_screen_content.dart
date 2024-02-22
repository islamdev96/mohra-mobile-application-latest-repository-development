import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/create_calories_screen_notifier.dart';
import 'package:starter_application/features/health/presentation/widget/health_amount_unit_picker.dart';
import 'package:starter_application/features/moment/presentation/widget/pick_images_grid.dart';
import 'package:starter_application/generated/l10n.dart';

class CreateCaloriesScreenContent extends StatefulWidget {
  @override
  State<CreateCaloriesScreenContent> createState() =>
      _CreateCaloriesScreenContentState();
}

class _CreateCaloriesScreenContentState
    extends State<CreateCaloriesScreenContent> {
  late CreateCaloriesScreenNotifier sn;
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      30.r,
    ),
    borderSide: const BorderSide(
      color: AppColors.mansourLightGreyColor_10,
    ),
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CreateCaloriesScreenNotifier>(context);

    sn.context = context;
    return LayoutBuilder(builder: (context, cons) {
      return SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.current.Upload_a_picture_of_the_dish,
                    child: PickImagesGrid(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      onImagesPicked: sn.onImagesPicked,
                      imagesPaths: sn.imagesPaths,
                      cameraButtonIcon: AppConstants.SVG_CAMERA_FILL2,
                      cameraButtonColor: AppColors.mansourDarkGreenColor3,
                      cameraButtonBackgroundColor:
                          AppColors.mansourLightGreenColor.withOpacity(
                        0.05,
                      ),
                      maxImagesCount: 1,
                      onImageDeleted: sn.onImageDeleted,
                    ),
                  ),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.current.name,
                    child: _buildTextField(
                        hintText: Translation.current.enter_name,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        textEditingController: sn.nameController,
                        isNumber: false
                    ),
                  ),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.current.calories + ' ' + Translation.current.optional,
                    child: _buildTextField(
                      hintText: Translation.current.enter_food_calories,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textEditingController: sn.caloriesController,
                    ),
                  ),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.current.fat + ' ' + Translation.current.optional,
                    child: _buildTextField(
                      hintText: Translation.current.enter_fats,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      textEditingController: sn.fatController,
                    ),
                  ),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.current.carbs + ' ' + Translation.current.optional,
                    child: _buildTextField(
                      hintText: Translation.current.enter_carbs,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      textEditingController: sn.carbsController,
                    ),
                  ),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.current.protein + ' ' + Translation.current.optional,
                    child: _buildTextField(
                      hintText: Translation.current.enter_protein,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      textEditingController: sn.protenController,
                    ),
                  ),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.current.date,
                    child: Stack(
                      children: [
                        _buildTextField(
                          keyboardType: TextInputType.none,
                          textInputAction: TextInputAction.none,
                          hintText: '${sn.createDateTime}',
                        ),
                        GestureDetector(
                          onTap: () async {
                            sn.onDatePick();
                          },
                          child: Container(
                            height: 150.h,
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ),
                  Gaps.vGap64,
                ],
              ),
              Column(
                children: [
                  BlocConsumer<HealthCubit, HealthState>(
                    bloc: sn.healthCubit,
                    listener: (context, state) {
                      if (state is CreateDailyDish) {
                        sn.onImageUploaded(state.imageUrlsEntity);
                      }
                      if (state is DailyDishCreated) {
                        sn.onDailyDishCreated();
                      }
                    },
                    builder: (context, state) {
                      return state.maybeMap(
                        checkHealthProfileDone: (s) =>
                            const ScreenNotImplementedError(),
                        healthDashboardLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        updateDailyWater: (s) =>
                            const ScreenNotImplementedError(),
                        updateGoal: (s) => const ScreenNotImplementedError(),
                        dailyWaterUpdated: (s) =>
                            const ScreenNotImplementedError(),
                        goalUpdated: (s) => const ScreenNotImplementedError(),
                        recommendedSessionLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        favoriteSessionsLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        dailySessionCreated: (s) =>
                            const ScreenNotImplementedError(),
                        dailySessionsLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        recommendedFoodLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        favoriteDishesLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        favoriteRecipesLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        profileUpdated: (s) =>
                            const ScreenNotImplementedError(),
                        updateProfile: (s) => const ScreenNotImplementedError(),
                        createProfile: (s) => const ScreenNotImplementedError(),
                        answerQuestion: (s) =>
                            const ScreenNotImplementedError(),
                        questionAnswered: (s) =>
                            const ScreenNotImplementedError(),
                        profileCreated: (s) =>
                            const ScreenNotImplementedError(),
                        questionLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        recipeListLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        dishListLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        healthInitState: (s) => CustomMansourButton(
                          backgroundColor: sn.canSave()
                              ? AppColors.mansourLightGreenColor
                              : AppColors.mansourLightGreyColor_3,
                          titleText: Translation.current.save,
                          onPressed: () {
                            sn.onSavePressed();
                          },
                        ),
                        healthLoadingState: (s) => WaitingWidget(),
                        createDailyDish: (s) => TextWaitingWidget(
                          Translation.current.created_daily_dish,
                        ),
                        uploadImage: (s) => TextWaitingWidget(
                          Translation.current.created_daily_dish,
                        ),
                        dailyDishCreated: (s) => CustomMansourButton(
                          backgroundColor: sn.canSave()
                              ? AppColors.mansourLightGreenColor
                              : AppColors.mansourLightGreyColor_3,
                          titleText: Translation.current.save,
                          onPressed: () {
                            sn.onSavePressed();
                          },
                        ),
                        healthErrorState: (s) => CustomMansourButton(
                          backgroundColor: sn.canSave()
                              ? AppColors.mansourLightGreenColor
                              : AppColors.mansourLightGreyColor_3,
                          titleText: Translation.current.save,
                          onPressed: () {
                            sn.onSavePressed();
                          },
                        ),
                        foodCategoriesLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        dailyDishListLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        dishLoaded: (s) => const ScreenNotImplementedError(),
                        recipeLoaded: (s) => const ScreenNotImplementedError(),
                        sessionListLoaded: (s) =>
                            const ScreenNotImplementedError(),
                        orElse: ()=>CustomMansourButton(
                          backgroundColor: sn.canSave()
                              ? AppColors.mansourLightGreenColor
                              : AppColors.mansourLightGreyColor_3,
                          titleText: Translation.current.save,
                          onPressed: () {
                            sn.onSavePressed();
                          },
                        )
                      );
                    },
                  ),
                  Gaps.vGap64,
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTitleContentWidget(
      {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 50.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.vGap32,
        child,
      ],
    );
  }

  Widget _buildTrackInWallet() {
    return Column(
      children: [
        _buildTrackInWalletRow(),
        if (sn.isTrackWalletOn)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap96,
              Text(
                "Price",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.vGap32,
              HealthAmountUnitPicker(
                units: [
                  "USD",
                  "SR",
                  "SP",
                ],
                hint: "currency",
                valueFlex: 7,
                unitFlex: 4,
              ),
              Gaps.vGap64,
              Text(
                "Payment",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.vGap32,
              CustomListTile(
                onTap: () {},
                padding: EdgeInsets.all(
                  40.h,
                ),
                backgroundColor: AppColors.mansourLightGreyColor_4,
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
                leadingFlex: 1,
                leading: SizedBox(
                  height: 90.h,
                  width: 90.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_MY_WALLET,
                    color: AppColors.primaryColorLight,
                  ),
                ),
                title: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 50.w,
                  ),
                  child: Text(
                    "Pay With My Wallet",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildTrackInWalletRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Track In Wallet ?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        FlutterSwitch(
          height: 80.h,
          width: 150.w,
          value: sn.isTrackWalletOn,
          onToggle: sn.onTrackWalletSwitchChange,
          activeColor: AppColors.mansourLightGreenColor,
          inactiveColor: AppColors.mansourLightGreyColor_3,
          toggleColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String hintText,
    TextInputAction? textInputAction,
    required TextInputType keyboardType,
     TextEditingController? textEditingController,
    bool isNumber = true,
  }) {
    return TextField(
      controller: textEditingController,
      textInputAction: textInputAction ?? TextInputAction.done,
      keyboardType: keyboardType,
      inputFormatters: isNumber ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'),),FilteringTextInputFormatter.deny(RegExp('[۰-۹]'))] : [],
      style: TextStyle(
        color: Colors.black,
        fontSize: 50.sp,
      ),
      decoration: InputDecoration(
        border: border,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        hintStyle: TextStyle(
          color: AppColors.mansourLightGreyColor_3,
          fontSize: 50.sp,
        ),
        hintText: hintText,
      ),
    );
  }
}
