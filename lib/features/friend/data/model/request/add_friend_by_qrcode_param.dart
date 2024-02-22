import 'package:starter_application/core/params/base_params.dart';

class AddFriendByQrCodeParam extends BaseParams {
  final String id;

  AddFriendByQrCodeParam(this.id);

  @override
  Map<String, dynamic> toMap() => {"qrCode": id};
}
