import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/params/base_params.dart';

class MatchStatisticsParams extends BaseParams {
  final int matchId;
  final String key = AppConstants.SPORT_API_APP_KEY;
  final String secret = AppConstants.SPORT_API_APP_SECRET;

  MatchStatisticsParams({
    required this.matchId,
  });

  @override
  Map<String, dynamic> toMap() => {
    'match_id':matchId,
    'key':key,
    'secret':secret
    ,
  };
}
