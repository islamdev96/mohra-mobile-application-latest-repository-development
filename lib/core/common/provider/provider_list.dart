import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:starter_application/core/bloc/app_config/app_config_cubit.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/localization/localization_provider.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/event_categories_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/call_screen_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';

// import 'package:starter_application/features/music/presentation/state_m/provider/music_main_screen_notifier.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/news_main_screen_screen_notifier.dart';
import 'package:starter_application/features/notification/presentation/state_m/cubit/notification_cubit.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/last_read_notifier.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/cart_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/product_favorite.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/shop_main_screen_notifer.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/shop_screen_notifier.dart';
import 'package:starter_application/features/sports/presentation/state_m/provider/sport_main_screen_notifier.dart';

import '../../utils/lifecycle_service.dart';
import 'session_data.dart';

/// Centralizing all app providers in one class to be easy to adjust and read
class ApplicationProvider {
  static ApplicationProvider _instance = ApplicationProvider._init();

  factory ApplicationProvider() => _instance;

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];

  List<SingleChildWidget> dependItems = [
    /// Change notifier provider
    ChangeNotifierProvider.value(
      value: getIt<LocalizationProvider>(),
    ),
    ChangeNotifierProvider.value(
      value: LifecycleService(),
    ),
    ChangeNotifierProvider.value(
      value: SessionData(),
    ),
    ChangeNotifierProvider.value(
      value: ProductFavorite(),
    ),
    ChangeNotifierProvider.value(
      value: AppMainScreenNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: SportMainScreenNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: ShopMainScreenNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: ShopHomeScreenNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: NewsMainScreenScreenNotifier(),
    ),
    // ChangeNotifierProvider.value(
    //   value: MusicMainScreenNotifier(),
    // ),
    ChangeNotifierProvider.value(
      value: EventCategoriesScreenNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: CallScreenNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: LastReadNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: GlobalMessagesNotifier(),
    ),
    ChangeNotifierProvider.value(
      value: Cart(),
    ),
    // ChangeNotifierProvider.value(
    //   value: CartScreenNotifier(),
    // ),
    /// Bloc provider
    BlocProvider(
      create: (context) => NotificationCubit(),
    ),
    BlocProvider(
      create: (context) => AppConfigCubit(),
    ),
    BlocProvider(
      create: (context) => GlogalCubit(),
    ),
    BlocProvider(
      create: (context) => AccountCubit(),
      lazy: true,
    ),
  ];

  List<SingleChildWidget> uiChangesItems = [];

  void dispose(BuildContext context) {
    Provider.of<LocalizationProvider>(context).dispose();
    Provider.of<SessionData>(context).dispose();
    Provider.of<AppMainScreenNotifier>(context).dispose();
    Provider.of<NewsMainScreenScreenNotifier>(context).dispose();
    // Provider.of<MusicMainScreenNotifier>(context).dispose();
    Provider.of<Cart>(context).dispose();
    Provider.of<ProductFavorite>(context).dispose();
    Provider.of<AppConfigCubit>(context).close();
    Provider.of<AccountCubit>(context).close();
  }
}
