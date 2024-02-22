import 'package:dio/dio.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
// import 'package:starter_application/features/music/presentation/state_m/provider/music_main_screen_notifier.dart';

// Todo refactor
class SpotifyRequestInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getSpotifyAuth();
    if (token != null)
      options.headers[AppConstants.HEADER_AUTH] =
          'Bearer $token';
    return super.onRequest(options, handler);
  }
}
