import '../../../../../core/params/base_params.dart';
import '../../../domain/entity/token_entity.dart';
import '../response/token_model.dart';

class MakeNotificationCallParams extends BaseParams {
  int? receiverId;
  int? callType;
  int? groupId;
  TokenModel token;

  MakeNotificationCallParams(
      {this.receiverId, this.callType, this.groupId, required this.token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiverId'] = this.receiverId;
    if (callType != null) {
      data['callType'] = this.callType;
    }
    if (groupId != null) {
      data['groupId'] = this.groupId;
    }
    data['token'] = this.token.toMap();
    return data;
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
