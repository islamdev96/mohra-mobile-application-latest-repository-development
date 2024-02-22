import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';

import 'challenge_card.dart';

final padding = EdgeInsets.symmetric(
  horizontal: 50.w,
);

class AllChallengeWidget extends StatelessWidget {
  final double height;
  final bool isLoading;
  final ScrollController scrollController;
  final List<ChallangeItemEntity> items;
  final void Function(ChallangeItemEntity item) onChallengeTap;
  const AllChallengeWidget({
    Key? key,
    required this.items,
    required this.height,
    required this.isLoading,
    required this.scrollController,
    required this.onChallengeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) return const SizedBox.shrink();
    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Row(
          children: [
            ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Nav.to(EventDetailsScreen.routeName,
                      //     arguments: EventDetailsScreenParams(
                      //         eventEntity: events.elementAt(index)));
                    },
                    child: ChallengeCard(
                      padding: EdgeInsets.all(padding.left),
                      item: items[index],
                      onChallengeTap: onChallengeTap,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 50.w,
                  );
                },
                itemCount: items.length),
            isLoading
                ? Shimmer.fromColors(
                    child: Container(
                      width: 0.7.sw,
                      height: 0.2.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        color: AppColors.shimmerBaseColor,
                      ),
                    ),
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.shimmerHighlightColor)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
