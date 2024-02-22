import '../../../../../core/models/base_model.dart';
import '../../../domain/entity/about_us_entity.dart';

class AboutUs {
  AboutUsModel? result;
  dynamic targetUrl;
  bool? success;
  dynamic error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  AboutUs(
      {this.result,
      this.targetUrl,
      this.success,
      this.error,
      this.unAuthorizedRequest,
      this.bAbp});

  factory AboutUs.fromJson(Map<String, dynamic> json) {
    return AboutUs(
      result: json['result'] != null
          ? new AboutUsModel.fromJson(json['result'])
          : null,
      targetUrl: json['targetUrl'],
      success: json['success'],
      error: json['error'],
      unAuthorizedRequest: json['unAuthorizedRequest'],
      bAbp: json['__abp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['targetUrl'] = this.targetUrl;
    data['success'] = this.success;
    data['error'] = this.error;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class AboutUsModel extends BaseModel<AboutUsEntity> {
  String? arTitle;
  String? enTitle;
  String? arContent;
  String? enContent;
  bool? isActive;
  int? id;

  AboutUsModel(
      {this.arTitle,
      this.enTitle,
      this.arContent,
      this.enContent,
      this.isActive,
      this.id});

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      arTitle: json['arTitle'],
      enTitle: json['enTitle'],
      arContent: json['arContent'],
      enContent: json['enContent'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['arContent'] = this.arContent;
    data['enContent'] = this.enContent;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    return data;
  }

  @override
  AboutUsEntity toEntity() {
    return AboutUsEntity(
        arTitle: arTitle,
        arContent: arContent,
        enContent: enContent,
        enTitle: enTitle,
        isActive: isActive);
  }
}
