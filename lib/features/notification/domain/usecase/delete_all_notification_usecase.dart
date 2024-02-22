import 'package:injectable/injectable.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/repository/inews_repository.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/notification/domain/repository/inotification_repository.dart';
import 'package:starter_application/features/religion/domain/repository/ireligion_repository.dart';

@injectable
class DeleteAllNotificationUsecase
    extends UseCase<EmptyResponse, NoParams> {
  final INotificationRepository repository;

  DeleteAllNotificationUsecase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(NoParams param) {
    return repository.deleteAllMyNotification(param);
  }
}
