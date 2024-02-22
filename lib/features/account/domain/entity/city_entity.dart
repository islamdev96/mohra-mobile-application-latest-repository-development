import 'package:starter_application/core/entities/base_entity.dart';

class CityListEntity extends BaseEntity {
  CityListEntity({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<CityEntity> items;

  @override
  List<Object?> get props => [
        this.items,
        this.totalCount,
      ];
}

class CityEntity extends BaseEntity {
  CityEntity({
    required this.parentId,
    required this.flag,
    required this.shopsCount,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    required this.id,
  });

  int parentId;
  String? flag;
  int shopsCount;
  bool isActive;
  String arName;
  String enName;
  String name;
  int id;

  @override
  List<Object?> get props => [
        this.parentId,
        this.flag,
        this.shopsCount,
        this.isActive,
        this.arName,
        this.enName,
        this.name,
        this.id,
      ];
}
