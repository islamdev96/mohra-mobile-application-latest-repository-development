import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@singleton
class DeleteShippingAddressUseCase extends UseCase<EmptyResponse, IdParam> {
  final IShopRepository repository;

  DeleteShippingAddressUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(IdParam param) {
    return repository.deleteShippingAddress(param);
  }
}
