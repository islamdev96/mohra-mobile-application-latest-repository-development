import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/help/domain/repository/ihelp_repository.dart';

import '../../../../core/params/no_params.dart';
import '../entity/about_us_entity.dart';
@injectable
class GetAboutUsUseCase
    extends UseCase<AboutUsEntity, NoParams> {
  final IHelpRepository repository;

  GetAboutUsUseCase(this.repository);
  @override
  Future<Result<AppErrors, AboutUsEntity>> call(NoParams param) {
    return repository.getAboutUs(param);
  }
}
