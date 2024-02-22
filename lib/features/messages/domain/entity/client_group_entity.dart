import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

class ClientGroupEntity extends BaseEntity {
  ClientGroupEntity({
    this.clientId,
    this.client,
    this.groupId,
  });

  final int? clientId;
  final ClientEntity? client;
  final int? groupId;

  @override
  List<Object?> get props => [];
}
