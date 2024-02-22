import 'package:starter_application/core/entities/base_entity.dart';

class UserSettingsItemEntity extends BaseEntity {
  UserSettingsItemEntity({
    required this.privateAccount,
    required this.allowFriendRequests,
    required this.groupRequests,
    required this.hidenMyLocation,
    required this.momentPrivacy,
    required this.commentPrivacy,
    required this.countUserBlock,
    required this.countUserMute,
    required this.id,
  });

  final bool? privateAccount;
  final bool? allowFriendRequests;
  final bool? groupRequests;
  final bool? hidenMyLocation;
  final int? momentPrivacy;
  final int? commentPrivacy;
  final int? countUserBlock;
  final int? countUserMute;
  final int? id;


  @override
  // TODO: implement props
  List<Object?> get props => [];
}