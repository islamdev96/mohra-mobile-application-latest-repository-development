import 'package:starter_application/core/params/base_params.dart';

class GetFavoriteProductsParam extends BaseParams {
  GetFavoriteProductsParam({
    this.refId,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final String? refId;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['RefType'] = 1;
    if (refId != null) map['RefId'] = refId;
    if (sorting != null) map['Sorting'] = sorting;
    if (skipCount != null) map['SkipCount'] = skipCount;
    if (maxResultCount != null) map['MaxResultCount'] = maxResultCount;
    return map;
  }
}
