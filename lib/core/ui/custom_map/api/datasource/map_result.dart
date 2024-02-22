import 'package:starter_application/core/errors/app_errors.dart';

class MapResult<Error extends AppErrors, Data> {
  final Data? data;
  final Error? error;

  MapResult({this.data, this.error}) : assert(data != null || error != null);

  /// checks whether data is available
  bool get hasDataOnly => data != null && error == null;

  /// checks whether an error is present
  bool get hasErrorOnly => data == null && error != null;

  /// checks whether data and error is present
  /// error from network data source and data from cache data source
  bool get hasDataAndError => data != null && error != null;

  /// returns the error
  factory MapResult.error(Error error) {
    return MapResult(
      error: error,
      data: null,
    );
  }

  /// returns just data
  factory MapResult.data(Data? data) {
    return MapResult(
      error: null,
      data: data,
    );
  }

  /// returns error and data
  factory MapResult.dataWithError(Data? data, Error error) {
    return MapResult(
      error: error,
      data: data,
    );
  }

  /// forwards the error if present else forwards the data
  factory MapResult.forward(MapResult _result, Data? data) {
    if (_result.hasErrorOnly) {
      return MapResult.error(_result.error as Error);
    }

    return MapResult.data(data);
  }

  /// Cherry pick values
  ///
  /// onError will return error, if present
  /// onNoError will return data if error is not present
  /// onData will return data if data is available
  /// onDataWithError will return data if error is present and data is available
  void pick({
    required Function(Data data) onData,
    required Function(Error error) onError,
    Function(Data data, Error error)? onErrorWithData,
  }) {
    if (hasErrorOnly) {
      onError.call(error!);
    } else if (hasDataOnly) {
      onData.call(data!);
    } else {
      onErrorWithData?.call(data!, error!);
    }
  }
}
