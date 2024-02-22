import 'create_model.interceptor.dart';

class NullResponseModelInterceptor extends CreateModelInterceptor {
  const NullResponseModelInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic) modelCreator, dynamic json) {
    return modelCreator(json ?? {});
  }
}
