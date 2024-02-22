import 'package:starter_application/core/params/base_params.dart';

class DeleteNotificationParams extends BaseParams {
  String id;

  DeleteNotificationParams({required this.id});

  @override
  Map<String, dynamic> toMap() =>
      {
        'id': id,
      };

}