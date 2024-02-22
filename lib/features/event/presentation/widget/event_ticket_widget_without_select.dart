import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/presentation/widget/dotted_line_widget.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class EventTicketWidgetWithOutSelect extends StatefulWidget {
  final String title;
  final DateTime? from;
  final DateTime? to;
  final bool refundable;
  final double price;
  final Function(int) onQuantityChange;
  final String desc;

  const EventTicketWidgetWithOutSelect({
    Key? key,
    required this.title,
    required this.from,
    required this.to,
    required this.refundable,
    required this.price,
    required this.onQuantityChange,
    required this.desc,
  }) : super(key: key);

  @override
  _EventTicketWidgetWithOutSelectState createState() => _EventTicketWidgetWithOutSelectState();
}

class _EventTicketWidgetWithOutSelectState extends State<EventTicketWidgetWithOutSelect> {
  int _ticketCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTicketHeader(),
        _buildTicketInfoWidget(),
      ],
    );
  }

  Widget _buildTicketHeader() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        height: 120.h,
        decoration: BoxDecoration(
            color: AppColors.mansourDarkPurple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: AppColors.white_text,
                fontWeight: FontWeight.bold,
                fontSize: 50.sp,
              ),
            ),
            const Spacer(),
          ],
        ));
  }

  Widget _buildTicketInfoWidget() {
    return Container(
      height: widget.desc == '' ? 350.h : 500.h,
      child: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mansourLightGreyColor_5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  )),
            ),
            Positioned(
              left: -25.w,
              top: 150.h,
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white_text,
                  border: Border.all(color: AppColors.mansourLightGreyColor_5),
                ),
              ),
            ),
            Positioned(
                right: 25.w,
                left: 28.w,
                top: 170.h,
                child: const DottedLineWidget(
                  color: AppColors.mansourLightGreyColor_5,
                )),
            Positioned(
              right: -25.w,
              top: 150.h,
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white_text,
                  border: Border.all(color: AppColors.mansourLightGreyColor_5),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 110.h,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Translation.of(context).event_time,
                                style: const TextStyle(
                                    color: AppColors.accentColorLight),
                              ),
                              Text(
                                widget.from != null && widget.to != null
                                    ? DateFormat('HH:mm')
                                            .format(widget.from!.toLocal()) +
                                        ' - ' +
                                        DateFormat('HH:mm')
                                            .format(widget.to!.toLocal())
                                    : '',
                                style: const TextStyle(
                                    color: AppColors.black_text),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      // SizedBox(
                      //   height: 110.h,
                      //   child: FittedBox(
                      //     fit: BoxFit.contain,
                      //     child: Container(
                      //       alignment: AlignmentDirectional.centerEnd,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             Translation.of(context).refund_policy,
                      //             style: const TextStyle(
                      //                 color: AppColors.accentColorLight),
                      //           ),
                      //           Text(
                      //             widget.refundable
                      //                 ? Translation.of(context).refundable
                      //                 : Translation.of(context).not_refundable,
                      //             style: const TextStyle(
                      //                 color: AppColors.black_text),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  if (widget.desc != '')
                    Text(
                      widget.desc,
                      maxLines: 4,
                    ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        Translation.of(context).price,
                        style:
                            const TextStyle(color: AppColors.accentColorLight),
                      ),
                      const Spacer(),
                      Text(
                        ' ${Translation.current.SAR} ${widget.price}',
                        style: const TextStyle(
                            color: AppColors.mansourDarkOrange3),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddRemoveTicketWidget() {
    return Row(
      children: [
        _buildAddRemoveButton(
            iconData: Icons.remove,
            onTap: () {
              _editCount(-1);
            }),
        SizedBox(
          width: 30.w,
        ),
        Text(
          _ticketCount.toString(),
          style: const TextStyle(color: AppColors.white_text),
        ),
        SizedBox(
          width: 30.w,
        ),
        _buildAddRemoveButton(
            iconData: Icons.add,
            onTap: () {
              _editCount(1);
            }),
      ],
    );
  }

  Widget _buildAddRemoveButton(
      {required IconData iconData, required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.white,
        ),
        child: Icon(
          iconData,
          color: AppColors.mansourDarkPurple,
          size: 30.w,
        ),
      ),
    );
  }

  void _editCount(int addition) {
    widget.onQuantityChange(addition);
    setState(() {
      if (addition == -1) {
        bool q = Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .changeTickets(addition);
        if (!q) {
          if (_ticketCount > 0) _ticketCount--;
        }
      } else if (addition == 1) {
        bool q = Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .changeTickets(addition);
        if (q) {
          _ticketCount++;
        }
      }
    });
  }
}
