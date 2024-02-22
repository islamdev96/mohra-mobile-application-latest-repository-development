import 'package:starter_application/core/params/base_params.dart';

class NewsSingleCategoryParam extends BaseParams {
  final String? id;
  final String? keyword;

  final int? skipCount;
  final int? maxResultCount;

  NewsSingleCategoryParam({
    this.id,
    this.skipCount,
    this.keyword,
    this.maxResultCount,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (id != "" && id != null) 'CategoryId': id,
        'skipCount': skipCount == null ? 0 : skipCount,
        if (keyword != null) 'Keyword': keyword,
        'maxResultCount': maxResultCount == null ? 4 : maxResultCount,
        'IsActive': true
      };
}
