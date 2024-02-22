import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/browse_exrecise_screen_notifier.dart';
import 'browse_exrecise_screen_content.dart';

class BrowseExreciseScreen extends StatefulWidget {
  static const String routeName = "/BrowseExreciseScreen";

  const BrowseExreciseScreen({Key? key}) : super(key: key);

  @override
  _BrowseExreciseScreenState createState() => _BrowseExreciseScreenState();
}

class _BrowseExreciseScreenState extends State<BrowseExreciseScreen> {
  final sn = BrowseExreciseScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getSessions();
  }

  @override
  void dispose() {
    sn.closeNotifier();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BrowseExreciseScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          actions: [
            /*   Container(
              margin: EdgeInsetsDirectional.only(
                end: 40.w,
              ),
              child: SvgPicture.asset(
                AppConstants.SVG_SEARCH,
                color: Colors.black,
                height: 75.sp,
              ),
            ),*/
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.browse_exercise,
              size: TitleSize.medium,
            ),
            Expanded(child: BrowseExreciseScreenContent()),
          ],
        ),
      ),
    );
  }
}
