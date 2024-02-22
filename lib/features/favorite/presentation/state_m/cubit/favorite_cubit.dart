import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_by_ref_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/favorite/domain/entity/favorites_entity.dart';
import 'package:starter_application/features/favorite/domain/usecase/create_favorite_usecase.dart';
import 'package:starter_application/features/favorite/domain/usecase/delete_favorite_by_ref_usecase.dart';
import 'package:starter_application/features/favorite/domain/usecase/delete_favorite_usecase.dart';
import 'package:starter_application/features/favorite/domain/usecase/get_favorites_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'favorite_cubit.freezed.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState.favoriteInitState());

  getFavorites(GetFavoritesParams params) async {
    emit(const FavoriteState.favoriteLoadingState());
    var result = await getIt<GetFavoritesUseCase>().call(params);
    result.pick(
      onData: (data) => emit(FavoriteState.getFavoritesSuccessState(data)),
      onError: (error) => emit(FavoriteState.favoriteErrorState(error, () {
        this.getFavorites(params);
      })),
    );
  }

  createFavorites(CreateFavoriteParams params) async {
    emit(const FavoriteState.favoriteLoadingState());
    var result = await getIt<CreateFavoriteUseCase>().call(params);
    result.pick(
      onData: (data) => emit(FavoriteState.createFavoriteSuccessState(data)),
      onError: (error) => emit(FavoriteState.favoriteErrorState(error, () {
        this.createFavorites(params);
      })),
    );
  }

  deleteFavorites(DeleteFavoriteParams params) async {
    emit(const FavoriteState.favoriteLoadingState());
    var result = await getIt<DeleteFavoriteUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const FavoriteState.deleteFavoriteSuccessState()),
      onError: (error) => emit(FavoriteState.favoriteErrorState(error, () {
        this.deleteFavorites(params);
      })),
    );
  }

  void deleteFavoriteByRef(DeleteFavoriteByRefParams params) async {
    emit(const FavoriteState.favoriteLoadingState());
    var result = await getIt<DeleteFavoriteByRefUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const FavoriteState.deleteFavoriteSuccessState()),
      onError: (error) => emit(FavoriteState.favoriteErrorState(error, () {
        this.deleteFavoriteByRef(params);
      })),
    );
  }
}
