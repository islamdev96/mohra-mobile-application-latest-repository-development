import 'package:flutter/material.dart';
import 'package:starter_application/features/mobile_ads/presentation/logic/mobile_ad_banner.dart';
import 'package:starter_application/features/mobile_ads/presentation/widget/banner_ad_widget.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class SettingMainScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  bool isAddLoaded = false;
  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }


  Widget getAddBanner(){

    // MobileAdBanner mobileAdBanner = MobileAdBanner(
    //   isLoaded: isAddLoaded,
    //   onAddLoaded: (a){
    //     isAddLoaded = true;
    //     notifyListeners();
    //   },
    //   onAddError: (ad, error){
    //     print('error ${error.message}');
    //   },
    // );
    return MobAdBanner(/*mobileAdBanner: mobileAdBanner,*/);
  }

}
