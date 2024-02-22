import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorites_entity.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_utils.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_favourite_list/quran_favourite_card.dart';
import 'package:starter_application/generated/l10n.dart';

class QuranFavoriteList extends StatefulWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  QuranFavoriteList({Key? key, this.physics, this.shrinkWrap = false})
      : super(key: key);

  @override
  State<QuranFavoriteList> createState() => _QuranFavoriteListState();
}

class _QuranFavoriteListState extends State<QuranFavoriteList> {
  FavoriteCubit _favoriteCubit = FavoriteCubit();

  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: _favoriteCubit,
      builder: (context, state) => state.maybeMap(
          favoriteInitState: (value) => WaitingWidget(),
          favoriteLoadingState: (value) => WaitingWidget(),
          getFavoritesSuccessState: (value) =>
              value.favoritesEntity.items.length == 0
                  ? EmptyErrorScreenWidget(message: Translation.current.no_data)
                  : _buildList(value.favoritesEntity),
          favoriteErrorState: (value) => ErrorScreenWidget(
                error: value.error,
                callback: value.callback,
              ),
          orElse: SizedBox.shrink),
    );
  }

  Widget _buildList(FavoritesEntity entity) {
    return ListView.separated(
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        List<String> splits = entity.items.elementAt(index).refId.split(':');
        String surahName = splits.elementAt(0);
        int surahNum = int.parse(splits.elementAt(1));
        int ayahNum = int.parse(splits.elementAt(2));
        return QuranFavoriteCard(
          onDelete: () {
            _getFavorites();
          },
          id: entity.items.elementAt(index).id!,
          surahName: surahName,
          ayah: QUtils.getVerse(surahNum, ayahNum, withSymbol: false),
          surahNum: surahNum,
          ayahNum: ayahNum,
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap50;
      },
      itemCount: entity.items.length,
    );
  }

  _getFavorites() {
    _favoriteCubit.getFavorites(GetFavoritesParams(refType: 6));
  }
}
