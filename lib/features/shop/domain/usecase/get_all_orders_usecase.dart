import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/domain/entity/events_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/shop/data/model/response/orders_model.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetOrderssUseCase extends UseCase<OrdersModel, GetAllNotificationParam> {
  IShopRepository _iShopRepository;

  GetOrderssUseCase(this._iShopRepository);

  @override
  Future<Result<AppErrors, OrdersModel>> call(GetAllNotificationParam params) async {
    return await _iShopRepository.getAllOrder(params);
  }
}
