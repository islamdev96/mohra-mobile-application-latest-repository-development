import 'package:starter_application/core/params/base_params.dart';

class UpdateSettingsParams extends BaseParams {
  UpdateSettingsParams({
    required this.clientId,
    required this.privateAccount,
    required this.allowFriendRequests,
    required this.groupRequests,
    required this.hidenMyLocation,
    required this.momentPrivacy,
    required this.commentPrivacy,
  });

  final int clientId;
  final bool privateAccount;
  final bool allowFriendRequests;
  final bool groupRequests;
  final bool hidenMyLocation;
  final int momentPrivacy;
  final int commentPrivacy;

  @override
  Map<String, dynamic> toMap() {
   return {
     'clientId': clientId,
     'privateAccount': privateAccount,
     'allowFriendRequests': allowFriendRequests,
     'groupRequests': groupRequests,
     'hidenMyLocation': hidenMyLocation,
     'momentPrivacy': momentPrivacy,
     'commentPrivacy': commentPrivacy,
   };
  }



}
