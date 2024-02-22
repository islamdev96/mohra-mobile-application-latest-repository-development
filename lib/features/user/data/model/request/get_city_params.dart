import 'package:starter_application/core/params/base_params.dart';

class GetCityParams extends BaseParams{
   int type;
   int? maxResultCount;

   GetCityParams({
     required this.type,
      this.maxResultCount,
});

  @override
  Map<String, dynamic> toMap() => {
    'Type':type,
    if(maxResultCount != null)
    'MaxResultCount':maxResultCount,
  };



}