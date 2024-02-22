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
import 'package:starter_application/features/news/presentation/state_m/provider/see_all_page_notifier.dart';
import 'package:starter_application/features/news/presentation/widget/health_item.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/news_summery_screen_notifier.dart';
import 'news_single_screen.dart';

class SeeAllNewsPageContent extends StatefulWidget {
  @override
  State<SeeAllNewsPageContent> createState() =>
      _SeeAllNewsPageContentState();
}

class _SeeAllNewsPageContentState extends State<SeeAllNewsPageContent> {
  late SeeAllNewsPageNotifier sn;
  final padding = EdgeInsets.symmetric(
    horizontal: 50.w,
  );
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SeeAllNewsPageNotifier>(context);
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
          child:  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Nav.to(
                              SingleNewsScreen.routeName,
                              arguments: SingleNewsParams(
                                  id: sn.NewsOfCategories[index].id!),
                            );
                          },
                          child: HealthNewsItem(
                            image: sn.NewsOfCategories[index].imageUrl!,
                            icon: sn.NewsOfCategories[index]
                                .sourceLogo!,
                            // title: sn.NewsOfCategories1![index].enTitle!,
                            title: sn.NewsOfCategories[index].arTitle!,
                            iconName: sn.NewsOfCategories[index]
                                .sourceName!,
                            date: sn.NewsOfCategories[index]
                                .creationTime!,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap64;
                      },
                      itemCount: sn.NewsOfCategories.length,
                    ),

                ),
              );
  }

}
