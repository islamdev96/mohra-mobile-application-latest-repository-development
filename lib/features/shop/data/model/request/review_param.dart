import 'package:starter_application/core/params/base_params.dart';

class ReviewParam extends BaseParams {
  final int? RefType;
  final int? RefId;

  ReviewParam({this.RefId, this.RefType});
  @override
  Map<String, dynamic> toMap() => {
        "RefType": RefType,
        "RefId": RefId,
      };

  ReviewParam copyWith({int? RefType, int? RefId}) {
    return ReviewParam(
      RefType: RefType ?? this.RefType,
      RefId: RefId ?? this.RefId,
    );
  }
}
