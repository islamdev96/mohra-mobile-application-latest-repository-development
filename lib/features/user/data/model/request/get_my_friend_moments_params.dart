import 'package:starter_application/core/params/base_params.dart';

class GetMyFriendMomentsParams extends BaseParams {
  int ClientId;
  int SkipCount;
  int MaxResultCount;
  String Sorting;
  GetMyFriendMomentsParams({
    required this.ClientId,
    this.SkipCount = 0,
     this.MaxResultCount = 20,
    this.Sorting = "CreationTime DESC"
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'ClientId':ClientId,
      'SkipCount':SkipCount,
      'MaxResultCount':MaxResultCount,
      "Sorting":Sorting
    };
  }

}