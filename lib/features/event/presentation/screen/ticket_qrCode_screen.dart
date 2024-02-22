import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/ticket_qrCode_screen_notifier.dart';
import 'package:starter_application/features/event_orginizer/presentation/widget/qr_code_scan_widget.dart';
import 'package:starter_application/features/home/presentation/widget/qr_code_scan_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class TicketQrCodeScreenParam {
  final VoidCallback onDispose;
  final int eventId;

  TicketQrCodeScreenParam({
    required this.onDispose,
    required this.eventId,
  });
}

class TicketQrCodeScreen extends StatefulWidget {
  static const String routeName = "/TicketQrCodeScreen";
  final TicketQrCodeScreenParam param;

  const TicketQrCodeScreen({Key? key, required this.param}) : super(key: key);

  @override
  _TicketQrCodeScreenState createState() => _TicketQrCodeScreenState();
}

class _TicketQrCodeScreenState extends State<TicketQrCodeScreen>
    with SingleTickerProviderStateMixin {
  final sn = TicketQrCodeScreenNotifier();

  final scanKey = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    widget.param.onDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, _) {
        return ChangeNotifierProvider<TicketQrCodeScreenNotifier>.value(
          value: sn,
          builder: (context, child) {
            context.watch<TicketQrCodeScreenNotifier>();
            sn.context = context;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.mansourLightGreyColor_6,
                  elevation: 0.0,
                  title: Text(
                    Translation.current.Scan_Ticket,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: InkWell(
                      onTap: () {
                        Nav.pop();
                      },
                      child: Icon(
                        AppConstants.getIconBack(),
                        color: Colors.black,
                      )),
                  actions: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         height: 60.h,
                    //         width: 60.h,
                    //         child: SvgPicture.asset(
                    //           AppConstants.SVG_ARROW_CIRCLE,
                    //           color: Colors.black54,
                    //         ),
                    //       ),
                    //       Gaps.hGap15,
                    //       SizedBox(
                    //         height: 60.h,
                    //         width: 60.h,
                    //         child: SvgPicture.asset(
                    //           AppConstants.SVG_SHARE_FILL,
                    //           color: Colors.black54,
                    //         ),
                    //       ),
                    //       Gaps.hGap16,
                    //     ],
                    //   ),
                    // )
                  ],
                ),
                backgroundColor: AppColors.mansourLightGreyColor_4,
                body: MultiBlocListener(
                  listeners: [
                    BlocListener<EventCubit, EventState>(
                      bloc: sn.scanQrcodeTicket,
                      listener: (context, state) {
                        state.mapOrNull(
                          eventLoadingState: (_) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 1.sh,
                                  width: 1.sw,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SvgPicture.asset(AppConstants.loading),
                                      Gaps.vGap24,
                                      TextWaitingWidget(
                                        Translation.current.Scanning_Ticket,
                                        textColor: Colors.white,
                                      ),
                                      Gaps.vGap256,
                                    ],
                                  ),
                                );
                              },
                            ).then((value) => Nav.pop());
                          },
                          eventErrorState: (s) {
                            Fluttertoast.showToast(
                                msg: s.error is InternalServerWithDataError
                                    ? (s.error as InternalServerWithDataError)
                                        .message
                                        .toString()
                                    : Translation.current.cancelErrorMessage);
                            Nav.pop();
                            // ErrorViewer.showError(
                            //   context: context,
                            //   error: s.error,
                            //   callback: s.callback,
                            // );
                            // MyFlushbar.context = getIt<NavigationService>().appContext;
                            // MyFlushbar.message = (s.error is InternalServerWithDataError) ? (s.error as InternalServerWithDataError).message : Translation.current.cancelErrorMessage;
                            // MyFlushbar.title = Translation.current.cancelErrorMessage;
                            // MyFlushbar.icon = Image.asset(AppConstants.error_image);
                            // MyFlushbar.isError = true;
                            // MyFlushbar.close();
                            // MyFlushbar.show();
                            // Navigator.of(context).pop();
                            // Nav.pop();
                            // showSnackbarEvent( Translation.current.code_scanned_successfully,title: Translation.current.Checked_In,icon: Image.asset(AppConstants.check_image));
                          },
                          scanTicketQrCodeLoaded: (s) {
                            print('BassselDone');
                            Fluttertoast.showToast(
                                msg: Translation
                                    .current.code_scanned_successfully);
                            Nav.pop();

                            // MyFlushbar.context =
                            //     getIt<NavigationService>().appContext;
                            // MyFlushbar.message =
                            //     Translation.current.code_scanned_successfully;
                            // MyFlushbar.title = Translation.current.Checked_In;
                            // MyFlushbar.icon =
                            //     Image.asset(AppConstants.check_image);
                            // MyFlushbar.isError = false;
                            // MyFlushbar.close();
                            // MyFlushbar.show();
                            // showSnackbarEvent( Translation.current.code_scanned_error,isError: true,title: Translation.current.cancelErrorMessage,icon: Image.asset(AppConstants.error_image));
                          },
                        );
                      },
                    ),
                  ],
                  child: Column(
                    children: [
                      Expanded(
                        child: QrCodeScanEventWidget(
                          onQrCodeScanned: sn.onQrCodeScanned,
                          eventId: widget.param.eventId,
                          indicatorVerticalPadding: 200.h,
                        ),
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
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
