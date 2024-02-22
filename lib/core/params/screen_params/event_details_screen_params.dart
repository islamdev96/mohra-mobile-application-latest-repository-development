import 'package:starter_application/features/event/domain/entity/event_entity.dart';

class EventDetailsScreenParams {
  final EventEntity? eventEntity;
  final int? sharedId;
  EventDetailsScreenParams({
    this.eventEntity,
    this.sharedId,
  });
}
