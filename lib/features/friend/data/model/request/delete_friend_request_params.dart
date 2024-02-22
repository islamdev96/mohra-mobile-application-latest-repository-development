import 'package:starter_application/core/params/base_params.dart';

class CancelFriendRequestParams extends BaseParams {
  CancelFriendRequestParams({
    required this.id,
  });

  final int id;


  Map<String, dynamic> toMap() => {
    "id": id,
  };
}
