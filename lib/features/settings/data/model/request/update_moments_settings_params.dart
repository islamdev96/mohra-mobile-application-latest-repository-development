import 'package:starter_application/core/params/base_params.dart';

class UpdateMomentsSettingsParams extends BaseParams {
  UpdateMomentsSettingsParams({
    required this.clientId,
    required this.momentPrivacy,
  });

  final int clientId;
  final int momentPrivacy;

  @override
  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'momentPrivacy': momentPrivacy,
    };
  }
}
