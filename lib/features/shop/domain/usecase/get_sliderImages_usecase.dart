import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/get_slider_images_param.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetSliderImagesUsecase extends UseCase<SliderEntity, GetSliderImagesParam> {
  final IShopRepository repository;

  GetSliderImagesUsecase(this.repository);
  @override
  Future<Result<AppErrors, SliderEntity>> call(GetSliderImagesParam param) {
    return repository.getSliderImages(param);
  }
}
