import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/shop/data/model/response/get_taxfee_model.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/usecase/get_favorite_prodcuts_usecse.dart';
import 'package:starter_application/features/shop/domain/usecase/get_taxfee_usecse.dart';
import 'package:starter_application/features/splash/domain/entity/spash_entity.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/data/model/request/get_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/domain/usecase/get_all_city_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/get_user_profile_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.splashInitState());

  void splashInit() async   {
    late SessionData session =
    Provider.of<SessionData>(AppConfig().appContext, listen: false);
    final results = await Future.wait([
      getIt<GetAllCityUseCase>()(
        GetCityParams(type: 1,maxResultCount: 1000),
      ),
      getIt<GetTaxFeeUseCase>()(NoParams()),
      /*getIt<GetFavoriteProductsUseCase>()(
        GetFavoritesParams(
          refType: 1,
          skipCount: 0,
          maxResultCount: 1000,
        ),
      ),*/
    ]);


      final error = checkError(results);
    if (error != null) {
      splashInit();
      emit(
        SplashState.splashErrorState(
          error,
          splashInit,
        ),
      );
    } else {
      if(results[0].data is CityListEntity)
        session.cities =  (results[0].data as CityListEntity).items;
      if(results[1].data is GetSettingModel)
        session.getSettingModel = results[1].data as GetSettingModel;
      emit(
        SplashState.splashLoaded(
     /*     SplashEntity(
              cityListEntity: results[0].data as CityListEntity,
              favoritesProductsEntity: results[1].data as ProductsListEntity),*/
               SplashEntity(
              cityListEntity: results[0].data as CityListEntity,
              favoritesProductsEntity: null),
        ),
      );
    }
  }



  AppErrors? checkError<T>(List<Result<AppErrors, T>> results) {
    for (int i = 0; i < results.length; i++) {
      if (results[i].hasErrorOnly) return results[i].error;
    }
    return null;
  }
}
