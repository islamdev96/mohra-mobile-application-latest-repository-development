import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/following_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'following_screen_content.dart';

class FollowingScreen extends StatefulWidget {
  static const String routeName = "/FollowingScreen";

  const FollowingScreen({Key? key}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  final sn = FollowingScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getFollowedShops();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FollowingScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          // toolbarHeight: 200.h,
          leading: InkWell(
              onTap: () {
                context.read<AppMainScreenNotifier>().controller!.jumpTo(0);
                Nav.pop();
              },
              child: Icon(
                AppConstants.getIconBack(),
                color: Colors.black,
              )),
          title: Text(
            Translation.current.following,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 50.sp),
          ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 30.w),
          //     child: SizedBox(
          //       height: 60.h,
          //       width: 60.h,
          //       child: SvgPicture.asset(
          //         AppConstants.SVG_SEARCH,
          //         color: Colors.grey,
          //       ),
          //     ),
          //   )
          // ],
        ),
        backgroundColor: AppColors.mansourLightGreyColor_4,
        body: BlocConsumer<ShopCubit, ShopState>(
          bloc: sn.followedShopsCubit,
          listener: (context, state) {
            state.whenOrNull(shopsListLoaded: (shopsListEntity) {
              sn.shops = shopsListEntity.items ?? [];
            });
          },
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const ScreenNotImplementedError(),
              shopInitState: (_) => WaitingWidget(),
              shopLoadingState: (_) => WaitingWidget(),
              shopErrorState: (s) => ErrorScreenWidget(
                error: s.error,
                callback: s.callback,
              ),
              //
              shopsListLoaded: (_) => FollowingScreenContent(),
            );
          },
        ),
      ),
    );
  }
}
