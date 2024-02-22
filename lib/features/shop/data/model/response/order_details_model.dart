import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/models/base_model.dart';

class OrderDetailsModel extends BaseModel {
  String? number;
  String? couponCode;
  int? paymentMethod;
  int? status;
  String? creationTime;
  List<OrderDetailsItems>? items;
  List<Actions>? actions;
  double? productsPrice;
  double? taxFee;
  double? shippingFee;
  double? totalOrderFee;
  String? extraInformation;
  Creator? deliveryBoy;
  String? pickupDate;
  int? deliveryOption;
  Shop? shop;
  Client? client;
  bool? isLatePending;
  int? shippingAddressId;
  ShippingAddress? shippingAddress;
  int? addressCityId;
  String? streetAddress;
  String? buildingNoAddress;
  String? zipCodeAddress;
  int? addressType;
  String? invoice;
  int? id;

  OrderDetailsModel(
      {this.number,
      this.paymentMethod,
      this.couponCode,
      this.status,
      this.creationTime,
      this.items,
      this.actions,
      this.productsPrice,
      this.taxFee,
      this.shippingFee,
      this.totalOrderFee,
      this.extraInformation,
      this.deliveryBoy,
      this.pickupDate,
      this.deliveryOption,
      this.shop,
      this.client,
      this.isLatePending,
      this.shippingAddressId,
      this.shippingAddress,
      this.addressCityId,
      this.streetAddress,
      this.buildingNoAddress,
      this.zipCodeAddress,
      this.addressType,
      this.invoice,
      this.id});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    couponCode = json['couponCode'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    creationTime = json['creationTime'];
    if (json['items'] != null) {
      items = <OrderDetailsItems>[];
      json['items'].forEach((v) {
        items!.add(new OrderDetailsItems.fromJson(v));
      });
    }
    if (json['actions'] != null) {
      actions = <Actions>[];
      json['actions'].forEach((v) {
        actions!.add(new Actions.fromJson(v));
      });
    }
    productsPrice = json['productsPrice'];
    taxFee = json['taxFee'];
    shippingFee = json['shippingFee'];
    totalOrderFee = json['totalOrderFee'];
    extraInformation = json['extraInformation'];
    deliveryBoy = json['deliveryBoy'] != null
        ? new Creator.fromJson(json['deliveryBoy'])
        : null;
    pickupDate = json['pickupDate'];
    deliveryOption = json['deliveryOption'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    isLatePending = json['isLatePending'];
    shippingAddressId = json['shippingAddressId'];
    shippingAddress = json['shippingAddress'] != null
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    addressCityId = json['addressCityId'];
    streetAddress = json['streetAddress'];
    buildingNoAddress = json['buildingNoAddress'];
    zipCodeAddress = json['zipCodeAddress'];
    addressType = json['addressType'];
    invoice = json['invoice'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['couponCode'] = this.couponCode;
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['creationTime'] = this.creationTime;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.actions != null) {
      data['actions'] = this.actions!.map((v) => v.toJson()).toList();
    }
    data['productsPrice'] = this.productsPrice;
    data['taxFee'] = this.taxFee;
    data['shippingFee'] = this.shippingFee;
    data['totalOrderFee'] = this.totalOrderFee;
    data['extraInformation'] = this.extraInformation;
    if (this.deliveryBoy != null) {
      data['deliveryBoy'] = this.deliveryBoy!.toJson();
    }
    data['pickupDate'] = this.pickupDate;
    data['deliveryOption'] = this.deliveryOption;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['isLatePending'] = this.isLatePending;
    data['shippingAddressId'] = this.shippingAddressId;
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    data['addressCityId'] = this.addressCityId;
    data['streetAddress'] = this.streetAddress;
    data['buildingNoAddress'] = this.buildingNoAddress;
    data['zipCodeAddress'] = this.zipCodeAddress;
    data['addressType'] = this.addressType;
    data['invoice'] = this.invoice;
    data['id'] = this.id;
    return data;
  }

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class OrderDetailsItems extends BaseModel {
  int? orderId;
  int? productId;
  Product? product;
  int? quantity;
  double? price;
  String? scheduledDeliveryDate;
  double? totalPrice;
  int? id;

  OrderDetailsItems(
      {this.orderId,
      this.productId,
      this.product,
      this.quantity,
      this.price,
      this.scheduledDeliveryDate,
      this.totalPrice,
      this.id});

  OrderDetailsItems.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    productId = json['productId'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    price = json['price'];
    scheduledDeliveryDate = json['scheduledDeliveryDate'];
    totalPrice = json['totalPrice'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['scheduledDeliveryDate'] = this.scheduledDeliveryDate;
    data['totalPrice'] = this.totalPrice;
    data['id'] = this.id;
    return data;
  }

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class Product extends BaseModel {
  String? imageUrl;
  double? price;
  String? description;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  Product(
      {this.imageUrl,
      this.price,
      this.description,
      this.isActive,
      this.arName,
      this.enName,
      this.name,
      this.id});

  Product.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];

    price = json['price'];
    description = json['description'];
    isActive = json['isActive'];
    arName = json['arName'];
    enName = json['enName'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['arName'] = this.arName;
    data['enName'] = this.enName;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class Actions {
  int? orderId;
  int? name;
  Creator? creator;
  String? creationTime;
  int? id;

  Actions({this.orderId, this.name, this.creator, this.creationTime, this.id});

  Actions.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    name = json['name'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['name'] = this.name;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }
}

class Creator {
  String? value;
  String? text;

  Creator({this.value, this.text});

  Creator.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}

class Shop {
  int? id;
  String? logoUrl;
  String? coverUrl;
  String? name;
  String? shopManagerEmail;
  String? description;
  int? followersCount;
  bool? isFollowed;

  Shop(
      {this.id,
      this.logoUrl,
      this.coverUrl,
      this.name,
      this.shopManagerEmail,
      this.description,
      this.followersCount,
      this.isFollowed});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoUrl = json['logoUrl'];
    coverUrl = json['coverUrl'];
    name = json['name'];
    shopManagerEmail = json['shopManagerEmail'];
    description = json['description'];
    followersCount = json['followersCount'];
    isFollowed = json['isFollowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logoUrl'] = this.logoUrl;
    data['coverUrl'] = this.coverUrl;
    data['name'] = this.name;
    data['shopManagerEmail'] = this.shopManagerEmail;
    data['description'] = this.description;
    data['followersCount'] = this.followersCount;
    data['isFollowed'] = this.isFollowed;
    return data;
  }
}

class Client {
  String? imageUrl;
  String? name;
  String? phoneNumber;
  String? emailAddress;
  int? points;
  bool? isFriend;
  int? id;

  Client(
      {this.imageUrl,
      this.name,
      this.phoneNumber,
      this.emailAddress,
      this.points,
      this.isFriend,
      this.id});

  Client.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    emailAddress = json['emailAddress'];
    points = json['points'];
    isFriend = json['isFriend'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['emailAddress'] = this.emailAddress;
    data['points'] = this.points;
    data['isFriend'] = this.isFriend;
    data['id'] = this.id;
    return data;
  }
}

class ShippingAddress {
  int? addressType;
  String? fullName;
  String? streetAddress;
  String? buildingNo;
  String? zipCode;
  int? cityId;
  String? phoneNumber;
  String? creationTime;
  int? id;

  ShippingAddress(
      {this.addressType,
      this.fullName,
      this.streetAddress,
      this.buildingNo,
      this.zipCode,
      this.cityId,
      this.phoneNumber,
      this.creationTime,
      this.id});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    fullName = json['fullName'];
    streetAddress = json['streetAddress'];
    buildingNo = json['buildingNo'];
    zipCode = json['zipCode'];
    cityId = json['cityId'];
    phoneNumber = json['phoneNumber'];
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressType'] = this.addressType;
    data['fullName'] = this.fullName;
    data['streetAddress'] = this.streetAddress;
    data['buildingNo'] = this.buildingNo;
    data['zipCode'] = this.zipCode;
    data['cityId'] = this.cityId;
    data['phoneNumber'] = this.phoneNumber;
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }
}
