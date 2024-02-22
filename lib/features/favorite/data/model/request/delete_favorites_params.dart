import 'package:starter_application/core/params/base_params.dart';

// TODO Remove refType
class DeleteFavoriteParams extends BaseParams {
  DeleteFavoriteParams({
    required this.id,
    required this.refType, //TODO any number , but product num = 1
  });

  final int id;
  @deprecated
  final int refType;

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
