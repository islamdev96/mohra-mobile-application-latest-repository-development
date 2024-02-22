import 'package:starter_application/core/entities/base_entity.dart';

class GetFrinedStatusEntity extends BaseEntity {
  bool? isBlock;
  bool? isMuted;
  bool? friendMuted;
  bool? friendBlocked;

  GetFrinedStatusEntity({this.isBlock, this.isMuted,this.friendBlocked,this.friendMuted});

  GetFrinedStatusEntity.fromJson(Map<String, dynamic> json) {
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
  List<Object?> get props => [isBlock,isMuted,friendMuted,friendBlocked];
}