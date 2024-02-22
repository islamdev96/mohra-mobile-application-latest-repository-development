/// This class is used to specify how to get data from a response 
/// Example1:
/// Manipulate the response to fit The Parser
/// Transform response from map to string to fit fromJson(String) converter
/// 
/// Example2:
/// Specifying which part of the json hold the actual data to parse,
/// Response:
/// {
/// "data":{
/// "result":{},
/// },
/// success: true,
/// status_code: 200
/// }
/// Parser => fromJson:
/// Parse "result" directly to get the actual data 
abstract class CreateModelInterceptor {
  const CreateModelInterceptor();
  T getModel<T>(
      dynamic Function(dynamic) modelCreator, dynamic json);
}
