import 'package:starter_application/core/net/create_model_interceptor/create_model.interceptor.dart';

class DefaultCreateModelInterceptor extends CreateModelInterceptor {
  const DefaultCreateModelInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic) modelCreator, dynamic json) {
    print('inddd');
    print(json);
    return modelCreator(json["result"]);
  }
}
