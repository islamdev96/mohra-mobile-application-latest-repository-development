import 'package:starter_application/core/params/base_params.dart';

class ProductItemParam extends BaseParams {
  final int? Id;

  ProductItemParam({this.Id});
  @override
  Map<String, dynamic> toMap() => {
        "Id": Id,
      };

  ProductItemParam copyWith({int? Id}) {
    return ProductItemParam(
      Id: Id ?? this.Id,
    );
  }
}
