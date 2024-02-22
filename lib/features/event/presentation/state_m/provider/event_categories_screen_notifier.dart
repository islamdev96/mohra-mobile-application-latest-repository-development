import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/features/event/domain/entity/event_categories_entity.dart';

class EventCategoriesScreenNotifier extends ScreenNotifier {
  EventCategoriesEntity? eventCategoriesEntity;
  @override
  void closeNotifier() {
    this.dispose();
  }
}
