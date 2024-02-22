import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/localization/localization_provider.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_card.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_header.dart';
import 'package:starter_application/features/moment/presentation/widget/post_card.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/view_friend_moments_screen_notifier.dart';

class ViewFriendMomentsScreenContent extends StatelessWidget {

  late ViewFriendMomentsScreenNotifier sn;

  double vLineStart = 0.12.sw;
  double vLineTop = 0.15.sh;
  double vLineWidth = 7.w;
  double _headerHeight = 0.25.sh;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ViewFriendMomentsScreenNotifier>(context);
    sn.context = context;
    return Stack(
      // fit: StackFit.loose,
      children: [

        _buildContent(),
        // _buildHeaderContent(),
      ],
    );
  }

  Widget _buildHeaderBackground(String? image) {
    return PositionedDirectional(
      top: 0,
      child: MomentHeader(height: _headerHeight, width: 1.sw,image: ((sn.moments.isNotEmpty ?(sn.moments?.first?.client?.id?? 0) : 0) == UserSessionDataModel.userId) ? UserSessionDataModel.coverPhoto :image??null,),
    );
  }

  Widget _buildHeaderContent() {
    return PositionedDirectional(
      top: vLineTop - 150.h,
      child: MomentCard(
        vLineStart: vLineStart,
        vLineWidth: vLineWidth,
        indicator: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Nav.pop();
              },
              child: Icon(
                AppConstants.getIconBack(),
                color: AppColors.white,
              ),
            ),
            Gaps.hGap16,
            ClipOval(
              child: GestureDetector(
                onTap: () {

                },
                child: CustomNetworkImageWidget(
                  imgPath: sn.friendObject.imageUrl,
                  height: 150.h,
                  width: 150.h,
                  boxFit: BoxFit.cover,
                  errorImage: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 100.h,
                  ) ,

                ),


              ),
            ),
          ],
        ),
        content: SizedBox(
          height: 100.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${sn.friendObject.fullName}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 65.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        indicatorWidth: 150.h,
      ),
    );
  }

  /// Content
  Widget _buildContent() {
    return Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      child: RefreshConfiguration(
        headerBuilder: () => ClassicHeader(
          refreshingIcon: Padding(
            padding: EdgeInsets.only(top: _headerHeight),
            child: SizedBox(
              height: 70.h,
              width: 70.h,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          releaseIcon: Padding(
            padding: EdgeInsets.only(top: _headerHeight),
            child: SizedBox(
              height: 70.h,
              width: 70.h,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 0,
          ),
        ),
        child: PaginationWidget<MomentItemEntity>(
          items: sn.moments,
          getItems: sn.getMomentsItems,
          onDataFetched: sn.onMomentsItemsFetched,
          refreshController: sn.momentsRefreshController,
          footer: ClassicFooter(
            loadingText: "",
            noDataText: Translation.current.noDataRefresher,
            failedText: Translation.current.failedRefresher,
            idleText: "",
            canLoadingText: "",
            /*  loadingIcon: Padding(
              padding: EdgeInsets.only(
                bottom: AppConstants.bottomNavigationBarHeight + 300.h,
              ),
              child: const CircularProgressIndicator.adaptive(),
            ), */
            height: AppConstants.bottomNavigationBarHeight + 300.h,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsetsDirectional.only(
              // end: AppConstants.screenPadding.right,
              bottom: 30.h,
            ),
            child: Stack(
              children: [
                if(sn.moments.isNotEmpty) _buildVLine(color: Colors.grey[300]),
                _buildHeaderBackground(sn.friendObject?.coverImage??""),
                _buildHeaderContent(),
                // if(sn.moments.isNotEmpty) _buildVLine(height: 80.h, color: Colors.grey[300]),
                Column(
                  children: [
                    SizedBox(
                      height: _headerHeight - 50.h,
                    ),
                    Container(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildPostCard(
                              sn.moments[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap15;
                          },
                          itemCount: sn.momentEntity.items!.length),
                    ),
                  ],
                ),
                // Gaps.vGap64,
                // _buildPostCard_2(),
                SizedBox(
                  height: AppConstants.bottomNavigationBarHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// PostCard
  Widget _buildPostCard(MomentItemEntity item) {
    return PostCard(
      vLineStart: vLineStart,
      vLineWidth: vLineWidth,
      item: item,
      viewInteractions: true,
      onPostCreated: (){},onOptionTap: (){

    },
      owner: checkOwner(item),
    );
  }
  bool checkOwner(MomentItemEntity item){
    return item.creatorUserId==UserSessionDataModel.userId;
  }

  /// PostCard
  // Widget _buildPostCard_2() {
  //   return PostCard(
  //     vLineStart: vLineStart,
  //     vLineWidth: vLineWidth,
  //     content: "I was there join the vision 2030 event",
  //     address: "69 Crooks Mission Apt. San Fransisco, CA94121",
  //     isChallenge: true,
  //   );
  // }

  /// Vertical line
  Widget _buildVLine({double? height, required Color? color}) {
    return Positioned.fill(
        right: AppConfig().isLTR ? 0 : vLineStart,
        left: AppConfig().isLTR ? vLineStart : 0,
        // right: AppConfig().isLTR ? 0 : vLineStart,
        top: vLineTop,
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: SizedBox(
            height: height,
            child: VerticalDivider(
              thickness: vLineWidth,
              width: 0,
              // color: AppColors.mansourLightGreyColor,
              color: color,
            ),
          ),
        ));
  }
}
