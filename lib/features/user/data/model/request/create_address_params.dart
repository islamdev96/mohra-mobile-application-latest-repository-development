import 'package:starter_application/core/params/base_params.dart';

class CreateAddressParams extends BaseParams{

  int? id;
  String cityName;
  double latitude,longitude;
  String description,street;
  bool isCreateRequest;

  CreateAddressParams({
   required this.cityName,
   required this.street,
   required this.description,
   required this.longitude,
   required this.latitude,
   required this.isCreateRequest,
    this.id,
});

  @override
  Map<String, dynamic> toMap() {
    Map<String , dynamic> params ={};
    if(!isCreateRequest){
      params['id'] = id;
    }
    params['cityName'] = cityName;
    params['street'] = street;
    params['description'] = description;
    params['latitude'] = latitude;
    params['longitude'] = longitude;
    return params;
  }

  @override
  String toString() {
    return 'CreateAddressParams{id: $id, cityId: $cityName, latitude: $latitude, longitude: $longitude, description: $description, street: $street, isCreateRequest: $isCreateRequest}';
  }
}