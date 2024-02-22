import 'package:dartz/dartz.dart';
import 'package:starter_application/core/datasources/remote_data_source.dart';

import '../../../../core/errors/app_errors.dart';
import '../../../../core/params/no_params.dart';
import '../model/response/banners_model.dart';

abstract class IHomeRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, BannersModel>> getAllBanners(NoParams param);

}
