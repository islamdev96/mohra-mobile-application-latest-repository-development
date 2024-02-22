import 'package:starter_application/core/params/base_params.dart';

class CheckDreamParams extends BaseParams {
  List<int> list;
  int type ;
  CheckDreamParams({required this.list ,required this.type });

  @override
  Map<String, dynamic> toMap() => {
    "iDs": list,
  };
}
