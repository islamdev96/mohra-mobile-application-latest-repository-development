// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/core/errors/error_global_handler/platform_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/system/double_tap_back_exit_app.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/data/model/request/update_location_request.dart';
import 'package:starter_application/features/account/domain/usecase/update_location_usecase.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/booking_services_screen_notifier.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen_content.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/state_m/provider/home_services_screen_notifier.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../main.dart';
import 'booking_services_screen_content.dart';
class BookingServicesScreen extends StatefulWidget {
  static const routeName = "/BookingServicesScreen";
  const BookingServicesScreen({Key? key}) : super(key: key);
  @override
  _BookingServicesScreenState createState() => _BookingServicesScreenState();
}

class _BookingServicesScreenState extends State<BookingServicesScreen> {
  final sn = BookingServicesScreenNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingServicesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_6,
        body: BookingServicesScreenContent(),
      ),
    );
  }

  /// Widget

  /// Logic

}
