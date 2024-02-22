import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/help/domain/entity/reasons_entity.dart';
import 'package:starter_application/features/help/presentation/state_m/cubit/help_cubit.dart';
import 'package:starter_application/features/user/presentation/widget/contact_text_field.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../core/ui/widgets/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../screen/../state_m/provider/contact_us_screen_notifier.dart';

class ContactUsScreenContent extends StatelessWidget {
  late ContactUsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ContactUsScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
        body: BlocConsumer<HelpCubit, HelpState>(
      bloc: sn.helpCubit,
      listener: (context, state) {
        if (state is ReasonsListLoadedState) {
          sn.onReasonsListLoaded(state.entity);
        }
      },
      builder: (context, state) {
        return state.maybeMap(
          helpLoadingState: (s) => WaitingWidget(),
          reasonsListLoaded: (s) => _buildScreen(context),
          orElse: () => _buildScreen(context),
        );
      },
    ));
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
                  Translation.current.contact_us,
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
          child: Container(
            width: .9.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.current.subject,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyHelp2,
                      fontSize: 45.sp),
                ),
                Gaps.vGap32,
                Center(
                  child: ContactTextField(
                    textType: TextInputType.text,
                    action: TextInputAction.next,
                    height: 60,
                    controller: sn.subjectController,
                    width: 0.9.sw,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap50,
        Center(
          child: Container(
            width: .9.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.current.reason,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyHelp2,
                      fontSize: 45.sp),
                ),
                Gaps.vGap32,
                Center(
                  child: Container(
                    width: .9.sw,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffD0D5DD), width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<ReasonsItemEntity>(
                        underline: SizedBox(),
                        isExpanded: true,
                        hint: Text(sn.getText(sn.selectedReason)),
                        items: sn.reasonsListEntity.items.map((ReasonsItemEntity value) {
                          return DropdownMenuItem<ReasonsItemEntity>(
                            value: value,
                            child: Text(sn.getText(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          print(value);
                          if(value != null){
                            sn.selectedReason = value;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap50,
        Center(
          child: Container(
            width: .9.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.current.description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyHelp2,
                      fontSize: 45.sp),
                ),
                Gaps.vGap32,
                Center(
                  child: ContactTextField(
                    textType: TextInputType.text,
                    action: TextInputAction.next,
                    height: 250,
                    controller: sn.descriptionController,
                    width: 0.9.sw,
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap50,
        BlocConsumer<HelpCubit, HelpState>(
          bloc: sn.helpCubit,
          listener: (context, state) {
            if(state is CreateContactUsTicketLoaded){
              showSnackbar(Translation.current.ticket_created_success);
              sn.onTicketCreated();
            }
          },
          builder: (context, state) {
            return state.maybeMap(
              createContactUsTicketLoading: (s) =>WaitingWidget(),
              orElse: ()=> Center(
                child: CustomMansourButton(
                  titleText: Translation.current.submit,
                  width: .8.sw,
                  textColor: AppColors.lightFontColor,
                  onPressed: () {
                    sn.onCreateTapped();
                  },
                ),
              ),
            );
          },

        ),
      ],
    );
  }
}
