import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

class SendFriendRequestEntity extends BaseEntity {
  SendFriendRequestEntity({
    this.senderId,
    this.sender,
    this.receiverId,
    this.receiver,
    this.creationTime,
    this.status,
    this.id,
  });

  final int? senderId;
  final ClientEntity? sender;
  final int? receiverId;
  final ClientEntity? receiver;
  final DateTime? creationTime;
  final int? status;
  final int? id;

  @override
  List<Object?> get props => [];
}
