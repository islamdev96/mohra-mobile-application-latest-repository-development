import 'package:injectable/injectable.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/moment/data/model/request/find_place_param.dart';
import 'package:starter_application/features/moment/domain/entity/find_place_result_list_entity.dart';
import 'package:starter_application/features/moment/domain/repository/imoment_repository.dart';

@injectable
class FindPlaceUseCase
    extends UseCase<FindPlaceResultListEntity, FindPlaceParam> {
  final IMomentRepository repository;

  FindPlaceUseCase(this.repository);
  @override
  Future<Result<AppErrors, FindPlaceResultListEntity>> call(
      FindPlaceParam param) {
    return repository.findPlace(param);
  }
}
