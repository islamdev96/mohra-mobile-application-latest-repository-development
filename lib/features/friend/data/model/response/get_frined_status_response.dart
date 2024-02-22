import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';

class GetFrinedStatusModel extends BaseModel<GetFrinedStatusEntity>{
  bool? isBlock;
  bool? isMuted;
  bool? friendMuted;
  bool? friendBlocked;

  GetFrinedStatusModel({this.isBlock, this.isMuted,this.friendBlocked,this.friendMuted});

  GetFrinedStatusModel.fromJson(Map<String, dynamic> json) {
    isBlock = json['isBlock'];
    isMuted = json['isMuted'];
    friendMuted = json['friendMuted'];
    friendBlocked = json['friendBlocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isBlock'] = this.isBlock;
    data['isMuted'] = this.isMuted;
    data['friendMuted'] = this.friendMuted;
    data['friendBlocked'] = this.friendBlocked;
    return data;
  }

  @override
  GetFrinedStatusEntity toEntity() {
    return GetFrinedStatusEntity(
      isBlock: isBlock,
      isMuted: isMuted,
      friendBlocked: friendBlocked,friendMuted: friendMuted
    );
  }
}