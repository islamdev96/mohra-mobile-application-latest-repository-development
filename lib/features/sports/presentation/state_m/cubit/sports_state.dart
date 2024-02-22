part of 'sports_cubit.dart';

@freezed
class SportsState with _$SportsState {
  const factory SportsState.sportsInitState() = SportsInitState;

  const factory SportsState.sportsLoadingState() = SportsLoadingState;

  const factory SportsState.sportsErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = SportsErrorState;

  const factory SportsState.liveScoresLodaed(
      LiveScoreEntity liveScoreEntity,
      ) = LiveScoresLodaed;

  const factory SportsState.matchStatisticsLoaded(
      MatchStatisticsEntity matchStatisticsEntity
      ) = MatchStatisticsLoaded;

  const factory SportsState.matchEventsLoaded(
      MatchEventResponseEntity matchEventResponseEntity
      ) = MatchEventsLoaded;

  const factory SportsState.matchlineUpsLoaded(
      GetMatchLineUpsEntity getMatchLineUpsEntity
      ) = MatchlineUpsLoaded;
}

