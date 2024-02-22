import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_by_ref_params.dart';
import 'package:starter_application/features/favorite/domain/repository/ifavorite_repository.dart';

@injectable
class DeleteFavoriteByRefUseCase
    extends UseCase<EmptyResponse, DeleteFavoriteByRefParams> {
  IFavoriteRepository favoriteRepository;
  DeleteFavoriteByRefUseCase(this.favoriteRepository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      DeleteFavoriteByRefParams param)  {
    return  favoriteRepository.deleteFavoriteByRef(param);
  }
}
