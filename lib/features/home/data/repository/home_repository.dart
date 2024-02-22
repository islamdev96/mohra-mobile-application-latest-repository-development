import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/home/data/datasource/ihome_remote.dart';
import 'package:starter_application/features/home/domain/entity/banners_entity.dart';
import 'package:starter_application/features/home/domain/repository/ihome_repository.dart';

@Injectable(as: IHomeRepository)
class HomeRepository extends IHomeRepository {
  final IHomeRemoteSource iHomeRemoteSource;

  HomeRepository(this.iHomeRemoteSource);

  @override
  Future<Result<AppErrors, BannersEntity>> getAllBanners(NoParams param) async{
    final remote = await iHomeRemoteSource.getAllBanners(param);
    return remote.result<BannersEntity>();
  }

}
