import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/news_summery_screen_notifier.dart';
import 'news_single_screen.dart';

class NewsSummeryScreenContent extends StatefulWidget {
  @override
  State<NewsSummeryScreenContent> createState() =>
      _NewsSummeryScreenContentState();
}

class _NewsSummeryScreenContentState extends State<NewsSummeryScreenContent> {
  late NewsSummeryScreenNotifier sn;
  final padding = EdgeInsets.symmetric(
    horizontal: 50.w,
  );
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NewsSummeryScreenNotifier>(context);
    sn.context = context;
    return DraggableHome(
      title: Text(
        "Today News Summary",
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 55.sp,
          fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
        ),
      ),
      leading: IconButton(
        onPressed: () => Nav.pop(),
        icon: Icon(
          AppConstants.getIconBack(),
          color: AppColors.white,
          size: 75.sp,
        ),
      ),
      headerWidget: _buildHomeHeader(),
      // drawer: _buildDrawer(),
      body: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                    child: Column(
                      children: sn.newsItemOfCategoryEntity
                          .map(
                            (e) => summeryWidget(
                              title: e.title!,
                              desc: e.description!,
                              icon: e.sourceLogo!,
                              iconName: e.sourceName!,
                              image: e.imageUrl!,
                              categoryName: e.category!.arName!,
                              entity: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
            Positioned.fill(
              right: AppConfig().isLTR ? 0 : 80.w,
              left: AppConfig().isLTR ? 0 : 80.w,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: SizedBox(
                  width: 50.w,
                  child: VerticalDivider(
                    color: Colors.grey[300],
                    width: 1,
                    thickness: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHomeHeader() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/png/newsSlider.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Nav.pop(),
                          icon: Icon(
                            AppConstants.getIconBack(),
                            color: AppColors.white,
                            size: 75.sp,
                          ),
                        ),
                        Text(
                          Translation.current.today_news_summary,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60.sp,
                            color: Colors.white,
                            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                          ),
                        ),
                        Gaps.hGap8,
                      ],
                    ),
                    Gaps.vGap32,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          now.day.toString() + "/",
                          style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                          ),
                        ),
                        Text(
                          now.month.toString(),
                          style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          PositionedDirectional(
              bottom: 60.h,
              end: 40.w,
              child: CustomMansourButton(
                  height: 80.h,
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 60.w,
                  ),
                  backgroundColor: AppColors.white,
                  titleStyle: TextStyle(
                    color: AppColors.primaryColorLight,
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  titleText: Translation.current.share,
                  onPressed: () {
                    sn.shareNews(2.toString());
                  }))
        ],
      ),
    );
  }

  Widget summeryWidget({
    required String title,
    required String desc,
    required String icon,
    required String iconName,
    required String categoryName,
    required String image,
    required NewsItemOfCategoryEntity entity,
  }) {
    return InkWell(
      onTap: () {
        Nav.to(
          SingleNewsScreen.routeName,
          arguments: SingleNewsParams(id: entity.id!),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap32,
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45.sp,
                    color: Colors.black,
                    fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                  ),
                ),
                Gaps.vGap32,
                Html(
                  data: desc,
                ),
                Gaps.vGap32,
                Row(
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: (icon != "string" && icon.isNotEmpty)
                            ? DecorationImage(
                                image: NetworkImage(
                                  icon,
                                ),
                                fit: BoxFit.fill,
                              )
                            : const DecorationImage(
                                image: AssetImage(
                                  AppConstants.NO_IMAGE_NULL,
                                ),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    Gaps.hGap16,
                    Text(
                      iconName,
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: AppColors.black_text,
                        fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                      ),
                    ),
                  ],
                ),
                Gaps.vGap32,
                Container(
                  height: 400.h,
                  decoration: BoxDecoration(
                    image: (image != "string" && image.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.fill,
                          )
                        : const DecorationImage(
                            image: AssetImage(
                              AppConstants.NO_IMAGE_NULL,
                            ),
                            fit: BoxFit.fill,
                          ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                Gaps.vGap32,
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                  height: 100.h,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            start: -140.w,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                categoryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.sp,
                  color: Colors.black,
                  fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
