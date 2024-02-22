
import 'package:starter_application/core/entities/base_entity.dart';


class FaqListEntity extends BaseEntity {
  FaqListEntity({
    required this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<FaqItemEntity?>? items;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class FaqItemEntity extends BaseEntity {
  FaqItemEntity({
    required this.arQuestion,
    required this.enQuestion,
    required this.arAnswer,
    required this.enAnswer,
    required this.order,
    required this.isActive,
    required this.id,
  });

  final String? arQuestion;
  final String? enQuestion;
  final String? arAnswer;
  final String? enAnswer;
  final int? order;
  final bool? isActive;
  final int? id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}
