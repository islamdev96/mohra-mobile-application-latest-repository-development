import 'package:starter_application/core/entities/base_entity.dart';

class CountryEntity extends BaseEntity {
  CountryEntity({
    required this.flag,
    required this.value,
    required this.text,
  });

  final String flag;
  final String value;
  final String text;

  @override
  List<Object?> get props => [];
}
