import 'package:starter_application/core/params/base_params.dart';

class GetLocationsLiteParams extends BaseParams {
  GetLocationsLiteParams({
    this.advancedSearchKeyword,
    this.keyword,
    this.type,
    this.parentId,
    this.isActive = true,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final String? advancedSearchKeyword;
  final String? keyword;
  final int? type;
  final int? parentId;
  final bool isActive;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetLocationsLiteParams.fromMap(Map<String, dynamic> json) =>
      GetLocationsLiteParams(
        advancedSearchKeyword: json["AdvancedSearchKeyword"] == null
            ? null
            : json["AdvancedSearchKeyword"],
        keyword: json["Keyword"] == null ? null : json["Keyword"],
        type: json["Type"] == null ? null : json["Type"],
        parentId: json["ParentId"] == null ? null : json["ParentId"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        sorting: json["Sorting"] == null ? null : json["Sorting"],
        skipCount: json["SkipCount"] == null ? null : json["SkipCount"],
        maxResultCount:
            json["MaxResultCount"] == null ? null : json["MaxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (advancedSearchKeyword != null)
      map['advancedSearchKeyword'] = advancedSearchKeyword;
    if (keyword != null) map['keyword'] = keyword;
    if (type != null) map['type'] = type;
    if (parentId != null) map['parentId'] = parentId;
    map['isActive'] = isActive;
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;
    return map;
  }
}
