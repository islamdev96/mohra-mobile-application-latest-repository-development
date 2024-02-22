import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/news/presentation/screen/see_all_news_page_content.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/see_all_page_notifier.dart';

class SeeAllNewsPage extends StatefulWidget {
  static const String routeName = "/SeeAllNewsPage";
  final String? id;
  const SeeAllNewsPage({Key? key, this.id}) : super(key: key);

  @override
  State<SeeAllNewsPage> createState() => _SeeAllNewsPageState();
}

class _SeeAllNewsPageState extends State<SeeAllNewsPage> {
  final sn = SeeAllNewsPageNotifier();

  @override
  void initState() {
    super.initState();
    sn.getNewsOfSingleCategory(widget.id!);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeeAllNewsPageNotifier>.value(
      value: sn,
      child: BlocConsumer<NewsCubit, NewsState>(
        bloc: sn.newsCubit,
        builder: (context, state) {
          return state is NewsLoadingState
              ? Container(color: Colors.white, child: WaitingWidget())
              : Scaffold(
            body: SeeAllNewsPageContent(),
          );
        },
        listener: (context, state) {
          if (state is SummeryNewsLoaded) {
            // sn.newsItemOfCategoryEntity=state.summeryNewsEntity.result;
          }
        },
      ),
    );
  }
}
