import 'package:starter_application/core/params/base_params.dart';

class DeleteItemRequest extends BaseParams {
  int id;
  int type;
  DeleteItemRequest({required this.id,required this.type});

  @override
  Map<String, dynamic> toMap() => {
    "Id": id,
  };
}
