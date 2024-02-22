import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/user/presentation/screen/edit_profile_screen.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_select_reason_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../di/service_locator.dart';
import '../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';
import '../screen/../state_m/provider/view_profile_screen_notifier.dart';
import 'view_profile_screen_content.dart';

class ViewProfileScreen extends StatefulWidget {
  static const String routeName = "/ViewProfileScreen";

  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final sn = ViewProfileScreenNotifier();

  @override
  void initState() {
    sn.getProfile();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewProfileScreenNotifier>.value(
      value: sn,
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .getMyAvatar();
          return Future.value(true);
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              PopupMenuButton(
                icon: SvgPicture.asset(
                  'assets/images/svg/dots_menu.svg',
                  color: AppColors.white,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text(Translation.current.delete_account),
                    ),
                  ];
                },
                onSelected: (v) {
                  if (v == 0) {
                    Nav.to(DeleteAccountSelectReasonScreen.routeName);
                  }
                },
              )
            ],
            leading: GestureDetector(
              onTap: () {
                Nav.pop();
                Provider.of<AppMainScreenNotifier>(
                        getIt<NavigationService>()
                            .getNavigationKey
                            .currentContext!,
                        listen: false)
                    .getMyAvatar();
              },
              child: Icon(
                AppConstants.getIconBack(),
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          backgroundColor: AppColors.mansourLightGreyColor_4,
          body: ViewProfileScreenContent(),
        ),
      ),
    );
  }
}
