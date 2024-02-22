import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/presentation/widget/health_item.dart';
import '../screen/../state_m/provider/news_search_screen_notifier.dart';
import 'news_single_screen.dart';

class NewsSearchScreenContent extends StatefulWidget {
  @override
  State<NewsSearchScreenContent> createState() =>
      _NewsSearchScreenContentState();
}

class _NewsSearchScreenContentState extends State<NewsSearchScreenContent> {
  late NewsSearchScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NewsSearchScreenNotifier>(context);
    sn.context = context;
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: SingleChildScrollView(
        child: sn.isLoading ? WaitingWidget() : searchResult(),
      ),
    );
  }

  Widget searchResult() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 30.w, right: 30.w, top: 70.h, bottom: 0.11.sh),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Nav.to(
                      SingleNewsScreen.routeName,
                      arguments:
                          SingleNewsParams(id: sn.searchResult![index].id!),
                    );
                  },
                  child: HealthNewsItem(
                    image: sn.searchResult![index].imageUrl!,
                    icon: sn.searchResult![index].sourceLogo!,
                    title: sn.searchResult![index].enTitle!,
                    iconName: sn.searchResult![index].sourceName!,
                    date: sn.searchResult![index].creationTime!,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap64;
              },
              itemCount: sn.searchResult!.length,
            ),
          ],
        ),
      ),
    );
  }
}
