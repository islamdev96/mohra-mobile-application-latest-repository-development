import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/moment/data/model/request/get_client_points_request.dart';
import 'package:starter_application/features/moment/domain/entity/points_entity.dart';
import 'package:starter_application/features/moment/domain/repository/imoment_repository.dart';

@injectable
class GetPointsUseCase extends UseCase<PointsEntity, GetClientPointsRequest> {
  IMomentRepository _iMomentRepository;

  GetPointsUseCase(this._iMomentRepository);

  @override
  Future<Result<AppErrors, PointsEntity>> call(GetClientPointsRequest param) async {
    return await _iMomentRepository.getPoints(param);
  }
}
