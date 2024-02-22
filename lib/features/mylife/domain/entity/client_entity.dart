import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';

class ClientEntity extends BaseEntity {
  final List<ClientItemEntity>? items;

  final int? totalCount;

  ClientEntity(
      {this.items,
      this.totalCount,
 });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ClientItemEntity extends BaseEntity {
  ClientItemEntity({
    this.value,
    this.text,
    this.imageUrl,
    this.avatar,
  });

  String? value;
  String? text;
  String? imageUrl;
  AvatarEntity? avatar;
  bool isSelect=false;

  @override
  List<Object?> get props => [];
}
