import 'package:starter_application/core/net/create_model_interceptor/create_model.interceptor.dart';

/// Get the whole json response
class AllDataCreateModelInterceptor extends CreateModelInterceptor {
  const AllDataCreateModelInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic) modelCreator, dynamic json) {
    return modelCreator(json);
  }
}
