import 'package:starter_application/core/params/base_params.dart';

class ClaimRewardsRequest extends BaseParams {
  ClaimRewardsRequest({
    required this.id,
  });

  final int id;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
    };
    return map;
  }
}
