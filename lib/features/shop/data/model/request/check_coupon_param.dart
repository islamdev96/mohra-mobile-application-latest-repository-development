import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/base_params.dart';

class CheckCouponParam extends BaseParams {
  final String code;
  final List<int> products;
  CheckCouponParam({
    required this.code,
    required this.products,
  });
  @override
  Map<String, dynamic> toMap() => {
        'Code': code,
        'ClientId': UserSessionDataModel.userId,
        'Products':products,
      };
}
