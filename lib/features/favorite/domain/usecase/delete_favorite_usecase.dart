import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/repository/ifavorite_repository.dart';

@injectable
class DeleteFavoriteUseCase
    extends UseCase<EmptyResponse, DeleteFavoriteParams> {
  IFavoriteRepository favoriteRepository;
  DeleteFavoriteUseCase(this.favoriteRepository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      DeleteFavoriteParams param) async {
    return await favoriteRepository.deleteFavorite(param);
  }
}
