import 'package:starter_application/core/params/base_params.dart';

class AllSessionsParams extends BaseParams{

  int maxResultCount;
  String? search;

  AllSessionsParams({
    required this.maxResultCount,
    this.search
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String , dynamic> res ={};
    if(search != null) res['Keyword'] = search;
     res['MaxResultCount'] = maxResultCount;
     res['isActive'] = true;
    return res;
  }
}
