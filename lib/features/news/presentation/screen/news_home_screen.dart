import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_search_text_field.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/news/presentation/widget/news_home_appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/news_home_screen_notifier.dart';
import 'news_home_screen_content.dart';

class NewsHomeScreen extends StatefulWidget {
  static const String routeName = "/NewsHomeScreen";

  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  final sn = NewsHomeScreenNotifier();

  @override
  void initState() {
    sn.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsHomeScreenNotifier>.value(
      value: sn,
      builder: (context, child) {
        return Scaffold(
          appBar: NewsHomeAppBar(
            isLeading: sn.isSearch,
            controller: sn.search,
            isHasLeading: true,
            onPress: () {
              sn.change();
              sn.changeSearchBody();
              setState(() {});
            },
            onSearch: () {
              sn.change();
              sn.searchNews(sn.search.text);
            },
            onSubmitted: (String value) {
              sn.change();
              sn.searchNews(value);
            },
            onClose: () {
              if(sn.isSearchBody||sn.isSearch){
                sn.changeAll();
              }else {
                Nav.pop();
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(builder: (context) => HomeScreen()),
                //         (Route<dynamic> route) => false);
              }
            },
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: NewsHomeScreenContent()
        );
      },
    );
  }
}
