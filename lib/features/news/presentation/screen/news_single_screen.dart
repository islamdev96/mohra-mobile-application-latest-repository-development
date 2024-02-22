import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import '../state_m/provider/single_news_screen_notifier.dart';
import 'news_single_content.dart';

class SingleNewsScreen extends StatefulWidget {
  static const String routeName = "/NewsSingleSubCategoryScreen";

  const SingleNewsScreen({Key? key, required this.entity}) : super(key: key);
  final SingleNewsParams entity;

  @override
  _SingleNewsScreenState createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  final sn = SingleSubCategoryScreenNotifier();

  @override
  void initState() {
    sn.getNews(widget.entity.id);
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingleSubCategoryScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MultiBlocListener(
          listeners: [
            BlocListener<NewsCubit, NewsState>(
              listener: (context, state) {
                state.mapOrNull(
                  newsLoadedState: (value) {
                    sn.isLoading = false;
                    sn.newsLoaded = true;
                    sn.newsEntity = value.newsEntity;
                  },
                );
              },
              bloc: sn.newsCubit,
            ),
            BlocListener<LikeCubit, LikeState>(
              listener: (context, state) {
                state.mapOrNull(
                  likeErrorState: (value) {
                    sn.isLiked = false;
                    ErrorViewer.showError(
                      context: context,
                      error: value.error,
                      callback: () {},
                    );
                  },
                );
              },
              bloc: sn.likeCubit,
            ),
            BlocListener<LikeCubit, LikeState>(
              listener: (context, state) {
                state.mapOrNull(
                  likeErrorState: (value) {
                    sn.isLiked = true;
                    ErrorViewer.showError(
                      context: context,
                      error: value.error,
                      callback: () {},
                    );
                  },
                );
              },
              bloc: sn.unlikeCubit,
            ),
          ],
          child: const SingleNewsScreenContent(),
        ),
      ),
    );
  }
}
