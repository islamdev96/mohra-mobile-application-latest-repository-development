import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/domain/entity/event_categories_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

@injectable
class GetEventCategoriesUseCase
    extends UseCase<EventCategoriesEntity, NoParams> {
  IEventRepository iEventRepository;

  GetEventCategoriesUseCase(this.iEventRepository);
  @override
  Future<Result<AppErrors, EventCategoriesEntity>> call(NoParams param) async {
    return await iEventRepository.getEventCategories(param);
  }
}
