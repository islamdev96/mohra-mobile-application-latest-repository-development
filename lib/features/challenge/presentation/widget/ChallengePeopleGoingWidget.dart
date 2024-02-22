import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_list_pile.dart';
import 'package:starter_application/features/event/domain/entity/event_client_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_divider_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class ChallengesPeopleGoingWidget extends StatefulWidget {
  final int? peopleGoing;
  final List<EventClientEntity> clients;
  const ChallengesPeopleGoingWidget(
      {Key? key, required this.peopleGoing, required this.clients})
      : super(key: key);

  @override
  State<ChallengesPeopleGoingWidget> createState() =>
      _ChallengesPeopleGoingWidgetState();
}

class _ChallengesPeopleGoingWidgetState
    extends State<ChallengesPeopleGoingWidget> {
  List<EventClientEntity> _clients = [];

  @override
  void initState() {
    super.initState();
    _clients = widget.clients.toSet().toList();
    for (int i = 0; i < _clients.length; i++) if (i > 4) _clients.removeAt(i);
  }

  @override
  Widget build(BuildContext context) {
    double radius = 150.w;
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
                if (widget.peopleGoing != 0)
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
                                imgPath: e.imageUrl,
                              )),
                        )
                        .toList(),
                    (widget.peopleGoing ?? 0) > 4
                        ? _buildPile(
                            radius,
                            Container(
                              color: AppColors.primaryColorLight,
                              child: Center(
                                child: Text(
                                  '+${((widget.peopleGoing ?? 0) - 4).toString()}',
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
