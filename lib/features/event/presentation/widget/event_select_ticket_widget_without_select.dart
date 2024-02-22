import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/enums/event_ticket_type.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/data/model/request/create_ticket_request.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_ticket_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'event_ticket_widget_without_select.dart';

class EventSelectTicketWidgetWithOutSelect extends StatefulWidget {
  final EventEntity eventEntity;
  final Function(TicketTypeInfo info) onTicketSelect;
  final Function(TicketTypeInfo info) onTicketUnSelect;

  const EventSelectTicketWidgetWithOutSelect({
    Key? key,
    required this.eventEntity,
    required this.onTicketSelect,
    required this.onTicketUnSelect,
  }) : super(key: key);

  @override
  State<EventSelectTicketWidgetWithOutSelect> createState() =>
      _EventSelectTicketWidgetWithOutSelectState();
}

class _EventSelectTicketWidgetWithOutSelectState extends State<EventSelectTicketWidgetWithOutSelect> {
  @override
  void initState() {
    // Provider.of<AppMainScreenNotifier>(
    //         getIt<NavigationService>().getNavigationKey.currentContext!,
    //         listen: false)
    //     .availableSeats = widget.eventEntity.availableSeats ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    // Provider.of<AppMainScreenNotifier>(
    //         getIt<NavigationService>().getNavigationKey.currentContext!,
    //         listen: false)
    //     .availableSeats = 0;
    // Provider.of<AppMainScreenNotifier>(
    //         getIt<NavigationService>().getNavigationKey.currentContext!,
    //         listen: false)
    //     .myTotalSeats = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: Column(
        children: ((widget.eventEntity.eventType == 0) ||
                (widget.eventEntity.silverTicketPrice == null &&
                    widget.eventEntity.goldenTicketPrice == null &&
                    widget.eventEntity.platinumTicketPrice == null &&
                    widget.eventEntity.vipTicketPrice == null))
            ? [
                EventTicketWidgetWithOutSelect(
                  onQuantityChange: (p0) {
                    if (p0 > 0)
                      widget.onTicketSelect(
                          TicketTypeInfo(type: EventTicketType.Default.index));
                    else
                      widget.onTicketUnSelect(
                          TicketTypeInfo(type: EventTicketType.Default.index));
                  },
                  title: Translation.of(context).ticket_details,
                  from: widget.eventEntity.fromHour,
                  to: widget.eventEntity.toHour,
                  price: widget.eventEntity.price!,
                  refundable: widget.eventEntity.isRefundable,
                  desc: widget.eventEntity.silverTicketDescription,
                )
              ]
            : [
                EventTitleWidget(
                  title: Translation.of(context).select_ticket,
                  textColor: AppColors.black_text,
                  padding: EdgeInsets.only(bottom: 40.h),
                ),
                widget.eventEntity.silverTicketPrice != null
                    ? EventTicketWidgetWithOutSelect(
                        desc: widget.eventEntity.silverTicketDescription,
                        onQuantityChange: (p0) {
                          if (p0 > 0)
                            widget.onTicketSelect(TicketTypeInfo(
                                type: EventTicketType.SILVER.index));
                          else
                            widget.onTicketUnSelect(TicketTypeInfo(
                                type: EventTicketType.SILVER.index));
                        },
                        title: Translation.of(context).silver_ticket,
                        from: widget.eventEntity.fromHour,
                        to: widget.eventEntity.toHour,
                        price: widget.eventEntity.silverTicketPrice!,
                        refundable: widget.eventEntity.isRefundable,
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 40.h,
                ),
                widget.eventEntity.goldenTicketPrice != null
                    ? EventTicketWidgetWithOutSelect(
                        onQuantityChange: (p0) {
                          if (p0 > 0)
                            widget.onTicketSelect(TicketTypeInfo(
                                type: EventTicketType.GOLDEN.index));
                          else
                            widget.onTicketUnSelect(TicketTypeInfo(
                                type: EventTicketType.GOLDEN.index));
                        },
                        title: Translation.of(context).gold_ticket,
                        from: widget.eventEntity.fromHour,
                        to: widget.eventEntity.toHour,
                        price: widget.eventEntity.goldenTicketPrice!,
                        refundable: widget.eventEntity.isRefundable,
                        desc: widget.eventEntity.goldenTicketDescription,
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 40.h,
                ),
                widget.eventEntity.platinumTicketPrice != null
                    ? EventTicketWidgetWithOutSelect(
                        onQuantityChange: (p0) {
                          if (p0 > 0)
                            widget.onTicketSelect(TicketTypeInfo(
                                type: EventTicketType.PLATINUM.index));
                          else
                            widget.onTicketUnSelect(TicketTypeInfo(
                                type: EventTicketType.PLATINUM.index));
                        },
                        title: Translation.of(context).platinum_ticket,
                        from: widget.eventEntity.fromHour,
                        to: widget.eventEntity.toHour,
                        price: widget.eventEntity.platinumTicketPrice!,
                        refundable: widget.eventEntity.isRefundable,
                        desc: widget.eventEntity.platinumTicketDescription,
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 40.h,
                ),
                widget.eventEntity.vipTicketPrice != null
                    ? EventTicketWidgetWithOutSelect(
                        onQuantityChange: (p0) {
                          if (p0 > 0)
                            widget.onTicketSelect(TicketTypeInfo(
                                type: EventTicketType.VIP.index));
                          else
                            widget.onTicketUnSelect(TicketTypeInfo(
                                type: EventTicketType.VIP.index));
                        },
                        title: Translation.of(context).vip_ticket,
                        from: widget.eventEntity.fromHour,
                        to: widget.eventEntity.toHour,
                        price: widget.eventEntity.vipTicketPrice!,
                        refundable: widget.eventEntity.isRefundable,
                        desc: widget.eventEntity.vipTicketDescription,
                      )
                    : const SizedBox.shrink(),
              ],
      ),
    );
  }
}
