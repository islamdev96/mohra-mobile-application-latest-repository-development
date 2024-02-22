import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/models/nearby_places_model.dart';
import 'package:starter_application/features/moment/domain/entity/find_place_result_list_entity.dart';

class FindPlaceResultListModel extends BaseModel<FindPlaceResultListEntity> {
  final List<FindPlaceResultModel> candidates;
  FindPlaceResultListModel({
    required this.candidates,
  });

  factory FindPlaceResultListModel.fromMap(Map<String, dynamic> map) {
    return FindPlaceResultListModel(
      candidates: map['candidates'] == null
          ? []
          : List<FindPlaceResultModel>.from(
              map['candidates']?.map((x) => FindPlaceResultModel.fromMap(x))),
    );
  }

  @override
  FindPlaceResultListEntity toEntity() {
    return FindPlaceResultListEntity(
      candidates: candidates.toListEntity(),
    );
  }
}

class FindPlaceResultModel extends BaseModel<FindPlaceResultEntity> {
  final String formattedAddress;
  final GeometryModel? geometry;
  final String name;
  FindPlaceResultModel({
    required this.formattedAddress,
    required this.geometry,
    required this.name,
  });

  factory FindPlaceResultModel.fromMap(Map<String, dynamic> map) {
    return FindPlaceResultModel(
      formattedAddress: stringV(map['formattedAddress']),
      geometry: map['geometry'] == null
          ? null
          : GeometryModel.fromMap(map['geometry']),
      name: stringV(map['name']),
    );
  }

  @override
  FindPlaceResultEntity toEntity() {
    return FindPlaceResultEntity(
      formattedAddress: formattedAddress,
      geometry: geometry?.toEntity(),
      name: name,
    );
  }
}
