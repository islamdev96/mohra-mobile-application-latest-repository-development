import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/presentation/state_m/provider/challenge_screen_notifier.dart';
import 'package:starter_application/features/challenge/presentation/widget/challenge_header.dart';
import 'package:starter_application/features/challenge/presentation/widget/complete_challenge_stepper.dart';
import 'package:starter_application/features/moment/presentation/screen/create_post_screen.dart';
import 'package:starter_application/generated/l10n.dart';

class ChallengeScreenContent extends StatefulWidget {
  ChallangeItemEntity item;
  ChallengeScreenContent({Key? key, required this.item}) : super(key: key);

  @override
  _ChallengeScreenContentState createState() => _ChallengeScreenContentState();
}

class _ChallengeScreenContentState extends State<ChallengeScreenContent> {
  late ChallengeScreenNotifier sn;
  var footerHeight = 0.25.sh;
  int currentStep = 0;
  Widget divider = Divider(
    color: AppColors.mansourLightGreyColor,
    height: 100.h,
    thickness: 1,
  );
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ChallengeScreenNotifier>(context);
    sn.context = context;
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppConstants.screenPadding,
            child: Column(
              children: [
                Gaps.vGap64,
                _buildHeader(sn.itemEntity.imageUrl),
                Gaps.vGap64,
                _buildBody(),
                SizedBox(
                  height: footerHeight,
                ),
              ],
            ),
          ),
        ),
        _buildFooter(),
      ],
    );
  }

  Widget _buildFooter() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: footerHeight,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomMansourButton(
                onPressed: () {
                  if (sn.itemEntity.currentStep == 1) sn.onFriendsTap(sn.itemEntity.id);
                },
                titleText: "${Translation.current.invite_friends}",
                titleFontWeight: FontWeight.bold,
              ),
              Gaps.vGap32,
              CustomMansourButton(
                onPressed: () {
                  if (sn.itemEntity.isJoined!)
                    sn.JoinOrUnjoin(sn.itemEntity.id!, false);
                },
                titleText: "${Translation.current.leave_cha}",
                textColor: AppColors.primaryColorLight,
                backgroundColor: Colors.white,
                titleFontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(image) {
    return ChallengeHeader(
      image: image,
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        Gaps.vGap32,
        _buildChallengeContent(),
        divider,
        _buildInfoColumn(),
        divider,
        _buildCompleteChallengeColumn(sn.itemEntity.id),
        divider,
        // if (widget.item.eventEntity!.bookedSeats != 0)
        //   _buildPeoplGoingToChallenge(),
        divider,
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      sn.itemEntity.title!,
      style: TextStyle(
        color: Colors.black,
        fontSize: 50.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildChallengeContent() {
    /*int wordPerLine = 10;
    int charPerWord = 4;
    int charPerLine = wordPerLine * charPerWord;
    int maxLines = 5;
    int lastLineWordCount = 2;

    int maxlength =
        charPerLine * (maxLines - 1) + lastLineWordCount * charPerWord;

    String content =
        "We people are part of the movement to make the vision come true so let’s all collaborate and we work together to achieve all of our ambitions always remember his royal highness saying that the sky is the limit! read more";

    content =
        content.length > maxlength ? content.substring(0, maxlength) : content;*/

    return Text.rich(
      TextSpan(
        text: sn.itemEntity.description,
        style: TextStyle(
          color: Colors.black,
          fontSize: 40.sp,
        ),
        // children: [
        //   TextSpan(
        //     text: "read more",
        //     style: TextStyle(
        //       color: AppColors.primaryColorLight,
        //       fontSize: 40.sp,
        //     ),
        //   ),
        // ]
      ),

    );
  }

  Widget _buildInfoColumn() {
    return Column(
      children: [
        _buildInfoItem(
          sn.itemEntity.organizer!,
          Translation.current.challenge_organizer,
            CustomNetworkImageWidget(
              imgPath: sn.itemEntity.imageUrlOfCreator,
            ),
        ),
        Gaps.vGap32,
        _buildInfoItem(
          "${sn.itemEntity.points} ${Translation.current.points} ",
          Translation.current.reward_join_challenge,
          Center(
            child: SizedBox(
              height: 100.h,
              width: 100.h,
              child: Image.asset(
                AppConstants.IMG_COIN,
              ),
            ),
          ),
        ),
        Gaps.vGap32,
        // _buildInfoItem(
        //   // "Sat, 4-Sun, 5 May 2020",
        //   DateFormat(
        //     'EEEE, MMM, y',
        //   ).format(widget.item.eventEntity!.fromDate!),
        //   "${DateFormat('hh:m').format(widget.item.eventEntity!.fromDate!)} - ${DateFormat('hh:m').format(widget.item.eventEntity!.toDate!)}",
        //   Center(
        //     child: SizedBox(
        //       height: 70.h,
        //       width: 70.h,
        //       child: SvgPicture.asset(
        //         AppConstants.SVG_CALENDAR,
        //         color: AppColors.primaryColorLight,
        //       ),
        //     ),
        //   ),
        // ),
        Gaps.vGap32,
        _buildInfoItem(
          sn.itemEntity.firstLocationLocationName ?? 'aassad',
          "${sn.targetLocationAddress}",
          Center(
            child: SizedBox(
              height: 70.h,
              width: 70.h,
              child: SvgPicture.asset(
                AppConstants.SVG_PIN,
                color: AppColors.primaryColorLight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
      String title,
      String subTitle,
      Widget trailing,
      ) {
    return CustomListTile(
      leading: Container(
        height: 150.h,
        width: 150.h,
        decoration: BoxDecoration(
          color: AppColors.mansourLightGreyColor,
          borderRadius: BorderRadius.circular(
            30.r,
          ),
        ),
        child: trailing,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          color: AppColors.mansourNotSelectedBorderColor,
          fontSize: 35.sp,
        ),
      ),
    );
  }

  /// Complete Challenge

  Widget _buildCompleteChallengeColumn(id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompleteChallengeTitle(),
        Gaps.vGap32,
        _buildCompleteChallengeSubtitle(),
        Gaps.vGap32,
        _buildCompleteChallengeStepper(id),
      ],
    );
  }

  Widget _buildCompleteChallengeTitle() {
    return Text(
      Translation.current.how_complete_cha,
      style: TextStyle(
        color: Colors.black,
        fontSize: 50.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCompleteChallengeSubtitle() {
    return Text(
      Translation.current.how_complete_cha_desc,
      style: TextStyle(
        color: AppColors.mansourNotSelectedBorderColor,
        fontSize: 40.sp,
      ),
    );
  }

  Widget _buildCompleteChallengeStepper(id) {
    return CompleteChallengeStepper(
      minNumberOfInvitation: sn.itemEntity.minNumOfInvitee?? 0,
      currentStep: sn.itemEntity.currentStep!,
      onJoinTap: () {
        sn.currentStep = 1;
        sn.JoinOrUnjoin(
            sn.itemEntity.id!, sn.itemEntity.isJoined! ? false : true);
      },
      onInviteFriendTap: () {
        if (sn.itemEntity.currentStep == 1) sn.onFriendsTap(sn.itemEntity.id);
      },
      onVerifyTap: () {
        sn.currentStep = 2;
        Nav.to(
          CreatePostScreen.routeName,
          arguments: CreatePostScreenParam(
            challengeId: sn.itemEntity.id,
            onPostCreated: sn.onVerifyPostCreated,
          ),
        );
      },
      onClaimRewardsTap: () {
        sn.currentStep = 3;
        sn.claimRewards(id);
      },
    );
  }

  /// People Going To Challenge
  // Widget _buildPeoplGoingToChallenge() {
  //   return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //     Text(
  //       "${widget.item.eventEntity!.bookedSeats} people going to this challenge",
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontSize: 40.sp,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     Gaps.vGap32,
  //     ChallengesPeopleGoingWidget(
  //       clients: widget.item.eventEntity!.clients,
  //       peopleGoing: widget.item.eventEntity!.bookedSeats!,
  //     ),
  //     Gaps.vGap32,
  //     // SizedBox(
  //     //   height: radius,
  //     //   child: CustomListPile(images: [
  //     //     _buildPile(
  //     //       radius,
  //     //       Image.asset(
  //     //         "assets/images/png/temp/profile-news2.png",
  //     //         fit: BoxFit.cover,
  //     //       ),
  //     //     ),
  //     //     _buildPile(
  //     //       radius,
  //     //       Image.asset(
  //     //         "assets/images/png/temp/profile-news2.png",
  //     //         fit: BoxFit.cover,
  //     //       ),
  //     //     ),
  //     //     _buildPile(
  //     //       radius,
  //     //       Image.asset(
  //     //         "assets/images/png/temp/profile-news2.png",
  //     //         fit: BoxFit.cover,
  //     //       ),
  //     //     ),
  //     //     _buildPile(
  //     //       radius,
  //     //       Image.asset(
  //     //         "assets/images/png/temp/profile-news2.png",
  //     //         fit: BoxFit.cover,
  //     //       ),
  //     //     ),
  //     //     _buildPile(
  //     //       radius,
  //     //       Container(
  //     //         color: AppColors.primaryColorLight,
  //     //         child: Center(
  //     //           child: Text(
  //     //             "+100",
  //     //             style: TextStyle(
  //     //                 color: Colors.white,
  //     //                 fontSize: 40.sp,
  //     //                 fontWeight: FontWeight.bold),
  //     //           ),
  //     //         ),
  //     //       ),
  //     //     ),
  //     //   ], radius: radius, space: radius * 0.6),
  //     // ),
  //   ]);
  // }

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
