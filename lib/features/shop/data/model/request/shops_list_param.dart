import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';

class ShopsListParam extends BaseParams {
  final String? sorting;
  final String? advancedSearchKeyword;
  final String? keyword;
  final double? latitude;
  final double? longitude;
  final bool? onlyFollowingShops;
  final bool isActive;
  final int? skipCount;
  final int? maxResultCount;
  ShopsListParam({
    this.sorting,
    this.advancedSearchKeyword,
    this.keyword,
    this.latitude,
    this.longitude,
    this.onlyFollowingShops,
    this.isActive = true,
    this.skipCount,
    this.maxResultCount,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'IsActive': isActive ,
      if(sorting != null)
      'Sorting': sorting,
      if(advancedSearchKeyword != null)
      'AdvancedSearchKeyword': advancedSearchKeyword,
      if(keyword != null)
      'Keyword': keyword,
      if(latitude != null)
      'Latitude': latitude,
      if(longitude != null)
      'Longitude': longitude,
      if(onlyFollowingShops != null)
      'OnlyFollowingShops': onlyFollowingShops,
      if(skipCount != null)
      'SkipCount': skipCount,
      if(maxResultCount != null)
      'MaxResultCount': maxResultCount,
      'IsActive': true,
    };
  }

}
