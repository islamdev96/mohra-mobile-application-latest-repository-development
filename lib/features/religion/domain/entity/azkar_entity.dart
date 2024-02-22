import 'package:starter_application/core/entities/base_entity.dart';

class AzkarEntity extends BaseEntity {
  AzkarEntity({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final AzkarResultEntity result;
  final dynamic targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  List<Object?> get props => [];
}

class AzkarResultEntity extends BaseEntity {
  AzkarResultEntity({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<AzkarItemEntity>? items;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AzkarItemEntity extends BaseEntity {
  AzkarItemEntity(
      {this.arTitle,
      this.enTitle,
      this.title,
      this.content,
      this.fromDate,
      this.toDate,
      this.isActive,
      this.arContent,
      this.enContent,
      this.category,
      this.creatorUserId,
      this.createdBy,
      this.creationTime,
      this.id});

  String? arTitle;
  String? enTitle;
  String? title;
  String? content;
  String? fromDate;
  String? toDate;
  bool? isActive;
  String? arContent;
  String? enContent;
  int? category;
  int? creatorUserId;
  String? createdBy;
  String? creationTime;
  int? id;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
