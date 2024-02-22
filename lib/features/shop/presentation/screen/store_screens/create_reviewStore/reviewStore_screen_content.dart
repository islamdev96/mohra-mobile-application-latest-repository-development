import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/widget/health_amount_unit_picker.dart';
import 'package:starter_application/features/moment/presentation/widget/pick_images_grid.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/reviewStore_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class CreateReviewStoreScreenContent extends StatefulWidget {
  SingleStorePageParam param;
  CreateReviewStoreScreenContent(this.param);
  @override
  State<CreateReviewStoreScreenContent> createState() =>
      _CreateReviewStoreScreenContentState();
}

class _CreateReviewStoreScreenContentState
    extends State<CreateReviewStoreScreenContent> {
  late ReviewStoreScreenNotifier sn;
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
    sn = Provider.of<ReviewStoreScreenNotifier>(context);

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
                  Divider(color: Colors.black),
                  Gaps.vGap32,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child:
                                Text(Translation.of(context).Professionalism)),
                        Expanded(
                          child: RatingBar.builder(
                            itemSize: 50.h,
                            initialRating: sn.profesionalismRate.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.mansourDarkOrange3,
                            ),
                            onRatingUpdate: (rating) {
                              sn.profesionalismRate = rating.toInt();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(Translation.of(context).Wait_Time)),
                        Expanded(
                          child: RatingBar.builder(
                            itemSize: 50.h,
                            initialRating: sn.waitTimeRate.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.mansourDarkOrange3,
                            ),
                            onRatingUpdate: (rating) {
                              sn.waitTimeRate = rating.toInt();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(Translation.of(context).Experience)),
                        Expanded(
                          child: RatingBar.builder(
                            itemSize: 50.h,
                            initialRating: sn.experienceRate.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.mansourDarkOrange3,
                            ),
                            onRatingUpdate: (rating) {
                              sn.experienceRate = rating.toInt();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(Translation.of(context).Value)),
                        Expanded(
                          child: RatingBar.builder(
                            itemSize: 50.h,
                            initialRating: sn.valueRate.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.mansourDarkOrange3,
                            ),
                            onRatingUpdate: (rating) {
                              sn.valueRate = rating.toInt();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap50,
                  Divider(color: Colors.black),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                    title: Translation.of(context).Write_your_review,
                    child: _buildTextField(
                      hintText: "",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textEditingController: sn.writeReviewController,
                      focusNode: sn.writeReviewFocusNode,
                      key: sn.writeReviewKey,
                    ),
                  ),
                  Gaps.vGap64,
                  _buildTitleContentWidget(
                      title: Translation.of(context).Upload_Images,
                      child: PickImagesGrid(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        onImagesPicked: sn.onImagesPicked,
                        onImageDeleted: sn.onImageDeleted,
                        imagesPaths: sn.imagesPaths,
                        cameraButtonIcon: AppConstants.SVG_CAMERA_FILL2,
                        cameraButtonColor: AppColors.mansourDarkGreenColor3,
                        cameraButtonBackgroundColor:
                            AppColors.mansourLightGreenColor.withOpacity(
                          0.05,
                        ),
                        maxImagesCount: 4,
                      )),
                  Gaps.vGap64,
                ],
              ),
              Column(
                children: [
                  BlocConsumer<ShopCubit, ShopState>(
                      bloc: sn.storCubit,
                      listener: (context, state) {
                        state.mapOrNull(
                            shopErrorState: (s) => ErrorViewer.showError(
                                  context: context,
                                  error: s.error,
                                  callback: s.callback,
                                ),
                            reviewProductLodedState: (s) {
                              Nav.pop(context, true);

                              showSnackbar(
                                  Translation.current.create_review_success);
                            });
                      },
                      builder: (context, state) {
                        return state.maybeMap(
                          shopInitState: (s) => CustomMansourButton(
                            backgroundColor: AppColors.primaryColorLight,
                            titleText: Translation.of(context).Review,
                            onPressed: () {
                              sn.onCreateReviewPressed();
                            },
                          ),
                          addingToCart: (s) => WaitingWidget(),
                          shopLoadingState: (s) => WaitingWidget(),
                          shopErrorState: (s) => CustomMansourButton(
                            backgroundColor: AppColors.primaryColorLight,
                            titleText: Translation.of(context).Review,
                            onPressed: () {
                              sn.onCreateReviewPressed();
                            },
                          ),
                          searchLodedState: (s) => Container(),
                          homeStoreLodedState: (s) => Container(),
                          storeCategoryLodedState: (s) => Container(),
                          getProductsLoaded: (s) => Container(),
                          singleStoreLodedState: (s) => Container(),
                          productItemLodedState: (s) => Container(),
                          reviewProductLodedState: (s) => Container(),
                          orElse: () => const ScreenNotImplementedError(),
                        );
                      }),

                  // BlocConsumer<HealthCubit, HealthState>(
                  //   bloc: sn.healthCubit,
                  //   listener: (context, state) {
                  //     if (state is CreateDailyDish) {
                  //       sn.onImageUploaded(state.imageUrlsEntity);
                  //     }
                  //     if (state is DailyDishCreated) {
                  //       sn.onDailyDishCreated();
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     return state.map(
                  //         healthInitState: (s) => CustomMansourButton(
                  //               backgroundColor: AppColors.primaryColorLight,
                  //               titleText: "Rate",
                  //               onPressed: () {
                  //                 sn.onSavePressed();
                  //               },
                  //             ),
                  //         healthLoadingState: (s) => WaitingWidget(),
                  //         createDailyDish: (s) => const TextWaitingWidget(
                  //               'Create your Daily Dish',
                  //             ),
                  //         uploadImage: (s) => const TextWaitingWidget(
                  //               'Create your Daily Dish',
                  //             ),
                  //         dailyDishCreated: (s) => CustomMansourButton(
                  //               backgroundColor: AppColors.primaryColorLight,
                  //               titleText: "Rate",
                  //               onPressed: () {
                  //                 sn.onSavePressed();
                  //               },
                  //             ),
                  //         healthErrorState: (s) => ErrorScreenWidget(
                  //               error: s.error,
                  //               callback: s.callback,
                  //             ),
                  //         foodCategoriesLoaded: (s) =>
                  //             const ScreenNotImplementedError(),
                  //         dailyDishListLoaded: (s) =>
                  //             const ScreenNotImplementedError(),
                  //         recipeListLoaded: (s) => Container(),
                  //         dishListLoaded: (s) => Container(),
                  //       recipeLoaded: (s) =>
                  //       const ScreenNotImplementedError(),
                  //       dishLoaded: (s) =>
                  //       const ScreenNotImplementedError(),

                  //     );
                  //   },
                  // ),
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
                Translation.current.price,
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
                hint: Translation.current.currency,
                valueFlex: 7,
                unitFlex: 4,
              ),
              Gaps.vGap64,
              Text(
                Translation.current.payment,
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
                    Translation.current.pay_with_wallet,
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
          Translation.current.track_in_wallet,
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
    required TextInputType keyboardType,
    required TextEditingController textEditingController,
    required FocusNode focusNode,
    required GlobalKey<FormFieldState<String>> key,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      key: key,
      controller: textEditingController,
      focusNode: focusNode,
      textInputAction: textInputAction ?? TextInputAction.done,
      keyboardType: keyboardType,
      maxLines: 3,
      style: TextStyle(
        color: Colors.black,
        fontSize: 50.sp,
      ),
      decoration: InputDecoration(
        fillColor: AppColors.mansourLightGreyColor_2,
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
      validator: (v) {
        if (v != null && v.trim().isNotEmpty) return null;
        return Translation.current.errorEmptyField;
      },
    );
  }
}
