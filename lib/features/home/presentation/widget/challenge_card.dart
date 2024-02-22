import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

class ChallengeCard extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final ChallangeItemEntity item;
  final void Function(ChallangeItemEntity item) onChallengeTap;
  const ChallengeCard({
    Key? key,
    this.padding,
    required this.item,
    required this.onChallengeTap,
  }) : super(key: key);

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  final ChallengeCubit challengeCubit = ChallengeCubit();
  bool isJoinded = false;
  bool isLoading = false;
  @override
  void initState() {
    isJoinded = widget.item.isJoined!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildContent(),
        // _buildBackgroundImage(),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return PositionedDirectional(
        end: 0,
        top: 0,
        bottom: 0,
        child: IgnorePointer(
          child: SizedBox(
              width: 100.h,
              height: 100.h,
              child: Image.network(widget.item.imageUrl!)),
        ));
  }

  Widget _buildContent() {
    return Positioned(
      child: InkWell(
        onTap: () => widget.onChallengeTap(widget.item),
        child: Container(
          width: 1.sw,
          decoration: const BoxDecoration(
            color: AppColors.mansourLightRed,
            // image: DecorationImage(
            //   image: NetworkImage(
            //     widget.item.imageUrl!,
            //   ),
            // ),
          ),
          padding: EdgeInsets.all(
            50.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.current.challenge,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                ),
              ),
              Gaps.vGap32,
              SizedBox(
                width: 0.4.sw,
                child: Text(
                 AppConfig().isLTR ?  widget.item.enTitle! : widget.item.arTitle!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 45.sp,
                  ),
                ),
              ),
              Gaps.vGap32,
              Text(
                AppConfig().isLTR ?  widget.item.enDescription! : widget.item.arDescription!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              Gaps.vGap32,
              _buildButtonsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Row(
      children: [
        BlocListener<ChallengeCubit, ChallengeState>(
          bloc: challengeCubit,
          listener: (context, state) {
            state.mapOrNull(joinOrUnSucess: (_) {
              setState(() {
                isLoading = false;
                print("ereeeo1");
              });
              widget.onChallengeTap(widget.item);
            }, joinLoadingState: (_) {
              setState(() {
                print("ereeeo2");

                isLoading = true;
              });
            }, challengeErrorState: (_) {
              print("ereeeo3");
              setState(() {
                isLoading = false;
              });
            });
          },
          child: CustomMansourButton(
            padding: EdgeInsets.symmetric(
              horizontal: 45.w,
            ),
            height: 120.h,
            borderRadius: Radius.circular(25.r),
            backgroundColor: Colors.white,
            titleText: isJoinded
                ? Translation.current.un_join
                : Translation.current.join_now,
            titleStyle: TextStyle(
              color: AppColors.mansourLightRed,
              fontWeight: FontWeight.bold,
              fontSize: 35.sp,
            ),
            onPressed: () {
              setState(() {
                isJoinded = !isJoinded;
                print("joined${isJoinded}");
              });
              challengeCubit.joinOrUnJoinChallenges(
                  JoinRequest(id: widget.item.id!, join: isJoinded));
            },
          ),
        ),

        Gaps.hGap32,
        // CustomMansourButton(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 45.w,
        //   ),
        //   height: 120.h,
        //   borderRadius: Radius.circular(25.r),
        //   backgroundColor: AppColors.mansourLightRed,
        //   borderColor: Colors.white,
        //   titleText: "Not Interested",
        //   titleStyle: TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 35.sp,
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
  }
}
