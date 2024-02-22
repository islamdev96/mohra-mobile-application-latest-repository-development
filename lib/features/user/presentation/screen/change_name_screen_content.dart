import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_name_screen_notifier.dart';

class ChangeNameScreenContent extends StatelessWidget {
  late ChangeNameScreenNotifier sn;
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ChangeNameScreenNotifier>(context);
    sn.context = context;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
         children: [
           TextFormField(
             decoration: InputDecoration(
                 floatingLabelBehavior: FloatingLabelBehavior.always,
                 labelText: Translation.current.firstName,
                 ),
             style: const TextStyle(
               color: AppColors.black,
             ),
             cursorColor: AppColors.mansourDarkOrange3,
             controller: sn.firstNameController,
             onChanged: (value) {
               sn.canSave2();
             },
           ),
           Gaps.vGap32,
           TextFormField(
             decoration: InputDecoration(
                 floatingLabelBehavior: FloatingLabelBehavior.always,
                 labelText: Translation.current.lastName,
                 ),
             style: const TextStyle(
               color: AppColors.black,
             ),
             cursorColor: AppColors.mansourDarkOrange3,
             controller: sn.lastNameController,
             onChanged: (value) {
               sn.canSave2();
             },
           ),
           Gaps.vGap32,
           BlocConsumer<UserCubit, UserState>(
               bloc: sn.userCubit,
               listener: (context, state) {
                 if (state is UpdateProfileDone) {
                   print('aaaaa');
                   sn.onUpdated(state.updateProfileEntity);
                 }
               },
               builder: (context, state) {
                 return state.maybeMap(
                   userLoadingState: (s) => WaitingWidget(),
                   uploadImage: (s) => const ScreenNotImplementedError(),
                   userErrorState: (s) => ErrorScreenWidget(
                     error: s.error,
                     callback: s.callback,
                   ),
                   uploadImageDone: (s) => const ScreenNotImplementedError(),
                   getCityDone: (s) => ScreenNotImplementedError(),
                   updateAddress: (s) => ScreenNotImplementedError(),
                   updateAddressDone: (s) => ScreenNotImplementedError(),
                   getAddressesDone: (s) => ScreenNotImplementedError(),
                   addressDeleted: (s) =>ScreenNotImplementedError(),
                   changePasswordDone:(s) => ScreenNotImplementedError() ,
                   getProfileDone: (s) => ScreenNotImplementedError(),
                   userInitState: (s) => buildSave(),
                   updateProfile: (S) => WaitingWidget(),
                   updateProfileDone: (s) =>
                   buildSave(),
                   orElse: ()=> buildSave(),
                 );
               }),
         ],
        ),
      ),
    );
  }
  buildSave(){
    return sn.canSave ? CustomMansourButton(
      titleText: Translation.current.save,
      onPressed: (){
          sn.onSaveTap();
      },
    ) : CustomMansourButton(
      titleText: Translation.current.save,
      backgroundColor: AppColors.text_gray,
    );
  }
}
