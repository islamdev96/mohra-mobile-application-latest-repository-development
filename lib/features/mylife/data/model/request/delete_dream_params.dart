import 'package:starter_application/core/params/base_params.dart';

class DeleteDreamParams extends BaseParams{
  int id;
  DeleteDreamParams({required this.id});
  @override
  Map<String, dynamic> toMap()=> {
    'id':id,
  };
}