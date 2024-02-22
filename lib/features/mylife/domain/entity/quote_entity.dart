import 'package:starter_application/core/entities/base_entity.dart';

class QuoteEntity extends BaseEntity {
  final QuoteItemEntity quote;

  QuoteEntity({
    required this.quote,
  });

  @override
  List<Object?> get props => [];
}

class QuoteItemEntity extends BaseEntity {
  QuoteItemEntity(
      {this.type, this.isActive, this.arName, this.enName, this.name, this.id});

  int? type;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  @override
  List<Object?> get props => [];
}
