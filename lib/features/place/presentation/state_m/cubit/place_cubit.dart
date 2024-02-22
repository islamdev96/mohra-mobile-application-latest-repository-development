import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';
import 'package:starter_application/features/place/domain/usecase/get_reverse_geocoding_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'place_cubit.freezed.dart';
part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit() : super(const PlaceState.placeInitState());

  void getReverseGeocoding(ReverseGeocodingParam param) async {
    emit(const PlaceState.placeLoadingState());
    final result = await getIt<GetReverseGeocodingUseCase>()(param);
    result.pick(
      onData: (d) => emit(PlaceState.reverseGeocodingLoaded(d)),
      onError: (e) => emit(
          PlaceState.placeErrorState(e, () => this.getReverseGeocoding(param))),
    );
  }
}
