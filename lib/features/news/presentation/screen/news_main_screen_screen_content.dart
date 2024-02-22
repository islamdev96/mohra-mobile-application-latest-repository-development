import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/../state_m/provider/news_main_screen_screen_notifier.dart';

class NewsMainScreenScreenContent extends StatefulWidget {

  @override
  State<NewsMainScreenScreenContent> createState() => _NewsMainScreenScreenContentState();
}

class _NewsMainScreenScreenContentState extends State<NewsMainScreenScreenContent> {
  late NewsMainScreenScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NewsMainScreenScreenNotifier>(context);
    sn.context = context;
    return Container();
  }
}
