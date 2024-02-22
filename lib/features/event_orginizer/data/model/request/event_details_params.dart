import '../../../../../core/params/base_params.dart';

class EventDetailsParams extends BaseParams {
  final int id;

  EventDetailsParams({
    required this.id,
});

  factory EventDetailsParams.fromMap(Map<String, dynamic> json) => EventDetailsParams(
    id:json['id']
  );

  Map<String, dynamic> toMap() => {
    "EventId":id
  };
}