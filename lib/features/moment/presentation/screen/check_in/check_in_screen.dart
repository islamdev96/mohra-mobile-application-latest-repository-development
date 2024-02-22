import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/check_in_screen_notifier.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import 'check_in_screen_content.dart';

class CheckInScreenParam {
  final VoidCallback? onCheckInCreated;

  /// If post !=  null then it is edit post
  final MomentItemEntity? post;
  final int? challengeId;

  CheckInScreenParam({
    this.onCheckInCreated,
    this.post,
    this.challengeId,
  });
}

class CheckInScreen extends StatefulWidget {
  static const routeName = "/CheckInScreen";
  final CheckInScreenParam param;

  const CheckInScreen({Key? key, required this.param}) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  late CheckInScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = CheckInScreenNotifier(widget.param);
    sn.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sn,
      builder: (context, _) {
        return Scaffold(
          appBar: buildCustomAppbar(
            // forgroundColor: AppColors.mansourBackArrowColor2,
            backgroundColor: AppColors.primaryColorLight,
            forgroundColor: Colors.white,
            actions: [
              BlocBuilder<MomentCubit, MomentState>(
                bloc: sn.createFeelingCubit,
                builder: (context, state) {
                  context.select<CheckInScreenNotifier, bool>(
                      (value) => value.isLoading);
                  return state.maybeMap(
                      momentInitState: (_) => Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: 50.w,
                              ),
                              child: sn.isLoading
                                  ? WaitingWidget()
                                  : CustomMansourButton(
                                      height: 90.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 50.w,
                                      ),
                                      backgroundColor: Colors.white,
                                      titleText: Translation.current.post,
                                      titleStyle: TextStyle(
                                        color: AppColors.primaryColorLight,
                                        fontSize: 50.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onPressed: sn.onCreateCheckInTap,
                                    ),
                            ),
                          ),
                      momentLoadingState: (_) => Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: 50.w,
                            ),
                            child: WaitingWidget(),
                          ),
                      createPostLoaded: (_) => Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: 50.w,
                              ),
                              child: CustomMansourButton(
                                height: 90.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50.w,
                                ),
                                backgroundColor: Colors.white,
                                titleText: Translation.current.post,
                                titleStyle: TextStyle(
                                  color: AppColors.primaryColorLight,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                onPressed: sn.onCreateCheckInTap,
                              ),
                            ),
                          ),
                      momentErrorState: (_) => Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: 50.w,
                              ),
                              child: CustomMansourButton(
                                height: 90.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50.w,
                                ),
                                backgroundColor: Colors.white,
                                titleText: Translation.current.post,
                                titleStyle: TextStyle(
                                  color: AppColors.primaryColorLight,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                onPressed: sn.onCreateCheckInTap,
                              ),
                            ),
                          ),
                      orElse: () => const ScreenNotImplementedError());
                },
              ),
            ],
            centerTitle: false,

            title: Text(
              Translation.current.how_are_you_feeling,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: AppColors.mansourWhiteBackgrounColor_2,
          body: MultiBlocListener(listeners: [
            BlocListener<MomentCubit, MomentState>(
              bloc: sn.createFeelingCubit,
              listener: (context, state) {
                state.mapOrNull(
                  momentLoadingState: (_) => sn.isLoading = true,
                  momentErrorState: (s) {
                    sn.isLoading = false;
                    ErrorViewer.showError(
                      context: context,
                      error: s.error,
                      callback: s.callback,
                    );
                  },
                  createPostLoaded: (s) {
                    sn.isLoading = false;
                    Nav.pop();
                    showSnackbar(Translation.current.create_post_success);
                    widget.param.onCheckInCreated?.call();
                  },
                  editPostLoaded: (s) {
                    sn.isLoading = false;
                    Nav.pop();
                    showSnackbar(Translation.current.update_post_success);
                    widget.param.onCheckInCreated?.call();
                  },
                );
              },
            ),
            BlocListener<PlaceCubit, PlaceState>(
              bloc: sn.reverseGeocodingCubit,
              listener: (context, state) {
                state.mapOrNull(
                  placeErrorState: (s) {
                    ErrorViewer.showError(
                      context: context,
                      error: s.error,
                      callback: s.callback,
                    );
                  },
                  reverseGeocodingLoaded: (s) {
                    sn.onReverseGeocodingLoaded(s.reverseGeocodingEntity);
                  },
                );
              },
            ),
          ], child: const CheckInScreenContent()),
        );
      },
    );
  }
}
