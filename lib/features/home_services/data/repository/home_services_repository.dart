import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/home/data/datasource/ihome_remote.dart';
import 'package:starter_application/features/home/domain/entity/banners_entity.dart';
import 'package:starter_application/features/home/domain/repository/ihome_repository.dart';
import 'package:starter_application/features/home_services/data/datasource/ihome_services_remote.dart';
import 'package:starter_application/features/home_services/domain/repository/ihome_services_repository.dart';

class HomeServicesRepository extends IHomeServicesRepository {
  final IHomeServicesRemoteSource iHomeServicesRemoteSource;

  HomeServicesRepository(this.iHomeServicesRemoteSource);


  // @override
  // Future<Result<AppErrors, BannersEntity>> getAllBanners(NoParams param) async{
  //   final remote = await iHomeRemoteSource.getAllBanners(param);
  //   return remote.result<BannersEntity>();
  // }

}
