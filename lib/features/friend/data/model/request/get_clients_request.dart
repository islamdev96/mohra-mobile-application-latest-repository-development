import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetClientsRequest extends BaseParams {
  GetClientsRequest(
      {this.sorting,
      this.keyword,
      this.advancedSearchKeyword,
      this.skipCount,
      this.maxResultCount,
      this.isActive,
      this.CheckContain = false,
      CancelToken? cancelToken})
      : super(cancelToken: cancelToken);

  final String? sorting;
  final bool? isActive;
  final String? keyword;
  final String? advancedSearchKeyword;
  final int? skipCount;
  final int? maxResultCount;
  bool CheckContain;

  factory GetClientsRequest.fromMap(Map<String, dynamic> json) =>
      GetClientsRequest(
        sorting: json["sorting"] == null ? null : json["sorting"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        keyword: json["keyword"] == null ? null : json["keyword"],
        advancedSearchKeyword: json["advancedSearchKeyword"] == null
            ? null
            : json["advancedSearchKeyword"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    if (sorting != null) _map['sorting'] = sorting;
    if (isActive != null) _map['isActive'] = isActive;
    if (keyword != null) _map['keyword'] = keyword;
    if (advancedSearchKeyword != null)
      _map['advancedSearchKeyword'] = advancedSearchKeyword;

    if (skipCount != null) _map['skipCount'] = skipCount;
    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    _map['isActive'] = true;
    _map['CheckContain'] = CheckContain;
    return _map;
  }
}
