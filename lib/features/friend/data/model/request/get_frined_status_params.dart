import 'package:starter_application/core/params/base_params.dart';

class GetFrinedStatusParams extends BaseParams{
  int? friendId;
  int? GroupId;

  GetFrinedStatusParams({this.friendId,this.GroupId});

  GetFrinedStatusParams.fromJson(Map<String, dynamic> json) {
    friendId = json['FriendId'];
    GroupId = json['GroupId'];
  }


  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   if(friendId != null) data['FriendId'] = this.friendId;
    if(GroupId != null) data['GroupId'] = this.GroupId;
    return data;
  }
}
