import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/story_details_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/presentation/screen/my_life_video_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/mylife_audio_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/single_story_screen.dart';

class StoryWidget extends StatefulWidget {
  StoryWidget({
    Key? key,
    this.item,
    required this.icon,
    required this.isAudio,
    required this.isVideo,
    required this.name,
    required this.image,
    required this.onTap,
  }) : super(key: key);
  final String icon;
  final String name;
  final String image;
  final bool isAudio;
  final bool isVideo;
  final Function() onTap;
  final StoryItemEntity? item;

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  final LikeCubit likeCubit = LikeCubit();
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.item!.isLiked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 160.h,
                    width: 160.h,
                    decoration: widget.item!.imageUrl!.isNotEmpty
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.item!.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  if (widget.item!.stroyType == "Video")
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 90.h,
                          width: 90.h,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColorLight,
                            shape: BoxShape.circle,
                          ),
                          child: LayoutBuilder(builder: (context, cons) {
                            return InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap:widget.onTap,
                              child: Center(
                                child: SizedBox(
                                  height: 60.h,
                                  width: 60.h,
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                ],
              ),
              Gaps.hGap32,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: widget.onTap,
                      child: Text(
                        widget.item!.title!,
                        style:
                            TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gaps.vGap24,
                    BlocListener<LikeCubit, LikeState>(
                      bloc: likeCubit,
                      listener: (context, state) {
                        state.mapOrNull(
                          likeCreatedState: (value) {
                            widget.item!.isLiked = true;
                            setState(() {});
                          },
                          unlikeCreatedState: (value) {
                            widget.item!.isLiked = false;
                            setState(() {});
                          },
                          likeErrorState: (value) {
                            widget.item!.isLiked = false;
                            ErrorViewer.showError(
                              context: context,
                              error: value.error,
                              callback: () {},
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (!widget.item!.isLiked!)
                                likeCubit.like(LikeRequest(
                                    refId: widget.item!.id!.toString(),
                                    refType: 6));
                              else{
                                likeCubit
                                    .unlike(LikeRequest(refId: widget.item!.id!.toString(), refType: 6));
                              }
                            },
                            child: SizedBox(
                                width: 60.h,
                                height: 60.h,
                                child: SvgPicture.asset(
                                  AppConstants.SVG_LIKE_MY_LIFE,
                                  color: widget.item!.isLiked!
                                      ? AppColors.primaryColorLight
                                      : AppColors.mansourNotSelectedBorderColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
