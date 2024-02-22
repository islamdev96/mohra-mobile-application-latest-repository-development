import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/location/data/model/request/get_locations_lite_params.dart';
import 'package:starter_application/features/location/domain/entity/locations_lite_entity.dart';
import 'package:starter_application/features/location/domain/usecase/get_locations_lite_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'location_cubit.freezed.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState.locationInitState());

  getLocationsLite(GetLocationsLiteParams params) async {
    emit(const LocationState.locationLoadingState());
    final result = await getIt<GetLocationsLiteUseCase>().call(params);
    result.pick(
      onData: (data) => emit(LocationState.locationsLoadedState(data)),
      onError: (error) => emit(LocationState.locationErrorState(error, () {
        this.getLocationsLite(params);
      })),
    );
  }
}
