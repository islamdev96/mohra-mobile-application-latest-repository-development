import 'package:starter_application/core/params/base_params.dart';

class UpdateCommentsSettingsParams extends BaseParams {
  UpdateCommentsSettingsParams({
    required this.clientId,
    required this.commentPrivacy,
  });

  final int clientId;
  final int commentPrivacy;

  @override
  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'commentPrivacy': commentPrivacy,
    };
  }
}
