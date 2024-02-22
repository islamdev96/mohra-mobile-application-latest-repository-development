import 'package:starter_application/core/params/base_params.dart';

class DeleteTimeTableParams extends BaseParams{
  final int id;

  DeleteTimeTableParams({
    required this.id
});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id':id,
    };
  }


}