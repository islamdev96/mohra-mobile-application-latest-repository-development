import 'package:starter_application/core/params/base_params.dart';

class DeleteFavoriteByRefParams extends BaseParams {
  DeleteFavoriteByRefParams({
    required this.refId,
    required this.refType,
  });

  final int refId;
  final int refType;

  Map<String, dynamic> toMap() => {
        "refId": refId,
        'refType': refType,
      };
}
