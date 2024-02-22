import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/create_order_params.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@singleton
class CheckIfCreateOrderUseCase
    extends UseCase<EmptyResponse, CreateOrderParams> {
  final IShopRepository repository;

  CheckIfCreateOrderUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CreateOrderParams param) {
    return repository.checkIfCanCreateOrder(param);
  }
}
