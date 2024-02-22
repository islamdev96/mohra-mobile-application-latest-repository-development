import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/domain/entity/get_match_line_up_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_event_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_statistics_entity.dart';
import 'package:starter_application/features/sports/domain/usecase/get_live_scores_usecase.dart';
import 'package:starter_application/features/sports/domain/usecase/get_match_event_usecase.dart';
import 'package:starter_application/features/sports/domain/usecase/get_match_line_up_usecase.dart';
import 'package:starter_application/features/sports/domain/usecase/get_match_statistics_usecase.dart';
import '../../../../../core/errors/app_errors.dart';

part 'sports_state.dart';

part 'sports_cubit.freezed.dart';

class SportsCubit extends Cubit<SportsState> {
  SportsCubit() : super(const SportsState.sportsInitState());

  void getLiveScores(NoParams params) async {
    emit(const SportsState.sportsLoadingState());
    final result = await getIt<GetLiveScoresUsecase>()(params);
    result.pick(
      onData: (data) =>
          emit(SportsState.liveScoresLodaed(data.liveScoreEntity)),
      onError: (error) => emit(
        SportsState.sportsErrorState(error, () => this.getLiveScores(params)),
      ),
    );
  }

  void getMatchStatistics(MatchStatisticsParams params) async {
    emit(const SportsState.sportsLoadingState());
    final result = await getIt<MatchStatisticsUsecase>()(params);
    result.pick(
      onData: (data) => emit(SportsState.matchStatisticsLoaded(data)),
      onError: (error) => emit(
        SportsState.sportsErrorState(
            error, () => this.getMatchStatistics(params)),
      ),
    );
  }

  void getMatchEvents(MatchStatisticsParams params) async {
    emit(const SportsState.sportsLoadingState());
    final result = await getIt<GetMatchEventsUsecase>()(params);
    result.pick(
      onData: (data) => emit(SportsState.matchEventsLoaded(data)),
      onError: (error) => emit(
        SportsState.sportsErrorState(error, () => this.getMatchEvents(params)),
      ),
    );
  }

  void getMatchLineUp(MatchStatisticsParams params) async {
    emit(const SportsState.sportsLoadingState());

    final result = await getIt<GetMatchLineUpUsecase>()(params);
    result.pick(
      onData: (data) => emit(SportsState.matchlineUpsLoaded(data)),
      onError: (error) => emit(
        SportsState.sportsErrorState(error, () => this.getMatchLineUp(params)),
      ),
    );
  }
}
