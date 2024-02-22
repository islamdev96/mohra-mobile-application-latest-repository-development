import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/help/presentation/screen/about_us_screen.dart';
import 'package:starter_application/features/help/presentation/screen/contact_us_screen.dart';
import 'package:starter_application/features/help/presentation/screen/faq_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/ui/widgets/waiting_widget.dart';
import '../screen/../state_m/provider/help_screen_notifier.dart';
import '../state_m/cubit/help_cubit.dart';

class HelpScreenContent extends StatelessWidget {
  late HelpScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HelpScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<HelpCubit, HelpState>(
      listener: (context, state) {
        if (state is GetAboutUsLoaded) {
          sn.getAboutUsLoaded(state.entity);
        }
      },
      bloc: sn.helpCubit,
      builder: (context, state) {
        return state.maybeMap(
            helpLoadingState: (s) => WaitingWidget(),
            getAboutUsLoaded: (s) => Scaffold(
                  body: ListView(
                    children: [
                      Gaps.vGap64,
                      Center(
                        child: SizedBox(
                          width: .9.sw,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Nav.pop(context);
                                },
                                child: Icon(
                                  AppConstants.getIconBack(),
                                  color: AppColors.greyBackButton,
                                  size: 20,
                                ),
                              ),
                              Gaps.hGap32,
                              Text(
                                Translation.current.help_center,
                                style: TextStyle(
                                  color: AppColors.greyBackButton,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap50,
                      Center(
                        child: SizedBox(
                          width: .35.sw,
                          height: 60,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                      'assets/images/png/avatar2.png'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                      'assets/images/png/avatar3.png'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                      'assets/images/png/avatar1.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap40,
                      Center(
                        child: SizedBox(
                          width: .8.sw,
                          child: Text(
                            Translation.current.Hi +
                                " " +
                                "${UserSessionDataModel.name}, " +
                                Translation.current.how_can_we_help_you_today,
                            style: TextStyle(
                              color: AppColors.greyBackButton,
                              fontWeight: FontWeight.w100,
                              fontSize: 60.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Gaps.vGap40,
                      Center(
                        child: SizedBox(
                          width: .8.sw,
                          child: Text(
                            Translation.current
                                .Can_not_find_the_answer_you_are_looking_for_Please_contact_our_friendly_team,
                            style: TextStyle(
                              color: AppColors.text_gray,
                              fontWeight: FontWeight.normal,
                              fontSize: 50.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Gaps.vGap40,
                      if (sn.aboutUsEntity.isActive!)
                        GestureDetector(
                          onTap: () {
                            Nav.to(AboutUsScreen.routeName);
                          },
                          child: Center(
                            child: Container(
                              constraints: BoxConstraints(
                                  minWidth: .9.sw,
                                  maxWidth: .9.sw,
                                  minHeight: 90),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                border: Border.all(
                                    color: AppColors.greyHelp, width: 2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: .2.sw,
                                        height: 50,
                                        child: Image.asset(
                                            'assets/images/png/help_icon1.png')),
                                    Gaps.hGap16,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Translation.current.about_us,
                                          style: TextStyle(
                                            color: AppColors.greyBackButton,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 50.sp,
                                          ),
                                        ),
                                        Gaps.vGap16,
                                        SizedBox(
                                          width: .6.sw,
                                          child: Text(
                                            Translation
                                                .current.learn_about_mohra,
                                            style: TextStyle(
                                              color: AppColors.text_gray,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 50.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (sn.aboutUsEntity.isActive!) Gaps.vGap40,
                      GestureDetector(
                        onTap: () {
                          Nav.to(FaqScreen.routeName);
                        },
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(
                                minWidth: .9.sw,
                                maxWidth: .9.sw,
                                minHeight: 90),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              border: Border.all(
                                  color: AppColors.greyHelp, width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: .2.sw,
                                      height: 50,
                                      child: Image.asset(
                                          'assets/images/png/help_icon2.png')),
                                  Gaps.hGap16,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Translation.current.FAQ,
                                        style: TextStyle(
                                          color: AppColors.greyBackButton,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 50.sp,
                                        ),
                                      ),
                                      Gaps.vGap16,
                                      SizedBox(
                                        width: .6.sw,
                                        child: Text(
                                          Translation.current.faq_des,
                                          style: TextStyle(
                                            color: AppColors.text_gray,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 50.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.vGap40,
                      GestureDetector(
                        onTap: () {
                          Nav.to(ContactUsScreen.routeName);
                        },
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(
                                minWidth: .9.sw,
                                maxWidth: .9.sw,
                                minHeight: 90),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              border: Border.all(
                                  color: AppColors.greyHelp, width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: .2.sw,
                                      height: 50,
                                      child: Image.asset(
                                          'assets/images/png/help_icon3.png')),
                                  Gaps.hGap16,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Translation.current.Contact_Us,
                                        style: TextStyle(
                                          color: AppColors.greyBackButton,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 50.sp,
                                        ),
                                      ),
                                      Gaps.vGap16,
                                      SizedBox(
                                        width: .6.sw,
                                        child: Text(
                                          Translation.current
                                              .If_you_need_direct_help_with_our_support_teams_for,
                                          style: TextStyle(
                                            color: AppColors.text_gray,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 50.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            orElse: () => SizedBox());
      },
    );
  }
}
