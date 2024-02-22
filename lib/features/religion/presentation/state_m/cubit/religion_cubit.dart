import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/religion/data/model/request/azkar_param.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/domain/entity/azkar_entity.dart';
import 'package:starter_application/features/religion/domain/entity/pray_time_entity.dart';
import 'package:starter_application/features/religion/domain/usecase/get_azkar_by_category.dart';
import 'package:starter_application/features/religion/domain/usecase/get_nearby_mosques_usecase.dart';
import 'package:starter_application/features/religion/domain/usecase/get_prayer_times_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'religion_cubit.freezed.dart';

part 'religion_state.dart';

class ReligionCubit extends Cubit<ReligionState> {
  ReligionCubit() : super(const ReligionState.religionInitState());

  void getPrayerTimes(PrayTimeParam param) async {
    emit(const ReligionState.religionLoadingState());
    final result = await getIt<GetPrayerTimesUsecase>()(param);
    result.pick(
      onData: (data) => emit(ReligionState.prayerTimesLoaded(data)),
      onError: (error) => emit(
        ReligionState.religionErrorState(
            error, () => this.getPrayerTimes(param)),
      ),
    );
  }

  /// Return the prayer times for current date and the two surrounding dates
  void getPrayerTimesWithPrevNext(PrayTimeParam param) async {
    emit(const ReligionState.religionLoadingState());

    final results = await Future.wait([
      getIt<GetPrayerTimesUsecase>()(param),
      getIt<GetPrayerTimesUsecase>()(
        param.copyWith(
          time: param.time.subtract(
            const Duration(
              days: 1,
            ),
          ),
        ),
      ),
      getIt<GetPrayerTimesUsecase>()(
        param.copyWith(
          time: param.time.add(
            const Duration(
              days: 1,
            ),
          ),
        ),
      )
    ]);

    if (results[0].hasErrorOnly ||
        results[1].hasErrorOnly ||
        results[2].hasErrorOnly) {
      final error = results[0].hasErrorOnly
          ? results[0].error
          : results[1].hasErrorOnly
              ? results[1].error
              : results[2].error;
      emit(
        ReligionState.religionErrorState(
            error!, () => this.getPrayerTimesWithPrevNext(param)),
      );
    } else {
      emit(ReligionState.prayerTimesWithPrevNextLoaded(
          results[0].data!, results[1].data!, results[2].data!));
    }
  }

  void getNearbyMosques(nearbyPlacesParam param) async {
    emit(const ReligionState.religionLoadingState());
    final result = await getIt<GetNearbyMosquesUsecase>()(param);
    result.pick(
      onData: (data) => emit(ReligionState.nearbyMosquesLoaded(data)),
      onError: (error) => emit(
        ReligionState.religionErrorState(
            error, () => this.getNearbyMosques(param)),
      ),
    );
  }
  Future<NearbyPlacesEntity?> getNearbyPlaces(nearbyPlacesParam param) async {
    final result = await getIt<GetNearbyMosquesUsecase>()(param);
    return result.data;
  }
  void getAzkarByCategory(AzkarParam param) async {
    emit(const ReligionState.religionLoadingState());
    final result = await getIt<GetAzkarByCategoryUsecase>()(param);
    print("cubit${result.data}");
    result.pick(
        onData: (data) => emit(ReligionState.azkarCategoryLoaded(data)),
        onError: (error) {
          print("errrror$error");
          emit(ReligionState.religionErrorState(
              error, () => this.getAzkarByCategory(param)));
        });
  }
}
