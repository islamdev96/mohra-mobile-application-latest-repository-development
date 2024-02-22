import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/splash/presentation/screen/splash_screen.dart';

/// Class to make navigation calling shorter and faster to use
class Nav {
  /// Push
  static Future<T?> to<T extends Object?>(
    String routeName, {
    BuildContext? context,
    Object? arguments,
  }) {
    return Navigator.pushNamed(
      context ?? getIt<NavigationService>().appContext!,
      routeName,
      arguments: arguments,
    );
  }




  /// Push replacement
  static Future<T?> off<T extends Object?, TO extends Object?>(
    String routeName, {
    BuildContext? context,
    TO? result,
    Object? arguments,
  }) {

      return Navigator.pushReplacementNamed(
        context ?? getIt<NavigationService>().appContext!,
        routeName,
        result: result,
        arguments: arguments,
      );
  }

  /// Pop
  static bool pop<T extends Object?>([BuildContext? context, T? result]) {
    if (Navigator.canPop(context ?? getIt<NavigationService>().appContext!)) {
      Navigator.pop(context ?? getIt<NavigationService>().appContext!, result);
      return true;
    } else
      return false;
  }

  /// can pop
  static bool canPop() {
    if (Navigator.canPop(getIt<NavigationService>().appContext!)) {
      return true;
    } else
      return false;
  }

  /// Pop until
  static void popTo(bool Function(Route<dynamic>) predicate,
      {BuildContext? context}) {
    Navigator.popUntil(
        context ?? getIt<NavigationService>().appContext!, predicate);
  }

  /// Persistent navigation
  /// Persistent Push
//Todo Refactor persistent navigation logic
  static void persistentPop(
    BuildContext context,

    /// [navToFirstTab] this attribute is used with PersistentBottomNavigationBar
    /// [navToFirstTab = true] => if navigation is in first route then nav to first tab if not already, if already in first tab then pop out
    /// [navToFirstTab = false] => if navigation is in first route then pop out regardless if current tab is the first tab
    {
    bool navToFirstTab = true,
    PersistentTabController? bottomNavController,
  }) {
    assert(navToFirstTab == (bottomNavController != null),
        "navToFirstTab = True and bttomNavController = null");
    if (Nav.pop(context) == false) {
      if (navToFirstTab) {
        if (bottomNavController!.index != 0) {
          bottomNavController.jumpToTab(0);
          return;
        }
      }
      Nav.pop();
    }
  }


  static Future<bool> isCurrent( String routeName,{BuildContext? context} ) async{
    bool isCurrent = false;
   await Future.delayed(Duration(milliseconds: 200));
    Navigator.popUntil( context ?? getIt<NavigationService>().appContext!,(route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    } );
    return isCurrent;
  }

  /// push and remove until screen
  static Future<T?> toAndPopUntil<T extends Object?>(
    String routeName,
    String backRoutName, {
    BuildContext? context,
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context ?? getIt<NavigationService>().appContext!,
      routeName,
      (route) => route.settings.name == backRoutName,
      arguments: arguments,
    );
  }

  /// push and remove all
  static Future<T?> toAndRemoveAll<T extends Object?>(
      String routeName,{
        BuildContext? context,
        Object? arguments,
      }) async{
    bool isPageSplash = await isCurrent(routeName);
    if(isPageSplash) {
      return Future.value();
    } else {
      return Navigator.pushNamedAndRemoveUntil(
        context ?? getIt<NavigationService>().appContext!,
        routeName,
            (route) => false,
        arguments: arguments,
      );
    }
  }

}