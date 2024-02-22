import 'package:starter_application/core/entities/base_entity.dart';

import 'nearby_client_entity.dart';

class NearbyClientsEntity extends BaseEntity {
  NearbyClientsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<NearbyClientEntity> items;

  @override
  List<Object?> get props => [];
}
