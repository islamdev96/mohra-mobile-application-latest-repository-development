import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_list_pile.dart';
import 'package:starter_application/features/event/domain/entity/event_client_entity.dart';
import 'package:starter_application/generated/l10n.dart';

import 'event_divider_widget.dart';

class EventPeopleGoingWidget extends StatefulWidget {
  final int? likeCount;
  final int? commentCount;
  final Function onCommentSectionTap;
  final bool isLiked;
  final Function(bool like) like;
  final int? peopleGoing;
  final List<EventClientEntity> clients;
  const EventPeopleGoingWidget(
      {Key? key,
      required this.onCommentSectionTap,
      required this.isLiked,
      required this.like,
      required this.likeCount,
      required this.commentCount,
      required this.peopleGoing,
      required this.clients})
      : super(key: key);

  @override
  State<EventPeopleGoingWidget> createState() => _EventPeopleGoingWidgetState();
}

class _EventPeopleGoingWidgetState extends State<EventPeopleGoingWidget> {
  final _likeIconSize = 80.h;
  List<EventClientEntity> _clients = [];
  var _likeSizePercent = 1.0;

  @override
  void initState() {
    super.initState();
    refreshClient();
  }

  refreshClient(){
    _clients = widget.clients.toSet().toList();
    for (int i = 0; i < _clients.length; i++) if (i > 1) _clients.removeAt(i);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double radius = 150.w;
    refreshClient();
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.of(context).who_is_going,
                  style: const TextStyle(color: AppColors.accentColorLight),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: radius,
                  child: CustomListPile(images: [
                    ..._clients
                        .map(
                          (e) => _buildPile(
                              radius,
                              CustomNetworkImageWidget(
                                imgPath: e.imageUrl != '' ? e.imageUrl : e.avatar?.avatarUrl??"",
                              )),
                        )
                        .toList(),
                    (widget.peopleGoing ?? 0) > 2
                        ? _buildPile(
                            radius,
                            Container(
                              color: AppColors.primaryColorLight,
                              child: Center(
                                child: Text(
                                  '+${((widget.peopleGoing ?? 0) - 2).toString()}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ], radius: radius, space: radius * 0.6),
                ),
              ],
            ),
          ),
          EventDividerWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Row(
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _likeIconSize * _likeSizePercent,
                      width: _likeIconSize * _likeSizePercent,
                      onEnd: () {
                        setState(() {
                          _likeSizePercent = 1;
                        });
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (UserSessionDataModel.userType ==
                                UserType.CLIENT) {
                              setState(() {
                                _likeSizePercent = 1.2;
                                widget.like(!widget.isLiked);
                              });
                            }
                          },
                          child: SvgPicture.asset(
                            widget.isLiked
                                ? AppConstants.SVG_LIKE_FILL
                                : AppConstants.SVG_LIKE,
                          ),
                        ),
                      ),
                    ),
                    Gaps.hGap32,
                    Text(
                      "${(widget.likeCount ?? 0)} " + Translation.current.likes,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gaps.hGap64,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    widget.onCommentSectionTap();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 80.h,
                        width: 80.h,
                        child: SvgPicture.asset(
                          AppConstants.SVG_MESSAGE_SQUARE,
                        ),
                      ),
                      Gaps.hGap32,
                      Text(
                        "${(widget.commentCount ?? 0)} " +
                            Translation.current.comments,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          EventDividerWidget(),
        ],
      ),
    );
  }

  Widget _buildPile(double radius, Widget child) {
    return Container(
      height: radius,
      width: radius,
      color: Colors.white,
      child: Center(
        child: ClipOval(
          child: Container(
            height: radius * 0.9,
            width: radius * 0.9,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
