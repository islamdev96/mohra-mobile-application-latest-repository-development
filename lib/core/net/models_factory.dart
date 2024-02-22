import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/net/create_model_interceptor/create_model.interceptor.dart';

/// This class is singleton and used to get models from json responses
class ModelsFactory {
  static const FROM_JSON = "FROM_JSON";
  static const CREATE_MODEL_INTERCEPTOR = "CREATE_MODEL_INTERCEPTOR";

  static final _instance = ModelsFactory._();

  factory ModelsFactory() {
    return _instance;
  }
  ModelsFactory._();

  /// Mapping each model name with the actual value using fromJson factory method and createModelInterceptor.
  /// Map structure
  /// "model_name":{
  /// "FROM_JSON": fromJson factoryMethod (dynamic Function(dynamic),
  /// "CREATE_MODEL_INTERCEPTOR": CreateModelInterceptor
  /// }
  ///
  Map<String, dynamic> _modelsMap = {};

  /// Register the model in the map.
  void registerModel(
    String modelName,
    dynamic Function(dynamic) modelCreator,
    String createModelInterceptorName,
    CreateModelInterceptor createModelInterceptor,
  ) {
    print('ddd');
    final Map<String, dynamic> modelInfo = {};
    modelInfo.putIfAbsent(FROM_JSON, () => modelCreator);

    modelInfo.putIfAbsent(
        CREATE_MODEL_INTERCEPTOR, () => createModelInterceptor);

    _modelsMap.putIfAbsent(modelName, () => modelInfo);
  }

  /// Generate the desired T model.
  T createModel<T extends BaseModel>(json) {
    print(json);
    print('aaaaaaaadddd');
    final modelName = T.toString();
    final modelInfo = _modelsMap[modelName];
    final fromJson = modelInfo[FROM_JSON];
    final createModelInterceptor = modelInfo[CREATE_MODEL_INTERCEPTOR];
    final model = createModelInterceptor.getModel(fromJson, json);
    return model;
  }

  /// Generate list of T model.
  List<T?> createModelsList<T extends BaseModel>(json) {
    return (json as List)
        .map((m) => m == null ? null : createModel<T>(m))
        .toList();
  }
}
