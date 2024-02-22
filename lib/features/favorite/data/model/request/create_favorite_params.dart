import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/params/base_params.dart';
// TODO Replace refType with enum
///0: Shop, 1: Product, 2: Session, 3: Dish, 4: Recipe, 5: Moment, 6: Sourah, 7:News
class CreateFavoriteParams extends BaseParams {
  CreateFavoriteParams({
    this.refType,
    required this.refId,
  });

  final int? refType;
  final String refId;

  factory CreateFavoriteParams.fromMap(Map<String, dynamic> json) =>
      CreateFavoriteParams(
        refType: json["RefType"] == null ? null : json["RefType"],
        refId: stringV(json["RefId"]),
      );

  Map<String, dynamic> toMap() => {
        "refType": refType == null ? null : refType,
        "refId": refId,
      };
}
