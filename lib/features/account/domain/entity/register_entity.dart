import 'package:starter_application/core/entities/base_entity.dart';

class RegisterEntity extends BaseEntity {
  RegisterEntity({
    this.canLogin,
  });

  bool? canLogin;

  @override
  List<Object?> get props => [];
}
