import 'package:starter_application/core/entities/base_entity.dart';

class LocationLiteEntity extends BaseEntity {
  LocationLiteEntity({
    required this.value,
    required this.text,
  });

  final String value;
  final String text;

  @override
  List<Object?> get props => [value];


  bool isContain(String? text){
    if(text == null) return true;
    if(text.isEmpty) return true;
    if(this.text.toLowerCase().contains(text.toLowerCase())) return true;
    return false;
  }
}
