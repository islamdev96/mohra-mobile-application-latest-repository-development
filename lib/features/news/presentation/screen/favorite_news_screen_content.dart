import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/favorite/domain/entity/favorites_entity.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';

import '../screen/../state_m/provider/favorite_news_screen_notifier.dart';

class FavoriteNewsScreenContent extends StatefulWidget {
  @override
  State<FavoriteNewsScreenContent> createState() =>
      _FavoriteNewsScreenContentState();
}

class _FavoriteNewsScreenContentState extends State<FavoriteNewsScreenContent> {
  late FavoriteNewsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FavoriteNewsScreenNotifier>(context);
    sn.context = context;
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: sn.favoriteCubit,
      builder: (context, state) => state.maybeMap(
          favoriteInitState: (value) => WaitingWidget(),
          favoriteLoadingState: (value) => WaitingWidget(),
          getFavoritesSuccessState: (value) =>
              _buildList(value.favoritesEntity),
          favoriteErrorState: (value) => ErrorScreenWidget(
                error: value.error,
                callback: value.callback,
              ),
          orElse: SizedBox.shrink),
    );
  }

  Widget _buildList(FavoritesEntity entity) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container();
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap50;
      },
      itemCount: entity.items.length,
    );
  }
}
