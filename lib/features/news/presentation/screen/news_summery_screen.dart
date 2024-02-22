import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import '../screen/../state_m/provider/news_summery_screen_notifier.dart';
import 'news_summery_screen_content.dart';

class NewsSummeryScreen extends StatefulWidget {
  static const String routeName = "/NewsSummeryScreen";

  const NewsSummeryScreen({Key? key}) : super(key: key);

  @override
  _NewsSummeryScreenState createState() => _NewsSummeryScreenState();
}

class _NewsSummeryScreenState extends State<NewsSummeryScreen> {
  final sn = NewsSummeryScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getSummeryNews();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsSummeryScreenNotifier>.value(
      value: sn,
      child: BlocConsumer<NewsCubit, NewsState>(
        bloc: sn.newsCubit,
        builder: (context, state) {
          return state is NewsLoadingState
              ? Container(color: Colors.white, child: WaitingWidget())
              : Scaffold(
                  body: NewsSummeryScreenContent(),
                );
        },
        listener: (context, state) {
          if (state is SummeryNewsLoaded) {
            sn.newsItemOfCategoryEntity=state.summeryNewsEntity.result;
          }
        },
      ),
    );
  }
}
