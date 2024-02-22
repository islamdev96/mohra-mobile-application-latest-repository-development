import 'package:starter_application/core/params/base_params.dart';

class CheckTasksRequest extends BaseParams {
  List<int> list;
  int type;

  CheckTasksRequest({required this.list ,this.type = 0});

  @override
  Map<String, dynamic> toMap() => {
        "iDs": list,
      };
}
