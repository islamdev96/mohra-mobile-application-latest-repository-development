import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moyasar/moyasar.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/apple_pay_widget.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/event/presentation/screen/terms_and_conditions_screen.dart';
import 'package:starter_application/features/event/presentation/widget/event_buy_ticket_bottom_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_divider_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_personal_information_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_pick_day_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_select_ticket_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/app_config.dart';
import '../../../../core/common/provider/session_data.dart';
import '../../../../core/constants/enums/event_ticket_type.dart';
import '../../../../core/params/payment_params.dart';
import '../screen/../state_m/provider/buy_ticket_screen_notifier.dart';
import '../state_m/cubit/event_cubit.dart';

class BuyTicketScreenContent extends StatefulWidget {
  @override
  State<BuyTicketScreenContent> createState() => _BuyTicketScreenContentState();
}

class _BuyTicketScreenContentState extends State<BuyTicketScreenContent> {
  late BuyTicketScreenNotifier sn;
  late SessionData session =
      Provider.of<SessionData>(AppConfig().appContext, listen: false);

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<BuyTicketScreenNotifier>(context);
    sn.context = context;
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildEventInfoWidget(),
              EventDividerWidget(),
              sn.eventEntity.fromDate != null && sn.eventEntity.toDate != null
                  ? EventPickDayWidget(
                      onDatePicked: sn.pickDay,
                      eventModel: sn.eventEntity,
                    )
                  : const SizedBox.shrink(),
              EventDividerWidget(),
              EventSelectTicketWidget(
                onTicketSelect: sn.addTicket,
                onTicketUnSelect: sn.removeTicket,
                eventEntity: sn.eventEntity,
              ),
              EventDividerWidget(),
              /*const EventSeatsWidget(),
              EventDividerWidget(),*/
              /* EventPersonalInformationWidget(
                phoneController: sn.phoneController,
                nameController: sn.nameController,
                emailController: sn.emailController,
                onDelete: () {
                  sn.notify();
                },
                onSave: () {
                  sn.notify();
                },
              ),
              EventDividerWidget(),*/
              if (sn.eventEntity.eventType == 3) _buildCodeWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: _buildTermsAndConditions(),
              ),
              SizedBox(
                height: 30.h,
              ),
              if (sn.eventEntity.eventType != 0) _buildTotalPaymentWidget(),
              SizedBox(
                height: sn.eventEntity.organizer!.companyWebsite == ''
                    ? 0.15.sh
                    : 0.21.sh,
              )
            ],
          ),
        ),
        if (Platform.isIOS && sn.isCanApplePay)
          Positioned(
            bottom: 0,
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.r),
                  topLeft: Radius.circular(50.r),
                ),
                boxShadow: [
                  const BoxShadow(
                      color: AppColors.mansourWhiteBackgrounColor_4,
                      spreadRadius: 5,
                      blurRadius: 5)
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 80.w),
                child: Column(
                  children: [
                    Container(
                      width: 1.sw,
                      height: 90.h,
                      child: ApplePayMohra(
                        params: PaymentParams(
                          amount: sn.totalPrice,
                          receiptId: sn.eventEntity.organizerId,
                          onSuccessPayment: (p0) {
                            Nav.pop();
                            sn.whenDone(p0);
                          },
                          onFailedPayment: (p0) {
                            late CardPaymentResponseSource sourceMap;

                            if (p0.source is CardPaymentResponseSource) {
                              sourceMap =
                                  p0.source as CardPaymentResponseSource;
                            }
                            Fluttertoast.showToast(
                                msg: sn.getErrorMessages(sourceMap.message ??
                                    Translation.of(context).paymentFailed));
                            Nav.pop();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    InkWell(
                      onTap: () {
                        sn.showPaymentPage(sn.eventEntity.title);
                      },
                      child: Text(
                        Translation.current.other_payment_method,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.mansourDarkPurple),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (!sn.isCanApplePay || Platform.isAndroid)
          Positioned(
              bottom: 0,
              child: BlocListener<EventCubit, EventState>(
                bloc: sn.eventCubit,
                listener: (context, state) {
                  if (state is EventLoadingState) {
                    sn.makeLoading(true);
                  } else {
                    sn.makeLoading(false);
                  }
                },
                child: EventBuyTicketBottomWidget(
                    eventEntity: sn.eventEntity,
                    isLoading: sn.isLoading,
                    firstButtonText: sn.eventEntity.eventType == 0
                        ? Translation.of(context).get_ticket
                        : Translation.of(context).buy_ticket,
                    onFirstButtonPressed: () {
                      sn.buyTicket(sn, sn.eventEntity.title);
                    }),
              )),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
            value: sn.checkBox,
            onChanged: (val) {
              sn.checkBox = val ?? false;
            }),
        Expanded(
          child: InkWell(
            onTap: () {
              launch(
                  'https://eventorganizer.mohraapp.com/user/terms-and-condition-event-participant');
            },
            // onTap: (){
            //   Nav.to(TermsandConditionsScreen.routeName);
            // },
            child: Text.rich(
              TextSpan(
                  text: Translation.of(context).read_and_agree,
                  style: const TextStyle(
                    color: AppColors.accentColorLight,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: ' ' + Translation.of(context).term_conditions + ' ',
                      style: const TextStyle(
                        color: AppColors.mansourDarkOrange3,
                      ),
                    ),
                    TextSpan(
                      text: Translation.of(context).of_this_event,
                      style: const TextStyle(
                        color: AppColors.accentColorLight,
                      ),
                    ),
                  ]),
              maxLines: 3,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEventInfoWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: CustomNetworkImageWidget(
                  imgPath: sn.eventEntity.mainPicture,
                  width: 0.12.sw,
                  height: 0.12.sw,
                ),
              )
            ],
          ),
          SizedBox(
            width: 30.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sn.eventEntity.title,
                  style: TextStyle(
                    color: AppColors.black_text,
                    fontSize: 55.sp,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  sn.eventEntity.placeName,
                  style: const TextStyle(
                      color: AppColors.accentColorLight,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPaymentWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 60.w),
      color: AppColors.mansourLightGreyColor,
      child: Column(
        children: [
          if (sn.totalPrice > 0) ...{
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Text(
            //       "${Translation.current.tax} (${session.getSettingModel?.percentage ?? 0}%)",
            //       style: TextStyle(
            //           color: AppColors.mansourWhiteBackgrounColor_6,
            //           fontSize: 50.sp),
            //     ),
            //     const Spacer(),
            //     Text(
            //       Translation.current.SAR +
            //           " ${((((session.getSettingModel?.percentage ?? 0) / 100)) * sn.totalPrice).toStringAsFixed(2)}",
            //       style: TextStyle(
            //           color: AppColors.mansourDarkOrange3, fontSize: 50.sp),
            //     ),
            //     SizedBox(
            //       width: 30.w,
            //     ),
            //   ],
            // ),
            // Gaps.vGap24,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  Translation.of(context).total +
                      " " +
                      Translation.of(context).price,
                  style: TextStyle(
                      color: AppColors.mansourWhiteBackgrounColor_6,
                      fontSize: 50.sp),
                ),
                const Spacer(),
                Text(
                  ' ${Translation.current.SAR} ${sn.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: AppColors.mansourDarkOrange3, fontSize: 50.sp),
                ),
                SizedBox(
                  width: 30.w,
                ),
              ],
            ),
            Gaps.vGap24,
            // Divider(),
            // Gaps.vGap24,
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Text(
            //       Translation.of(context).total_payment,
            //       style: TextStyle(
            //           color: AppColors.mansourWhiteBackgrounColor_6,
            //           fontSize: 50.sp),
            //     ),
            //     const Spacer(),
            //     Text(
            //       ' ${Translation.current.SAR} ${(sn.totalPrice.toStringAsFixed(2))}',
            //       style: TextStyle(
            //           color: AppColors.mansourDarkOrange3, fontSize: 50.sp),
            //     ),
            //     SizedBox(
            //       width: 30.w,
            //     ),
            //   ],
            // ),
          },
          if (sn.totalPrice == 0)
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  Translation.of(context).total_payment,
                  style: TextStyle(
                      color: AppColors.mansourWhiteBackgrounColor_6,
                      fontSize: 50.sp),
                ),
                const Spacer(),
                Text(
                  ' ${Translation.current.SAR} ${(sn.totalPrice + ((((5) / 100)) * sn.totalPrice)).toStringAsFixed(2)}',
                  style: TextStyle(
                      color: AppColors.mansourDarkOrange3, fontSize: 50.sp),
                ),
                SizedBox(
                  width: 30.w,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCodeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventTitleWidget(
          title: Translation.current.enter_private_code,
          textColor: AppColors.black,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.w),
          child: CustomTextField(
            border: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            hintText: Translation.current.enter_private_code,
            textInputAction: TextInputAction.none,
            keyboardType: TextInputType.text,
            controller: sn.codeController,
          ),
        ),
      ],
    );
  }

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      20.r,
    ),
    borderSide: const BorderSide(
      color: AppColors.mansourLightGreyColor_10,
    ),
  );
}
