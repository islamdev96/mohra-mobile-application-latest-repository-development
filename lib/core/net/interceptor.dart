import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';

import '../constants/app/app_constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await AppConfig().hasToken) {
      final token = await AppConfig().authToken;
      final os = AppConfig().os;
      final appVersion = AppConfig().appVersion;
      if (os != null) options.headers[AppConstants.HEADER_OS] = '$os';
      if (appVersion != null)
        options.headers[AppConstants.HEADER_APP_VERSION] = '$appVersion';
      if (os != null) options.headers[AppConstants.HEADER_AUTH] = '$token';
      if (appVersion != null)
        options.headers[AppConstants.HEADER_APP_VERSION] = '$appVersion';
      if (os != null) options.headers[AppConstants.HEADER_AUTH] = '$token';
      // options.headers[AppConstants.HEADER_AUTH] = '$apiKey';
      options.headers[AppConstants.HEADER_AUTH] = '$token';
      // options.headers[AppConstants.HEADER_LANGUAGE] = Intl.getCurrentLocale();
    }
      options.queryParameters[AppConstants.QUERY_PARAM_LANGUAGE] = Intl.getCurrentLocale();

    handler.next(options);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print("Future<void> onResponse${response.requestOptions.path}");
    try {
      final int? statusCode = response.statusCode;
      switch (statusCode) {
        case 200:
          handler.next(response);
          break;
        case 401:
            ErrorViewer.showUnauthorizedError(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                callback: (){
                  Nav.to(LoginScreen.routeName);
                },
                retryWhenNotAuthorized: true
            );
            break;
        default:
          handler.reject(
            DioError(
              requestOptions: response.requestOptions,
              response: response,
              error: {},
            ),
            true,
          );
          return;
      }
    } catch (ex, st) {
      handler.reject(
        DioError(
            requestOptions: response.requestOptions,
            response: response,
            error: ex),
        true,
      );
    }
  }
}
