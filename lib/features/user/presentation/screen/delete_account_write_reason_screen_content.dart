import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_confirm_screen.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_success_screen_content.dart';
import 'package:starter_application/features/user/presentation/widget/custom_text_field.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/delete_account_write_reason_screen_notifier.dart';
import '../screen/delete_account_success_screen.dart';

class DeleteAccountWriteReasonScreenContent extends StatelessWidget {
  late DeleteAccountWriteReasonScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<DeleteAccountWriteReasonScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            Translation.current.why_not_working,
            style: TextStyle(
              fontSize: 70.sp,
              fontWeight: FontWeight.bold,

            ),
          ),
          Gaps.vGap32,
          CustomTextField(width: 0.9.sw,
            textType: TextInputType.text,
            controller: sn.textEditingController,
            maxLines: 9,
            height: 200,
            hintText: Translation.current.explanation_optional,
          ),
          Gaps.vGap32,
          CustomMansourButton(
            titleText: Translation.current.continuee,
            onPressed: () {
              sn.selectedReasons = [];
              sn.selectedReasons.add(sn.selectedReason);
              sn.selectedReasons.add(sn.textEditingController.text);
              Nav.to(DeleteAccountConfirmScreen.routeName,
                  arguments: sn.selectedReasons);
            },

          )
        ],
      ),
    );
  }
}
