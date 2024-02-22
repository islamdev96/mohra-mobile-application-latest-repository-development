import 'package:starter_application/core/params/base_params.dart';

class GetFavoritesParams extends BaseParams {
  GetFavoritesParams({
    this.refType,
    this.refId,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final int? refType;
  final String? refId;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetFavoritesParams.fromMap(Map<String, dynamic> json) =>
      GetFavoritesParams(
        refType: json["RefType"] == null ? null : json["RefType"],
        refId: json["RefId"] == null ? null : json["RefId"],
        sorting: json["RefId"] == null ? null : json["RefId"],
        skipCount: json["SkipCount"] == null ? null : json["SkipCount"],
        maxResultCount:
            json["MaxResultCount"] == null ? null : json["MaxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (refType != null) map['RefType'] = refType;
    if (refId != null) map['RefId'] = refId;
    if (sorting != null) map['Sorting'] = sorting;
    if (skipCount != null) map['SkipCount'] = skipCount;
    if (maxResultCount != null) map['MaxResultCount'] = maxResultCount;
    return map;
  }
}
