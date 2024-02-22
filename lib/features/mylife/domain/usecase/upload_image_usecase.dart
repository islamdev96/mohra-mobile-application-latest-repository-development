import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/base_params.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/features/health/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@singleton
class UploadImageUsecase extends UseCase<ImageUrlsEntity , ImageParams>{

  final IMylifeRepository iMylifeRepository;
  UploadImageUsecase(this.iMylifeRepository);

  @override
  Future<Result<AppErrors, ImageUrlsEntity>> call(ImageParams param) {
    return iMylifeRepository.uploadImage(param);
  }

}