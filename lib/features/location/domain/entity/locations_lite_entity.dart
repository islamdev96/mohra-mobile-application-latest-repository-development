import 'package:starter_application/core/entities/base_entity.dart';

import 'location_lite_entity.dart';

class LocationsLiteEntity extends BaseEntity {
  LocationsLiteEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<LocationLiteEntity> items;

  @override
  List<Object?> get props => [];
}
