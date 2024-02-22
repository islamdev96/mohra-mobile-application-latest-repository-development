import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/mylife/domain/entity/quote_entity.dart';

class QuoteModel extends BaseModel<QuoteEntity> {
  QuoteItem? result;
  Null? targetUrl;
  bool? success;
  Null? error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  QuoteModel(
      {this.result,
      this.targetUrl,
      this.success,
      this.error,
      this.unAuthorizedRequest,
      this.bAbp});

  factory QuoteModel.fromMap(Map<String, dynamic> json) => QuoteModel(
        result: json.isNotEmpty ? QuoteItem.fromMap(json) : null,
        targetUrl: json['targetUrl'],
        success: json['success'],
        error: json['error'],
        unAuthorizedRequest: json['unAuthorizedRequest'],
        bAbp: json['__abp'],
      );

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

  @override
  QuoteEntity toEntity() {
    return QuoteEntity(quote: result!.toEntity());
  }
}

class QuoteItem extends BaseModel<QuoteItemEntity> {
  int? type;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  QuoteItem(
      {this.type, this.isActive, this.arName, this.enName, this.name, this.id});

  factory QuoteItem.fromMap(Map<String, dynamic> json) => QuoteItem(
        type: json['type'],
        isActive: json['isActive'],
        arName: json['arName'],
        enName: json['enName'],
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['isActive'] = this.isActive;
    data['arName'] = this.arName;
    data['enName'] = this.enName;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }

  @override
  QuoteItemEntity toEntity() {
    return QuoteItemEntity(type: type, name: name);
  }
}
