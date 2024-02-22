import 'package:starter_application/core/params/base_params.dart';

class GetGroupsParams extends BaseParams {
  GetGroupsParams({
    this.keyword,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final String? keyword;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetGroupsParams.fromMap(Map<String, dynamic> json) => GetGroupsParams(
        keyword: json["keyword"] == null ? null : json["keyword"],
        sorting: json["sorting"] == null ? null : json["sorting"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (keyword != null) map['keyword'] = keyword;
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;
    return map;
  }
}
