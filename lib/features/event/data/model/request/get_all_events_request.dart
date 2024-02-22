import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetEventsRequest extends BaseParams {
  GetEventsRequest(
      {this.sorting,
      this.status,
      this.keyword,
      this.advancedSearchKeyword,
      this.categoryId,
      this.skipCount,
      this.maxResultCount,
      this.cityId,
      this.lat,
      this.parentId,
      this.lng,
      CancelToken? cancelToken})
      : super(cancelToken: cancelToken);

  final String? sorting;
  final int? status;
  final String? keyword;
  final String? advancedSearchKeyword;
  final int? categoryId;
  final int? parentId;
  final int? skipCount;
  final int? maxResultCount;
  final int? cityId;
  final double? lat;
  final double? lng;

  factory GetEventsRequest.fromMap(Map<String, dynamic> json) =>
      GetEventsRequest(
        sorting: json["sorting"] == null ? null : json["sorting"],
        status: json["status"] == null ? null : json["status"],
        keyword: json["keyword"] == null ? null : json["keyword"],
        parentId: json["ParentId"] = 0,
        advancedSearchKeyword: json["advancedSearchKeyword"] == null
            ? null
            : json["advancedSearchKeyword"],
        categoryId: json["categoryId"] == null || json["categoryId"] == -1
            ? null
            : json["categoryId"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
        cityId: json["cityId"] == null ? null : json["cityId"],
        lat: json["latitude"] == null ? null : json["latitude"],
        lng: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    if (sorting != null) _map['Sorting'] = sorting;
    //_map['ParentId'] = 0;
    if (categoryId != null && categoryId != -1) _map['CategoryId'] = categoryId;
    // _map['OnlyMyEvents'] = false;
    if (skipCount != null) _map['skipCount'] = skipCount;
    _map['Status'] = 1;
    // _map['Running'] = true;
    if (keyword != null) _map['keyword'] = keyword;
    if (advancedSearchKeyword != null)
      _map['advancedSearchKeyword'] = advancedSearchKeyword;

    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    if (cityId != null) _map['cityId'] = cityId;
    print("lat is $lat");
    print("lng is $lng");

    if (lat != null) _map['latitude'] = lat;
    if (lng != null) _map['longitude'] = lng;
    if (lng != null) _map['longitude'] = lng;
    _map['running'] = true;
    _map['expired'] = false;
    // _map['status'] = 1;
    // _map['IsActive'] = true;

    return _map;
  }
}
