import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';

class ReligionFavoriteButton extends StatefulWidget {
  final int? id;
  final bool isFavorite;
  final String surahName;
  final int surahNum;
  final int ayahNum;
  final Function? onDelete;
  const ReligionFavoriteButton(
      {Key? key,
      this.isFavorite = false,
      required this.surahName,
      required this.surahNum,
      required this.ayahNum,
      this.id,
      this.onDelete})
      : super(key: key);

  @override
  State<ReligionFavoriteButton> createState() => _ReligionFavoriteButtonState();
}

class _ReligionFavoriteButtonState extends State<ReligionFavoriteButton> {
  FavoriteCubit _favoriteCubit = FavoriteCubit();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocConsumer<FavoriteCubit, FavoriteState>(
      bloc: _favoriteCubit,
      builder: (context, state) => state.maybeMap(
          favoriteInitState: (value) => _buildWidget(widget.isFavorite),
          favoriteLoadingState: (value) => WaitingWidget(),
          favoriteErrorState: (value) => _buildWidget(null),
          createFavoriteSuccessState: (value) => _buildWidget(true),
          deleteFavoriteSuccessState: (value) => _buildWidget(false),
          orElse: SizedBox.shrink),
      listener: (context, state) => state.mapOrNull(
        createFavoriteSuccessState: (value) => ErrorViewer.showError(
            context: context,
            error: const CustomError(message: 'Added Successfully'),
            callback: () {}),
        deleteFavoriteSuccessState: (value) {
          widget.onDelete?.call();
          ErrorViewer.showError(
              context: context,
              error: const CustomError(message: 'removed Successfully'),
              callback: () {});
        },
        favoriteErrorState: (value) => ErrorViewer.showError(
            context: context, error: value.error, callback: () {}),
      ),
    ));
  }

  Widget _buildWidget(bool? isFav) {
    return (isFav ?? widget.isFavorite)
        ? GestureDetector(
            onTap: () {
              _addToFav(false);
            },
            child: SvgPicture.asset(
              AppConstants.SVG_BOOK_MARK_FILL,
              color: AppColors.mansourYellow,
            ),
          )
        : GestureDetector(
            onTap: () {
              _addToFav(true);
            },
            child: SvgPicture.asset(
              AppConstants.SVG_BOOK_MARK,
              color: AppColors.mansourPurple4,
            ),
          );
  }

  void _addToFav(bool isFav) {
    isFav
        ? _favoriteCubit.createFavorites(CreateFavoriteParams(
            refId: '${widget.surahName}:${widget.surahNum}:${widget.ayahNum}',
            refType: 6))
        : {
            if (widget.id != null)
              _favoriteCubit
                  .deleteFavorites(DeleteFavoriteParams(id: widget.id!,refType: 6))
          };
  }
}
