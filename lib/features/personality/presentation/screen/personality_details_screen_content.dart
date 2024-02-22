import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/features/personality/presentation/widget/personality_result_card.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screen/../state_m/provider/personality_details_screen_notifier.dart';

class PersonalityDetailsScreenContent extends StatelessWidget {
  late PersonalityDetailsScreenNotifier sn;

  String arMessage = '''أهلاً 👋🏼!
حملت "مهرة" 🦄وانضممت إلى عالم متكامل من التسوق والتواصل..
حمل التطبيق وشارك معي شخصيتك ولحظاتك 😏.

للتحميل من هنا🔗
https://mohra.onelink.me/QNcd/bbqz0hvq''';

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<PersonalityDetailsScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppConstants.screenPadding.left,
        right: AppConstants.screenPadding.right,
        bottom: 50.h,
      ),
      child: BlocConsumer<PersonalityCubit, PersonalityState>(
        bloc: sn.personalityCubit,
        listener: (context, state) {
          if (state is AvatarLoaded) {
            sn.onAvatarLoaded(state.avatarListEntity);
          }
        },
        builder: (context, state) {
          return state.maybeMap(
            avatarLoaded: (s) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap32,
                _buildPersonalityResultCard(),
                Gaps.vGap32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await Share.share(arMessage);
                      },
                      child: Row(
                        children: [
                          Text(
                            Translation.current.Share_my_character,
                            style: const TextStyle(
                                color: AppColors.mansourBackArrowColor2),
                          ),
                          const Icon(
                            Icons.share,
                            color: AppColors.mansourBackArrowColor2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(6),
                      padding: EdgeInsets.all(6),
                      // height: double.infinity,
                      width: 0.45.sw,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(3),
                            bottomRight: Radius.circular(3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),

                      child: SelectableText(
                        "https://mohra.onelink.me/QNcd/bbqz0hvq",
                        textAlign: AppConfig().isLTR
                            ? TextAlign.left
                            : TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Gaps.vGap64,
                Container(
                  width: 0.9.sw,
                  child: Text(
                      "${isArabic ? sn.avatarEntity.arDescription : sn.avatarEntity.enDescription}"),
                ),
                Gaps.vGap16,
              ],
            ),
            personalityLoadingState: (s) => WaitingWidget(),
            orElse: () => Container(),
          );
        },
      ),
    );
  }

  Widget _buildPersonalityResultCard() {
    int i = Random().nextInt(2);
    return PersonalityResultCard(
      height: 0.35.sh,
      width: 0.9.sw,
      title: "${isArabic ? sn.avatarEntity.arName : sn.avatarEntity.enName}",
      image: sn.avatarEntity.image,
      gradiant: UserSessionDataModel.gender == 1
          ? AppColors.personalityGradiant1
          : AppColors.personalityGradiant2,
      textColor: getTextColor(i),
      content:
          "${isArabic ? sn.avatarEntity.arDescription : sn.avatarEntity.enDescription}",
      avatar: sn.avatarEntity.avatarUrl,
    );
  }

  Color getTextColor(int i) {
    if (i == 0) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
