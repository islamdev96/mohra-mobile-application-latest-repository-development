import 'package:starter_application/core/entities/base_entity.dart';

class TokenRtmEntity extends BaseEntity {
  TokenRtmEntity({
    required this.uid,
    required this.token,
  });

  final String uid;
  final String token;

  @override
  List<Object?> get props => [];
}
