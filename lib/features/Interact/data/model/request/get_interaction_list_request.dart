import 'package:starter_application/core/params/base_params.dart';

class GetInteractionListParams extends BaseParams{
  int refType;
  int refId;

  GetInteractionListParams({
    required this.refId,
    required this.refType,
});

  @override
  Map<String, dynamic> toMap() {
    return {
      'RefType':refType,
      'RefId':refId,
    };
  }
}