import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/domain/repository/ilike_repository.dart';

@injectable
class UnlikeUseCase extends UseCase<EmptyResponse, LikeRequest> {
  ILikeRepository likeRepository;
  UnlikeUseCase(this.likeRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(LikeRequest param) async {
    return await likeRepository.unlike(param);
  }
}
