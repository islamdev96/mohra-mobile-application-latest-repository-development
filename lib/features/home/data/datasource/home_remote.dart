import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/home/data/model/response/banners_model.dart';

import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/api_url.dart';
import 'ihome_remote.dart';

@Injectable(as: IHomeRemoteSource)
class HomeRemoteSource extends IHomeRemoteSource {
  @override
  Future<Either<AppErrors, BannersModel>> getAllBanners(NoParams param) {
    return request(
      converter: (json) => BannersModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllBanners,
    );
  }

}
