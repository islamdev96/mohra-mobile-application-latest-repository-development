import 'package:starter_application/core/entities/base_entity.dart';

class HasAvatarEntity extends BaseEntity {
  HasAvatarEntity({
    required this.hasAvatar,
  });

  bool hasAvatar;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}
