import '../../../../../core/params/base_params.dart';

class OpenAppRequest extends BaseParams {
  int? userId;
  double? long;
  double? lat;
  String? devicedId;
  int? devicedType;

  OpenAppRequest(
      {this.userId, this.long, this.lat, this.devicedId, this.devicedType});

  OpenAppRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    long = json['long'];
    lat = json['lat'];
    devicedId = json['devicedId'];
    devicedType = json['devicedType'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['devicedId'] = this.devicedId;
    data['devicedType'] = this.devicedType;
    return data;
  }
}
