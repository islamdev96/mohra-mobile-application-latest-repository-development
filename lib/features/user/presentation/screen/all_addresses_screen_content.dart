import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/all_addresses_screen_notifier.dart';
import 'edit_address_screen.dart';

class AllAddressesScreenContent extends StatelessWidget {
  late AllAddressesScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AllAddressesScreenNotifier>(context);
    sn.context = context;
    return Container(
      child: BlocConsumer<UserCubit, UserState>(
          bloc: sn.userCubit,
          listener: (context, state) {
            if (state is GetAddressesDone) {
              sn.onAddressesDone(state.allAddressesEntity);
            }
            if(state is AddressDeleted){
              sn.onAddressDeleted();
            }
            if(state is AddressSelectedDone){
              sn.getAllAddresses();
            }
          },
          builder: (context, state) {
            return state.map(
              emailChanged:(s) => ScreenNotImplementedError(),
              deleteAccountDone: (s) => ScreenNotImplementedError(),
              addAddressDone: (s) => ScreenNotImplementedError(),
              avatarLoaded: (s) => ScreenNotImplementedError(),
              updateAddress: (s) => const ScreenNotImplementedError(),
              updateAddressDone: (s) => const ScreenNotImplementedError(),
              getCityDone: (s) => const ScreenNotImplementedError(),
              userInitState: (s) => ScreenNotImplementedError(),
              userLoadingState: (s) => WaitingWidget(),
              uploadImage: (s) => ScreenNotImplementedError(),
              userErrorState: (s) => ErrorScreenWidget(
                error: s.error,
                callback: s.callback,
              ),
              updateProfile: (S) => ScreenNotImplementedError(),
              updateProfileDone: (s) => ScreenNotImplementedError(),
              uploadImageDone: (s) => ScreenNotImplementedError(),
              addressDeleted: (s) => buildList(),
              changePasswordDone: (s) => ScreenNotImplementedError(),
              getProfileDone: (s) => ScreenNotImplementedError(),
              setSelectAddress: (s) =>   TextWaitingWidget(
                Translation.current.change_selected_address,
                textColor: AppColors.mansourDarkOrange3,
              ),
              addressSelectedDone:(s) => buildList(),
              getAddressesDone: (s) => buildList(),
              getFriendMomentsDone: (s) => ScreenNotImplementedError(),
            );
          }),
    );
  }

  buildList() {
    return SizedBox(
      height: 1.sh,
      child: ListView.separated(
        itemCount: sn.addresses.addresses.length,
        padding: EdgeInsets.only(
          bottom: 32.h,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 0.9.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.text_gray.withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 3,
                    offset: Offset(0, 0),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${sn.addresses.addresses[index].cityName} ',
                  style: TextStyle(
                    color: AppColors.mansourDarkOrange3,
                    fontSize: 50.sp,
                  ),
                  maxLines: 1,
                ),
                Gaps.vGap32,
                Text(
                  '${sn.addresses.addresses[index].street} ',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 40.sp,
                  ),
                  maxLines: 1,
                ),
                Gaps.vGap32,
                Text(
                  '${sn.addresses.addresses[index].description} ',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 40.sp,
                  ),
                  maxLines: 4,
                ),
                Gaps.vGap32,
                Row(
                  children: [
                    GestureDetector(
                        onTap: () async {
                          sn.onEditAddress(index);
                          //
                        },
                        child: SvgPicture.asset(
                          'assets/images/svg/edit_cover_icon.svg',
                          color: AppColors.black,
                        )),
                    Gaps.hGap64,
                    GestureDetector(
                        onTap: () {
                          sn.onDeleteAddress(index);
                        },
                        child: SvgPicture.asset(
                          'assets/images/svg/icon/delete_image_icon.svg',
                          color: AppColors.black,
                        )),
                    Gaps.hGap64,
                    Spacer(),
                    buildSelectedAddressWidget(sn.addresses.addresses[index]),
                  ],
                ),
                Gaps.vGap32,
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 60.h,
          );
        },
      ),
    );
  }

  buildSelectedAddressWidget(AddressEntity address) {
    if(address.isDefault ?? false){
      return Text(
        Translation.current.selected_address,
        style: TextStyle(
          color: AppColors.greenColor,
          fontSize: 40.sp,
          
        ),
      );
    }
    else{
      return CustomMansourButton(
        height: 30,
        titleText:  Translation.current.select_address,
        textSize: 40.sp,
        onPressed: (){
          sn.setSelectedAddress(address.id);
        },
      );
    }
  }
}
