import 'package:starter_application/core/entities/base_entity.dart';

import 'package:starter_application/core/entities/base_entity.dart';

class SliderEntity extends BaseEntity {
  SliderEntity({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  ResultEntity? result;
  dynamic? targetUrl;
  bool? success;
  dynamic? error;
  bool? unAuthorizedRequest;
  bool? abp;

  @override
  List<Object?> get props => [];
}

class ResultEntity extends BaseEntity {
  ResultEntity({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<ItemEntity>? items;

  @override
  List<Object?> get props => [];
}

class ItemEntity extends BaseEntity {
  ItemEntity({
    this.imageUrl,
    this.productId,
    this.shopName,
    this.shopId,
    this.startDate,
    this.endDate,
    this.isActive,
    this.id,
  });

  String? imageUrl;
  int? shopId;
  int? productId;
  String? shopName;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  int? id;

  @override
  List<Object?> get props => [];
}
