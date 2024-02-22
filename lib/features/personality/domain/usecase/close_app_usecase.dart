import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';

import '../../data/model/request/open_app_request.dart';

@singleton
class CloseAppUsecase extends UseCase<EmptyResponse, OpenAppRequest> {
  final IPersonalityRepository iPersonalityRepository;

  CloseAppUsecase(this.iPersonalityRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(OpenAppRequest param) {
    return iPersonalityRepository.closeApp(param);
  }
}
