import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
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
import 'package:starter_application/features/moment/presentation/state_m/provider/create_post_screen_notifier.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/features/upload/presentation/state_m/cubit/upload_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import 'create_post_screen_content.dart';

class CreatePostScreenParam {
  final VoidCallback? onPostCreated;

  /// If post !=  null then it is edit post
  final MomentItemEntity? post;
  final int? challengeId;

  CreatePostScreenParam({
    this.onPostCreated,
    this.post,
    this.challengeId,
  });
}

class CreatePostScreen extends StatefulWidget {
  static const routeName = "/CreatePostScreen";
  final CreatePostScreenParam param;

  const CreatePostScreen({Key? key, required this.param}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late CreatePostScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = CreatePostScreenNotifier(widget.param);
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      indicatorWidget: Material(
        color: Colors.transparent,
        child: TextWaitingWidget(
          Translation.current.uploading,
          textColor: Colors.white,
        ),
      ),
      child: ChangeNotifierProvider.value(
        value: sn,
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     print(sn.uploadedImages);
          //   },
          // ),
          appBar: buildCustomAppbar(
            // forgroundColor: AppColors.mansourBackArrowColor2,

            backgroundColor: AppColors.primaryColorLight,
            forgroundColor: Colors.white,
            actions: [
              BlocBuilder<MomentCubit, MomentState>(
                bloc: sn.createPostCubit,
                builder: (context, state) {
                  return state.maybeMap(
                      momentInitState: (_) => Center(
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
                                onPressed: sn.onCreatePostTap,
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
                                onPressed: sn.onCreatePostTap,
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
                                onPressed: sn.onCreatePostTap,
                              ),
                            ),
                          ),
                      orElse: () => const ScreenNotImplementedError());
                },
              ),
            ],
            bottom: widget.param.challengeId != null
                ? Container(
                    margin: EdgeInsets.only(
                      bottom: 30.h,
                      left: 0.1.sw,
                      right: 0.05.sw,
                    ),
                    child: Text(
                      Translation.current.verify_attendant,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                      ),
                    ),
                  )
                : SizedBox(),
            bottomSize: widget.param.challengeId != null
                ? Size(
                    1.sw,
                    200.h,
                  )
                : Size(
                    1.sw,
                    100.h,
                  ),
          ),
          backgroundColor: AppColors.mansourWhiteBackgrounColor_2,
          body: MultiBlocListener(listeners: [
            BlocListener<MomentCubit, MomentState>(
              bloc: sn.createPostCubit,
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
                    widget.param.onPostCreated?.call();
                  },
                  editPostLoaded: (s) {
                    sn.isLoading = false;
                    Nav.pop();
                    showSnackbar(Translation.current.update_post_success);
                    widget.param.onPostCreated?.call();
                  },
                );
              },
            ),
            BlocListener<UploadCubit, UploadState>(
              bloc: sn.uploadFileCubit,
              listener: (context, state) {
                state.mapOrNull(
                  uploadLoadingState: (_) => ProgressHUD.of(context)!.show(),
                  uploadErrorState: (s) {
                    ProgressHUD.of(context)!.dismiss();
                    ErrorViewer.showError(
                      context: context,
                      error: s.error,
                      callback: s.callback,
                    );
                  },
                  uploadImageLoaded: (s) {
                    ProgressHUD.of(context)!.dismiss();
                    sn.onUploadImageLoaded(s.uploadFileResponseEntity);
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
          ], child: const CreatePostScreenContent()),
        ),
      ),
    );
  }
}
