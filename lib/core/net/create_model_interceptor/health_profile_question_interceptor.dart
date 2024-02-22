import 'create_model.interceptor.dart';

class HealthProfileQuestionInterceptor extends CreateModelInterceptor {
  const HealthProfileQuestionInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic) modelCreator, dynamic json) {
    print('rrere');
    print(json);
    return modelCreator(json);
  }
}