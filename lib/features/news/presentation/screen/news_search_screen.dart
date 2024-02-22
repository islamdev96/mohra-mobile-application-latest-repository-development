import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/news/presentation/widget/news_home_appbar.dart';
import '../screen/../state_m/provider/news_search_screen_notifier.dart';
import 'news_search_screen_content.dart';

class NewsSearchScreen extends StatefulWidget {
  static const String routeName = "/NewsSearchScreen";

  const NewsSearchScreen({Key? key}) : super(key: key);

  @override
  _NewsSearchScreenState createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  final sn = NewsSearchScreenNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsSearchScreenNotifier>.value(
      value: sn,
      child: Scaffold(
          appBar: NewsHomeAppBar(
            isLeading: true,
            isHasLeading: false,
            controller: sn.search,
            onPress: () {
              sn.change();
              setState(() {});
            },
            onSearch: () {
              sn.searchNews(sn.search.text);
            },
            onSubmitted: (String value) {
              sn.searchNews(value);
            },
            onClose: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BlocConsumer<NewsCubit, NewsState>(
            bloc: sn.newsCubit,
            listener: (context, state) {
              if (state is CreationTimeNewsLoaded) {
                sn.isLoading = false;
                sn.searchResult = state.newsOfCategory1Entity.result.items;
              }
              if (state is NewsLoadingState) {
                sn.isLoading = true;
              }
            },
            builder: (context, state) {
              return NewsSearchScreenContent();
            },
          )),
    );
  }
}
