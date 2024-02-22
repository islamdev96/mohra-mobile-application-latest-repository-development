import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/usecases/usecase.dart';


import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/date_params.dart';
import 'package:starter_application/features/health/domain/entity/health_dashboard_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetHealthDashboardUsecase extends UseCase<HealthDashboardEntity , DateParams>{

  final IHealthRepository iHealthRepository;
  GetHealthDashboardUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, HealthDashboardEntity>> call(DateParams param) {
    return iHealthRepository.getHealthDashboard(param);
  }

}
