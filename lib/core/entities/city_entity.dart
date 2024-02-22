import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/entities/country_entity.dart';

class CityEntity extends BaseEntity {
  CityEntity({
    this.country,
    required this.value,
    required this.text,
  });

  final CountryEntity? country;
  final String value;
  final String text;

  @override
  List<Object?> get props => [];
}
