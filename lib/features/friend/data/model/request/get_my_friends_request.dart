import 'package:starter_application/core/params/base_params.dart';

class GetMyFriendsRequest extends BaseParams {
  GetMyFriendsRequest(
      {this.keyword,
      this.sorting,
      this.skipCount,
      this.maxResultCount,
      this.isBlock,
      this.isMuted,

      });

  final String? keyword;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;
  final bool? isBlock;
  final bool? isMuted;

  factory GetMyFriendsRequest.fromMap(Map<String, dynamic> json) =>
      GetMyFriendsRequest(
        keyword: json["keyword"] == null ? null : json["keyword"],
        sorting: json["sorting"] == null ? null : json["sorting"],
        isBlock: json["isBlock"] == null ? null : json["isBlock"],
        isMuted: json["isMuted"] == null ? null : json["isMuted"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount: json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (keyword != null) map["keyword"] = keyword;
    if (sorting != null) map["sorting"] = sorting;
    if (skipCount != null) map["skipCount"] = skipCount;
    if (isBlock != null) map["isBlock"] = isBlock;
    if (isMuted != null) map["isMuted"] = isMuted;
    if (maxResultCount != null) map["maxResultCount"] = maxResultCount;
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GetMyFriendsRequest &&
      other.keyword == keyword &&
      other.sorting == sorting &&
      other.skipCount == skipCount &&
      other.maxResultCount == maxResultCount &&
      other.isBlock == isBlock;
  }

  @override
  int get hashCode {
    return keyword.hashCode ^
      sorting.hashCode ^
      skipCount.hashCode ^
      maxResultCount.hashCode ^
      isBlock.hashCode;
  }
}
