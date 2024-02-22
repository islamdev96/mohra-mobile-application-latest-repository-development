import 'package:starter_application/core/common/date_utils.dart';
import 'package:starter_application/core/entities/base_entity.dart';

class TimeTableListEntity extends BaseEntity {
  TimeTableListEntity({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<TimeTableItemEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}

class TimeTableItemEntity extends BaseEntity {
  TimeTableItemEntity({
    required this.title,
    required this.arTitle,
    required this.enTitle,
    required this.date,
    required this.clientId,
    required this.creatorUserId,
    required this.selected,
    required this.order,
    required this.isActive,
    required this.id,
    required this.isDefault,
  });

  final String? title;
  final String? arTitle;
  final String? enTitle;
  final DateTime date;
  final int? clientId;
  final int? creatorUserId;
  final bool selected;
  final int order;
  final bool isActive;
  final bool isDefault;
  final int id;

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  getDurationInDays() {
    Duration diff =
        DateUtility.differenceBetweenTwoDays(this.date, DateTime.now());
    return diff.inDays < 0 ? 0 : diff.inDays;
  }
}
