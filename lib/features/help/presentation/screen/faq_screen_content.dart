import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/help/presentation/state_m/cubit/help_cubit.dart';
import 'package:starter_application/main.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entity/faq_entity.dart';
import '../screen/../state_m/provider/faq_screen_notifier.dart';

class FaqScreenContent extends StatelessWidget {
  late FaqScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FaqScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      body: BlocConsumer<HelpCubit, HelpState>(
        bloc: sn.helpCubit,
        listener: (context, state) {
          if (state is FaqListLoadedState) {
            sn.onFaqListLoaded(state.entity);
          }
        },
        builder: (context, state) {
          return state.maybeMap(
              helpLoadingState: (s) => WaitingWidget(),
              faqListLoaded: (s) => _buildScreen(context),
              orElse: () => SizedBox());
        },
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return ListView(
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
                  Translation.current.faq,
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
          child: Text(
            "Frequently asked questions",
            style: TextStyle(
              color: AppColors.greyBackButton,
              fontWeight: FontWeight.bold,
              fontSize: 60.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Gaps.vGap32,
        Center(
          child: Text(
            "Everything you need to know about our products and services.",
            style: TextStyle(
              color: AppColors.text_gray,
              fontWeight: FontWeight.w100,
              fontSize: 60.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Gaps.vGap50,
        for (int i = 0; i < sn.faqListEntity.items!.length; i++)
          Center(
            child: faqWidget(sn.faqListEntity.items![i]!),
          ),
      ],
    );
  }

  Widget faqWidget(FaqItemEntity item) {
    return Visibility(
      visible: item.isActive!,
      child: Container(
        width: .9.sw,
        decoration: const BoxDecoration(color: AppColors.greyHelp1),
        child: ExpansionTile(
          title: Text(
            isArabic ? item.arQuestion! : item.enQuestion!,
            style: TextStyle(
              color: AppColors.greyBackButton,
              fontWeight: FontWeight.bold,
              fontSize: 45.sp,
            ),
          ),
          trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyBackButton)),
            child: Center(
              child: Icon(sn.customTileExpanded ? Icons.remove : Icons.add),
            ),
          ),
          children: <Widget>[
            ListTile(
              title: Text(
                isArabic ? item.arAnswer! : item.enAnswer!,
                style: TextStyle(
                  color: AppColors.greyBackButton,
                  fontWeight: FontWeight.bold,
                  fontSize: 45.sp,
                ),
              ),
            ),
          ],
          onExpansionChanged: (bool expanded) {
            sn.customTileExpanded = expanded;
          },
        ),
      ),
    );
  }
}
