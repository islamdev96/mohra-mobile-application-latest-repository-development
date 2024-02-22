import 'package:starter_application/core/params/base_params.dart';

class NewsSortParam extends BaseParams {
  final String search;
  final int? skipCount;
  final int? maxResultCount;
  final bool? isActive;
  NewsSortParam({required this.search,   this.skipCount,
    this.maxResultCount,
    this.isActive,});
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    if (search != null) _map['Keyword'] = search;
    if (skipCount != null) _map['skipCount'] = skipCount;
    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    if (isActive != null) _map['IsActive'] = isActive;
    _map["IsActive"] = true;

    return _map;
  }
}
