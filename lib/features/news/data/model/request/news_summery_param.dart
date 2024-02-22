import 'package:starter_application/core/params/base_params.dart';

class NewsSummerParam extends BaseParams {
  String date;
  int city;
  final int? skipCount;
  final int? maxResultCount;

  NewsSummerParam({required this.date, required this.city, this.skipCount,
    this.maxResultCount,});

  @override
  Map<String, dynamic> toMap() => {
        "Date": date,
        "City": city,
    'skipCount': skipCount == null ? 0 : skipCount,
    'maxResultCount':
    maxResultCount == null ? 10 : maxResultCount,
      };
}
