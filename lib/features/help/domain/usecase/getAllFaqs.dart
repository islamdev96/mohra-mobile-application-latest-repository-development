import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/add_friend_by_qrcode_param.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
import 'package:starter_application/features/help/domain/entity/faq_entity.dart';
import 'package:starter_application/features/help/domain/repository/ihelp_repository.dart';

import '../../../../core/params/no_params.dart';
@injectable
class GetAllFaqsUseCase
    extends UseCase<FaqListEntity, NoParams> {
  final IHelpRepository repository;

  GetAllFaqsUseCase(this.repository);
  @override
  Future<Result<AppErrors, FaqListEntity>> call(NoParams param) {
    return repository.getAllFaqs(param);
  }
}
