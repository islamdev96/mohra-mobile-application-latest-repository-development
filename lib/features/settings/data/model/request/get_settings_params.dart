import 'package:starter_application/core/params/base_params.dart';

class GetSettingsParams extends BaseParams{
  final int id;

  GetSettingsParams({
   required this.id,
});
  @override
  Map<String, dynamic> toMap() {
   return {
     'id':id,
   };
  }
}