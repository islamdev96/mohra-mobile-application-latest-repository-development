import 'package:starter_application/core/params/base_params.dart';

class SingleNewsParam extends BaseParams {
  int id;

  SingleNewsParam({required this.id});

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
