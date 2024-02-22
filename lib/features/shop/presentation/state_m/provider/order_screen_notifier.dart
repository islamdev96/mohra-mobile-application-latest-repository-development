import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/shop/data/model/request/get_order_details_params.dart';
import 'package:starter_application/features/shop/data/model/response/orders_model.dart';
import 'package:starter_application/features/shop/domain/usecase/get_all_orders_usecase.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

enum OrderStatus {
  ALL,
  awaiting_payment,
  awaiting_fulfillment,
  Shipped,
  Completed,
  Cancelled,
  Declined,
  Refunded
}
enum BookingStatus { All, Open, COMPLETED }

class OrderScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  List<OrderItem> myItems = [];
  final RefreshController momentsRefreshController = RefreshController();
  final ShopCubit shopCubit = ShopCubit();
  bool isLoading = true;
  // final NoParams noParams = NoParams();
  bool showDetails = false;
  int orderSelected = -1;
  List<OrderItem> allOrders = [];
  List<String> iconNames = [
    Translation.current.all.toUpperCase(),
    Translation.current.awaiting_payments.toUpperCase(),
    Translation.current.awaiting_fulfillment.toUpperCase(),
    Translation.current.shipped.toUpperCase(),
    Translation.current.completed.toUpperCase(),
    Translation.current.cancelled.toUpperCase(),
    Translation.current.declined.toUpperCase(),
    Translation.current.refunded.toUpperCase()
  ];
  String selectedSort = "ALL";
  List<Order> orders = [
    Order(
        orderId: "ORDSH002133",
        date: "10 Aug 2020",
        price: "2000",
        orderStatus: OrderStatus.awaiting_fulfillment),
    Order(
        orderId: "ORDSH000002",
        date: "20 Aug 2020",
        price: "4000",
        orderStatus: OrderStatus.awaiting_fulfillment),
    Order(
        orderId: "ORDSH002133",
        date: "2 Aug 2020",
        price: "3000",
        orderStatus: OrderStatus.Shipped),
    Order(
        orderId: "ORDSH0023131",
        date: "8 Aug 2020",
        price: "5000",
        orderStatus: OrderStatus.Completed),
    Order(
        orderId: "ORDSH0023131",
        date: "8 Aug 2020",
        price: "5000",
        orderStatus: OrderStatus.awaiting_fulfillment),
    Order(
        orderId: "ORDSH0023131",
        date: "8 Aug 2020",
        price: "5000",
        orderStatus: OrderStatus.awaiting_fulfillment),
    Order(
        orderId: "ORDSH0023131",
        date: "8 Aug 2020",
        price: "5000",
        orderStatus: OrderStatus.Cancelled),
    Order(
        orderId: "ORDSH0023131",
        date: "8 Aug 2020",
        price: "5000",
        orderStatus: OrderStatus.Declined),
    Order(
        orderId: "ORDSH0023131",
        date: "8 Aug 2020",
        price: "5000",
        orderStatus: OrderStatus.Refunded),
  ];

  /// Getters and Setters
  String get selectedSortType => this.selectedSort;

  set selectedSortType(String value) {
    this.selectedSort = value;
    notifyListeners();
  }

  /// Methods
  onSelectType(String index) {
    selectedSort = index;
    notifyListeners();
  }

  Color statusColor(OrderStatus orderStatus) {
    switch (orderStatus.index) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  String statusName(OrderStatus orderStatus) {
    switch (orderStatus.index) {
      case 1:
        return Translation.current.awaiting_payments;
      case 2:
        return Translation.current.awaiting_fulfillment;
      default:
        return orderStatus.name;
    }
  }

  getAllOrders() {
    shopCubit.getAllOrders(GetAllNotificationParam(maxResultCount: 10));
  }

  void onOrdersItemsFetched(List<OrderItem> items, int nextUnit) {
    myItems = items;
    notifyListeners();
  }

  void OrdersLoaded(OrdersModel momentEntity) {
    myItems = momentEntity.items;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<OrderItem> >> getOrdersItems(
      int unit) async {
    final result = await getIt<GetOrderssUseCase>()(GetAllNotificationParam(
      skipCount: unit * 10,
      maxResultCount: 10,
    ));

    return Result<AppErrors, List<OrderItem> >(
        data: result.data!.items, error: result.error);
  }

  setOrder(List<OrderItem> orders) {
    allOrders = orders;
    notifyListeners();
  }

  getDetails(orderId) {
    print("orderId$orderId");
    showDetails = !showDetails;
    orderSelected = orderId;
    notifyListeners();
    if (showDetails) {
      shopCubit.getDetailsOfOrder(GetOrderDetailsParams(id: orderId));
    }

    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}

class Order {
  final String orderId;
  final String date;
  final OrderStatus orderStatus;
  final String price;

  Order(
      {required this.orderId,
      required this.date,
      required this.orderStatus,
      required this.price});
}
