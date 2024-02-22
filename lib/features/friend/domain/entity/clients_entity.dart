import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

class ClientsEntity extends BaseEntity {
  ClientsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ClientEntity> items;

  @override
  List<Object?> get props => [];
}
