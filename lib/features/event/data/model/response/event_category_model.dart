import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';

class EventCategoryModel extends BaseModel<EventCategoryEntity> {
  EventCategoryModel({
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    this.id,
  });

  final bool isActive;
  final String arName;
  final String enName;
  final String name;
  final int? id;

  factory EventCategoryModel.fromMap(Map<String, dynamic> json) =>
      EventCategoryModel(
        isActive: boolV(json["isActive"]),
        arName: stringV(json["arName"]),
        enName: stringV(json["enName"]),
        name: stringV(json["name"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "isActive": isActive,
        "arName": arName,
        "enName": enName,
        "name": name,
        "id": id == null ? null : id,
      };

  @override
  EventCategoryEntity toEntity() {
    return EventCategoryEntity(
        isActive: isActive, arName: arName, enName: enName, name: name, id: id);
  }
}
