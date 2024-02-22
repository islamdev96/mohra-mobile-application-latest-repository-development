import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/base_http_client.dart';
import 'package:starter_application/core/net/http_client.dart';
import 'package:starter_application/core/net/spotify/spotify_http_client.dart';
import 'package:starter_application/di/service_locator.dart';

enum HttpClientType {
  MAIN,
  SPOTIFY,
}

dynamic mapTypeToHttpClient(HttpClientType type) {
  switch (type) {
    case HttpClientType.MAIN:
      return getIt<HttpClient>();
    case HttpClientType.SPOTIFY:
      return getIt<SpotifyHttpClient>();
    default:
    return getIt<HttpClient>();
    
  }
}
