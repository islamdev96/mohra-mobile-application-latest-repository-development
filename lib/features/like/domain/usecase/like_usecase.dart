import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/domain/entity/like_entity.dart';
import 'package:starter_application/features/like/domain/repository/ilike_repository.dart';

@injectable
class LikeActionUseCase extends UseCase<LikeEntity, LikeRequest> {
  ILikeRepository likeRepository;
  LikeActionUseCase(this.likeRepository);

  @override
  Future<Result<AppErrors, LikeEntity>> call(LikeRequest param) async {
    return await likeRepository.like(param);
  }
}
