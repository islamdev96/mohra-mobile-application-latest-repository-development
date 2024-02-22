import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/following_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

class FollowingScreenContent extends StatefulWidget {
  @override
  State<FollowingScreenContent> createState() => _FollowingScreenContentState();
}

class _FollowingScreenContentState extends State<FollowingScreenContent> {
  late FollowingScreenNotifier sn;
  final _likeIconSize = 80.h;
  var _likeSizePercent = 1.0;

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FollowingScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: sn.shops.length,
            itemBuilder: (context, index) {
              return _buildFollowingCard(sn.shops[index]);
            },
            separatorBuilder: (context, index) {
              return Gaps.vGap32;
            },
          ),
        ],
      ),
    );
  }

  _buildFollowingCard(ShopEntity shop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 30.h),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => sn.onShopTap(shop),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 100.h,
                            width: 100.h,
                            decoration: const BoxDecoration(
                              color: AppColors.accentColorLight,
                              shape: BoxShape.circle,
                            ),
                            child: shop.logoUrl != null &&
                                    shop.logoUrl!.trim().isNotEmpty
                                ? Image.network(shop.logoUrl!)
                                : const SizedBox.shrink(),
                          ),
                        ),
                        Gaps.hGap64,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap12,
                            Row(
                              children: [
                                SizedBox(
                                  height: 40.h,
                                  width: 40.h,
                                  child: SvgPicture.asset(
                                    AppConstants.SVG_FOLLOWING_TAG,
                                  ),
                                ),
                                Gaps.hGap32,
                                Text(
                                  shop.name ?? "",
                                  style: TextStyle(
                                      fontSize: 45.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Text(
                              "",
                              // shop.creationTime == null
                              //     ? ""
                              //     : timeago.format(
                              //         shop.creationTime!,
                              //         locale: AppConfig().appLanguage,
                              //       ),
                              style: TextStyle(
                                  fontSize: 35.sp,
                                  color: AppColors.mansourLightGreyColor_3),
                            )
                          ],
                        ),
                      ],
                    ),
                    /*SizedBox(
                      height: 50.h,
                      width: 50.h,
                      child: SvgPicture.asset(
                        AppConstants.SVG_Points,
                      ),
                    )*/
                  ],
                ),
              ),
              Gaps.vGap32,
              if(shop.description != "")...{
                const Divider(),
                Text(
                  shop.description, style: TextStyle(
                  color: AppColors.mansourLightGreyColor_3,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Gaps.vGap32,
                const Divider(),
              },
              Row(
                children: [
                  Row(
                    children: [
                      BlocBuilder<ShopCubit, ShopState>(
                        bloc: sn.followStoreCubit,
                        builder: (context, state) {
                          return state.maybeMap(
                            shopLoadingState: (_) => WaitingWidget(),
                            orElse: () => CustomMansourButton(
                              height: 90.h,
                              title: Text(
                                shop.isFollowed
                                    ? Translation.current.un_follow
                                    : Translation.of(context).Follow_Store,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: (){
                                sn.onFollowUnFollowStoreTap(shop);
                                setState(() {
                                  shop.isFollowed = !shop.isFollowed;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Gaps.hGap64,
                  InkWell(
                    onTap: ()=> sn.onCommentsTapped(shop.id!),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60.h,
                          width: 60.h,
                          child: SvgPicture.asset(
                            AppConstants.SVG_MESSAGE_SQUARE,
                            color: AppColors.mansourLightGreyColor_3,
                          ),
                        ),
                        Gaps.hGap32,
                        Text(
                          "${shop.commentsCount} ${Translation.current.comments}",
                          style: TextStyle(
                            color: AppColors.mansourLightGreyColor_3,
                            fontSize: 45.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // SizedBox(
                  //   height: 50.h,
                  //   width: 50.h,
                  //   child: SvgPicture.asset(
                  //     AppConstants.SVG_SHARE_FILL,
                  //     color: AppColors.mansourLightGreyColor_3,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
