import 'package:starter_application/core/net/create_model_interceptor/create_model.interceptor.dart';

class LiveSocoresModelIntercepter extends CreateModelInterceptor{
  @override
  T getModel<T>(Function(dynamic p1) modelCreator, json) {
    return modelCreator(json);
  }

}