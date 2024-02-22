import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/qrCode_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/widget/qr_code_scan_widget.dart';
import 'package:starter_application/features/home/presentation/widget/qr_code_widget.dart';
import 'package:starter_application/features/home/presentation/widget/qr_pick_image_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class QrCodeScreenParam {
  final bool navToScan;

  QrCodeScreenParam({
    this.navToScan = false,
  });
}

class QrCodeScreen extends StatefulWidget {
  static const String routeName = "/QrCodeScreen";
  final QrCodeScreenParam param;

  const QrCodeScreen({Key? key, required this.param}) : super(key: key);

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen>
    with SingleTickerProviderStateMixin {
  final sn = QrCodeScreenNotifier();
  late final TabController tabController;

  final scanKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    if (widget.param.navToScan) {
      tabController.animateTo(1);
    }
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      indicatorWidget: Material(
        color: Colors.transparent,
        child: TextWaitingWidget(
          Translation.current.friend_added_in_progress,
          textColor: Colors.white,
        ),
      ),
      child: OrientationBuilder(
        builder: (context, _) {
          return ChangeNotifierProvider<QrCodeScreenNotifier>.value(
            value: sn,
            builder: (context, child) {
              context.watch<QrCodeScreenNotifier>();
              sn.context = context;
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.mansourLightGreyColor_6,
                    elevation: 0.0,
                    leading: InkWell(
                        onTap: () {
                          Nav.pop();
                        },
                        child: Icon(
                          AppConstants.getIconBack(),
                          color: Colors.black54,
                        )),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                sn.takeScreenShot();
                              },
                              child: SizedBox(
                                height: 60.h,
                                width: 60.h,
                                child: SvgPicture.asset(
                                  AppConstants.SVG_ARROW_CIRCLE,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Gaps.hGap15,
                            GestureDetector(
                              onTap: () {
                                _shareQRcode();
                              },
                              child: SizedBox(
                                height: 60.h,
                                width: 60.h,
                                child: SvgPicture.asset(
                                  AppConstants.SVG_SHARE_FILL,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Gaps.hGap16,
                          ],
                        ),
                      )
                    ],
                  ),
                  backgroundColor: AppColors.mansourLightGreyColor_4,
                  body: MultiBlocListener(
                    listeners: [
                      BlocListener<FriendCubit, FriendState>(
                        bloc: sn.addFriendCubit,
                        listener: (context, state) {
                          state.mapOrNull(
                            friendLoadingState: (_) =>
                                ProgressHUD.of(context)?.show(),
                            friendErrorState: (s) {
                              ProgressHUD.of(context)?.dismiss();
                              ErrorViewer.showError(
                                context: context,
                                error: s.error,
                                callback: s.callback,
                              );
                              Nav.pop();
                            },
                            addFriendByQrCodeLoaded: (s) {
                              ProgressHUD.of(context)?.dismiss();
                              showSnackbar(Translation
                                  .current.friend_added_successfully);
                              Nav.pop();
                            },
                          );
                        },
                      ),
                    ],
                    child: Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: [
                              Screenshot(
                                  controller: sn.screenshotController,
                                  child: const QrCodeWidget()),
                              QrCodeScanWidget(
                                onQrCodeScanned: sn.onQrCodeScanned,
                              ),
                              QrFromFileWidget(
                                onQrCodeScanned: sn.onQrCodeScanned,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 320.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TabBar(
                                  onTap: (value) {
                                    setState(() {});
                                  },
                                  indicatorColor: Colors.transparent,
                                  controller: tabController,
                                  labelStyle: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontSize: 42.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelColor: AppColors.backgroundColorDark,
                                  unselectedLabelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 37.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  unselectedLabelColor: Colors.grey,
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  isScrollable: true,
                                  tabs: [
                                    getItemQRcode(
                                        title: Translation.current.my_qr_code
                                            .toUpperCase(),
                                        isColor: tabController.index == 0),
                                    getItemQRcode(
                                        title: Translation.current.scan_qr_code
                                            .toUpperCase(),
                                        isColor: tabController.index == 1),
                                    getItemQRcode(
                                        title: 'pick image'.toUpperCase(),
                                        isColor: tabController.index == 2)
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      Translation.current.add_friend_message1,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 35.sp,
                                      ),
                                    ),
                                    Text(
                                      Translation.current.add_friend_message2,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 35.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

void _shareQRcode() async {
  DynamicLinkService dynamicLinkService = DynamicLinkService();
  Uri uri = await dynamicLinkService.createDynamicLink(queryParameters: {
    'qrcode': UserSessionDataModel.qrCode ?? '',
    'name': UserSessionDataModel.fullName,
    'location': UserSessionDataModel.getUserCityStreet(),
    'image': UserSessionDataModel.imageUrl ?? '',
  }, type: AppConstants.KEY_DYNAMIC_LINKS_QRCODE);
  FlutterShare.share(
    title: uri.toString(),
    linkUrl: uri.toString(),
  );
}

Widget getItemQRcode({required String title, required bool isColor}) {
  return Container(
    height: 100.h,
    child: Column(
      children: [
        Text(title),
        if (isColor)
          Container(
            height: 3,
            width: 100,
            color: AppColors.primaryColorLight,
          )
      ],
    ),
  );
}
