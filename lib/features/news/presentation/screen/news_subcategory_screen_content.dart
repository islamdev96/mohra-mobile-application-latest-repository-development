import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../main.dart';
import '../screen/../state_m/provider/single_category_screen_notifier.dart';
import 'news_single_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsSubCategoryScreenContent extends StatefulWidget {
  @override
  State<NewsSubCategoryScreenContent> createState() =>
      _NewsSubCategoryScreenContentState();
}

class _NewsSubCategoryScreenContentState
    extends State<NewsSubCategoryScreenContent> {
  late SingleCategoryScreenNotifier sn;
  EdgeInsets parentPadding =
      EdgeInsets.symmetric(horizontal: 60.w, vertical: 40.h);

  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SingleCategoryScreenNotifier>(context);
    sn.context = context;
    return Container(
        width: 1.sw,
        height: 1.sh,
        margin: EdgeInsets.all(8),
        child: PaginationWidget<NewsItemOfCategoryEntity>(
          scrollDirection: Axis.vertical,
          items: sn.NewsOfCategories,
          getItems: sn.getNewsOfSingleItems,
          onDataFetched: sn.onNewsOfSingleItemsFetched,
          refreshController: sn.momentsRefreshController,
          footer: ClassicFooter(
            loadingText: "",
            noDataText: Translation.of(context).noDataRefresher,
            failedText: Translation.of(context).failedRefresher,
            idleText: "",
            canLoadingText: "",
            height: AppConstants.bottomNavigationBarHeight + 300.h,
          ),
          child: sn.NewsOfCategories.length > 0
              ? GridView.builder(
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 4,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: [
                      QuiltedGridTile(2, 2),
                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 2),
                    ],
                  ),
                  semanticChildCount: sn.NewsOfCategories.length,
                  itemBuilder: (context, index) {
                    return _buildSubCategoryWidget(
                        date: sn.NewsOfCategories[index].creationTime,
                        onTap: () {
                          Nav.to(
                            SingleNewsScreen.routeName,
                            arguments: SingleNewsParams(
                                id: sn.NewsOfCategories[index].id!),
                          );
                        },
                        image: sn.NewsOfCategories[index].imageUrl,
                        title: sn.NewsOfCategories[index].arTitle,
                        icon: sn.NewsOfCategories[index].sourceLogo,
                        sourceName: sn.NewsOfCategories[index].sourceName);
                  },
                  itemCount: sn.NewsOfCategories.length,
                )
              : _buildEmptyWidget(),
        ));
  }

  Widget _buildEmptyWidget() {
    return SizedBox(
      height: 0.2.sh,
      child: Center(
        child: EmptyErrorScreenWidget(
          message: Translation.current.no_data,
          textColor: AppColors.black,
        ),
      ),
    );
  }

  _buildSubCategoryWidget({image, icon, sourceName, title, onTap, date}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
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
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.vGap32,
              Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: (icon != "string" && image.isNotEmpty)
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
                  SizedBox(
                    width: 0.2.sw,
                    child: Text(
                      sourceName,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: AppColors.white,
                        fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                      ),
                    ),
                  ),
                  Gaps.hGap32,
                  Text(
                    timeago.format("".setTime(date), locale: "ar"),
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              Gaps.vGap16,
            ],
          ),
        ),
      ),
    );
  }
}
