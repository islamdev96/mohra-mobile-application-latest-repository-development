import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_write_reason_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/delete_account_select_reason_screen_notifier.dart';

class DeleteAccountSelectReasonScreenContent extends StatelessWidget {
  late DeleteAccountSelectReasonScreenNotifier sn;
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<DeleteAccountSelectReasonScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        children: [
          Text(
            Translation.current.delete_account_reason,
            style: TextStyle(
              fontSize: 70.sp,
              fontWeight: FontWeight.bold,

            ),
          ),
          Gaps.vGap32,
          RadioListTile(
            activeColor: AppColors.mansourDarkOrange3,
            title: Text(sn.reasons[0]),
            value: 0,
            groupValue: sn.valueSelected,
            onChanged: (value){
              sn.valueSelected = 0;
              sn.notifyListeners();
            },
          ),
          RadioListTile(
            activeColor: AppColors.mansourDarkOrange3,
            title: Text(sn.reasons[1]),
            value: 1,
            groupValue: sn.valueSelected,
            onChanged: (value){
              sn.valueSelected = 1;
              sn.notifyListeners();
            },
          ),
          RadioListTile(
            activeColor: AppColors.mansourDarkOrange3,
            title: Text(sn.reasons[2]),
            value: 2,
            groupValue: sn.valueSelected,
            onChanged: (value){
              sn.valueSelected = 2;
              sn.notifyListeners();
            },
          ),
          RadioListTile(
            activeColor: AppColors.mansourDarkOrange3,
            title: Text(sn.reasons[3]),
            value: 3,
            groupValue: sn.valueSelected,
            onChanged: (value){
              sn.valueSelected = 3;
              sn.notifyListeners();
            },
          ),
          RadioListTile(
            activeColor: AppColors.mansourDarkOrange3,
            title: Text(sn.reasons[4]),
            value: 4,
            groupValue: sn.valueSelected,
            onChanged: (value){
              sn.valueSelected = 4;
              sn.notifyListeners();
            },
          ),
          Gaps.vGap32,
          sn.valueSelected == -1 ?   CustomMansourButton(
            titleText: Translation.current.continuee,
            textColor: AppColors.black,
            backgroundColor: AppColors.text_gray,
            onPressed: (){
              //Nav.to(DeleteAccountWriteReasonScreen.routeName, arguments: sn.reasons[sn.valueSelected]);
            },

          ):CustomMansourButton(
            titleText: Translation.current.continuee,
            onPressed: (){
              Nav.to(DeleteAccountWriteReasonScreen.routeName, arguments: sn.reasons[sn.valueSelected]);
            },

          )
        ],
      ),
    );
  }
}
