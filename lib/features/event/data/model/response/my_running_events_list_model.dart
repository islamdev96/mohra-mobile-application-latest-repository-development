import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/my_running_events_list_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

class MyRunningEventsListModel extends BaseModel<MyRunningEventsListEntity> {
  final int? totalCount;
  final List<MyRunningEventModel> items;
  MyRunningEventsListModel({
    required this.totalCount,
    required this.items,
  });
  factory MyRunningEventsListModel.fromMap(Map<String, dynamic> map) {
    return MyRunningEventsListModel(
      totalCount: numV(map['totalCount']),
      items: map['items'] == null ? [] : List<MyRunningEventModel>.from(
          map['items']?.map((x) => MyRunningEventModel.fromMap(x))),
    );
  }

  @override
  MyRunningEventsListEntity toEntity() {
    return MyRunningEventsListEntity(
      totalCount: totalCount,
      items: items.toListEntity(),
    );
  }
}

class MyRunningEventModel extends BaseModel<MyRunningEventEntity> {
  final String? value;
  final String? text;
  MyRunningEventModel({
    required this.value,
    required this.text,
  });

  factory MyRunningEventModel.fromMap(Map<String, dynamic> map) {
    return MyRunningEventModel(
      value: stringV(map['value']),
      text: stringV(map['text']),
    );
  }

  @override
  MyRunningEventEntity toEntity() {
    return MyRunningEventEntity(
      value: value,
      text: text,
    );
  }
}
