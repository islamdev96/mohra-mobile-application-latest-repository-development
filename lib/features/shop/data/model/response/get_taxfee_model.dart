import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/data/model/response/event_model.dart';

class GetSettingModel extends BaseModel {
  double? percentage;
  List<PaymentMethods>? paymentMethods;
  List<ShippingMethods>? shippingMethods;

  GetSettingModel({this.percentage, this.paymentMethods, this.shippingMethods});

  GetSettingModel.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    if (json['paymentMethods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['paymentMethods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    if (json['shippingMethods'] != null) {
      shippingMethods = <ShippingMethods>[];
      json['shippingMethods'].forEach((v) {
        shippingMethods!.add(new ShippingMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentage'] = this.percentage;
    if (this.paymentMethods != null) {
      data['paymentMethods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.shippingMethods != null) {
      data['shippingMethods'] =
          this.shippingMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  BaseEntity toEntity() {
    throw UnimplementedError();
  }
}

class PaymentMethods {
  int? id;
  String? name;

  PaymentMethods({this.id, this.name});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ShippingMethods {
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? image;
  int? maxDuration;
  int? maniDuration;
  double? fee;
  bool? isActive;
  int? id;

  ShippingMethods(
      {this.nameAr,
        this.nameEn,
        this.descriptionAr,
        this.descriptionEn,
        this.image,
        this.maxDuration,
        this.maniDuration,
        this.fee,
        this.isActive,
        this.id});

  ShippingMethods.fromJson(Map<String, dynamic> json) {
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    descriptionAr = json['descriptionAr'];
    descriptionEn = json['descriptionEn'];
    image = json['image'];
    maxDuration = json['maxDuration'];
    maniDuration = json['maniDuration'];
    fee = json['fee'];
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    data['descriptionAr'] = this.descriptionAr;
    data['descriptionEn'] = this.descriptionEn;
    data['image'] = this.image;
    data['maxDuration'] = this.maxDuration;
    data['maniDuration'] = this.maniDuration;
    data['fee'] = this.fee;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    return data;
  }
}