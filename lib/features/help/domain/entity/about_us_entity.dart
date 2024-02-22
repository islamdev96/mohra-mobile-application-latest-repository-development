import '../../../../core/entities/base_entity.dart';

class AboutUsEntity extends BaseEntity {
  String? arTitle;
  String? enTitle;
  String? arContent;
  String? enContent;
  bool? isActive;
  int? id;

  AboutUsEntity(
      {this.arTitle,
      this.enTitle,
      this.arContent,
      this.enContent,
      this.isActive,
      this.id});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
