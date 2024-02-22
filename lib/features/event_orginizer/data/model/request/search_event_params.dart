import '../../../../../core/params/base_params.dart';

class SearchEventParams extends BaseParams {
  final String value;

  SearchEventParams({
    required this.value,
});

  factory SearchEventParams.fromMap(Map<String, dynamic> json) => SearchEventParams(
      value:json['id']
  );

  Map<String, dynamic> toMap() => {
    "EventId":value
  };
}