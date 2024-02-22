import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/toast.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/core/utils/insta-image-viewer/src/insta_image_viewer.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/health/presentation/widget/profile/one_user_info_carrd.dart';
import 'package:starter_application/features/health/presentation/widget/profile/user_information_card.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_header.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/user/presentation/screen/all_addresses_screen.dart';
import 'package:starter_application/features/user/presentation/screen/change_name_screen.dart';
import 'package:starter_application/features/user/presentation/screen/change_password_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/view_profile_screen_notifier.dart';
import 'change_email_screen.dart';
import 'delete_account_select_reason_screen.dart';

class ViewProfileScreenContent extends StatefulWidget {
  @override
  State<ViewProfileScreenContent> createState() =>
      _ViewProfileScreenContentState();
}

class _ViewProfileScreenContentState extends State<ViewProfileScreenContent> {
  late ViewProfileScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ViewProfileScreenNotifier>(context);
    sn.context = context;
    return RefreshConfiguration(
      headerBuilder: () => ClassicHeader(
        refreshingIcon: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SizedBox(
            height: 70.h,
            width: 70.h,
            child: const CircularProgressIndicator.adaptive(),
          ),
        ),
        releaseIcon: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SizedBox(
            height: 70.h,
            width: 70.h,
            child: const CircularProgressIndicator.adaptive(),
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 0,
        ),
      ),
      child: BlocConsumer<UserCubit, UserState>(
          bloc: sn.userCubit,
          listener: (context, state) {
            if (state is GetProfileDone) {
              print('aaaaa');
              sn.onProfileGettingDone(state.getProfileEntity);
            }
            if (state is UploadImageDone) {
              sn.onUpdateProfileImageDone(state.imageUrlsEntity);
              setState(() {});
            }
            if (state is UpdateProfileDone) {
              sn.onUpdateProfleDone(state.updateProfileEntity);
              sn.getAvatar();
              setState(() {});
            }
            if (state is AvatarLoaded) {
              sn.onLoadedAvatar(state.avatarListEntity);
            }
            if (state is GetAddressesDone) {
              sn.onAddressesLoaded(state.allAddressesEntity);
            }
          },
          builder: (context, state) {
            return state.map(
              addressSelectedDone: (s) => ScreenNotImplementedError(),
              setSelectAddress: (s) => ScreenNotImplementedError(),
              emailChanged: (s) => ScreenNotImplementedError(),
              deleteAccountDone: (s) => ScreenNotImplementedError(),
              addAddressDone: (s) => ScreenNotImplementedError(),
              userLoadingState: (s) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.10.sh,
                  ),
                  WaitingWidget(),
                ],
              ),
              userErrorState: (s) => ErrorScreenWidget(
                error: s.error,
                callback: s.callback,
              ),
              addressDeleted: (s) => ScreenNotImplementedError(),
              changePasswordDone: (s) => ScreenNotImplementedError(),
              updateProfile: (S) => buildScreen(),
              updateProfileDone: (s) => buildScreen(),
              uploadImage: (s) => buildScreen(),
              uploadImageDone: (s) => buildScreen(),
              getProfileDone: (s) => buildScreen(),
              getCityDone: (s) => buildScreen(),
              userInitState: (s) => buildScreen(),
              updateAddress: (s) => buildScreen(),
              updateAddressDone: (s) => buildScreen(),
              getAddressesDone: (s) => buildScreen(),
              avatarLoaded: (s) => buildScreen(),
              getFriendMomentsDone: (s) => ScreenNotImplementedError(),
            );
          }),
    );
  }

  UniqueKey key = UniqueKey();
  UniqueKey key2 = UniqueKey();

  buildScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 0.25.sh,
            child: Stack(
              children: [
                _buildCoverImage(1.sw, 0.22.sh, sn.getCoverImage()),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    height: 0.25.sw,
                    width: 1.sw,
                    child: Stack(
                      children: [
                        // GestureDetector(
                        //   onTap: (){
                        //     if(UserSessionDataModel.imageUrl != null){
                        //       _showMyDialog(CachedNetworkImage(
                        //         imageUrl: UserSessionDataModel.imageUrl!,
                        //         fit: BoxFit.cover,
                        //         imageBuilder: (context, imageProvider) => PhotoView(
                        //           imageProvider: imageProvider,
                        //         ),
                        //       ),context);
                        //     }
                        //   },
                        //   child:
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                sn.context,
                                PageRouteBuilder(
                                    opaque: false,
                                    barrierColor: Colors.white.withOpacity(0),
                                    pageBuilder: (BuildContext context, _, __) {
                                      return FullScreenViewer(
                                          tag: key,
                                          disableSwipeToDismiss: false,
                                          disposeLevel: DisposeLevel.high,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                UserSessionDataModel.imageUrl ??
                                                    "",
                                            placeholder: (context, url) {
                                              return CircularProgressIndicator
                                                  .adaptive();
                                            },
                                          )
                                          // Image(
                                          //   image: Image.network(,).image,
                                          // ),
                                          // child:  Container(
                                          //   width: 1.sw,
                                          //   height: 0.4.sw,
                                          //   decoration: BoxDecoration(
                                          //     image: DecorationImage(image: NetworkImage(UserSessionDataModel.imageUrl??""))
                                          //   ),
                                          // )
                                          );
                                    }));
                          },
                          child: Hero(
                              tag: key,
                              child: ProfilePic(
                                width: 0.20.sw,
                                height: 0.20.sw,
                                imageUrl: UserSessionDataModel.imageUrl ?? null,
                              )),
                        ),
                        // InstaImageViewer(child: ProfilePic(
                        //   width: 0.20.sw,
                        //   height: 0.20.sw,
                        //   imageUrl: UserSessionDataModel.imageUrl ?? null,
                        // ),),
                        Center(
                          child: Container(
                            width: 0.25.sw,
                            child: Align(
                              alignment: AlignmentDirectional(1, 1),
                              child: GestureDetector(
                                onTap: () {
                                  changeProfileImageTapper();
                                },
                                child: Container(
                                  height: 30,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mansourDarkOrange3,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/svg/camera2.svg',
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Gaps.vGap24,
          Container(
            width: 1.sw,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.35.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/png/coin.png',
                        height: 50,
                        width: 50,
                      ),
                      Gaps.vGap16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' Points ',
                            style: TextStyle(
                              color: AppColors.text_gray,
                            ),
                          ),
                          Text(
                            sn.getPoints(),
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Gaps.hGap64,
                Container(
                  width: 1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.text_gray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Gaps.hGap64,
                Container(
                  width: 0.35.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<UserCubit, UserState>(
                        bloc: sn.userCubit,
                        builder: (context, state) {
                          return ProfilePic(
                            height: 50,
                            width: 50,
                            imageUrl: sn.avatarImage,
                          );
                        },
                      ),
                      Gaps.vGap16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Character ',
                            style: TextStyle(
                              color: AppColors.text_gray,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Gaps.vGap32,
              _buildCard(
                Translation.current.full_name_label,
                sn.getName(),
                Icons.arrow_forward_ios,
                () {
                  Nav.to(ChangeNameScreen.routeName)
                      .then((value) => sn.notifyListeners());
                },
              ),
              Gaps.vGap32,
              _buildCard(
                Translation.current.userName,
                sn.getUserName(),
                Icons.copy,
                () async {
                  await Clipboard.setData(
                      ClipboardData(text: sn.getUserName()));
                  Toast.show('Copied',
                      backgroundColor: AppColors.mansourDarkOrange3);
                },
              ),
              Gaps.vGap32,
              _buildCard(
                Translation.current.phone,
                sn.getPhoneNumber(),
                Icons.arrow_forward_ios,
                () => Nav.to(ChangeEmailScreen.routeName, arguments: 1)
                    .then((value) => sn.notifyListeners()),
              ),
              Gaps.vGap32,
              _buildCard(
                Translation.current.email,
                sn.getEmail(),
                Icons.arrow_forward_ios,
                () => {Nav.to(ChangeEmailScreen.routeName, arguments: 0)},
              ),
              Gaps.vGap32,
              _buildCard(
                Translation.current.birth_date,
                sn.getBirthDate(),
                Icons.arrow_forward_ios,
                () => {changeBirthDateTapper()},
              ),
              Gaps.vGap32,
              _buildCard(
                Translation.current.address,
                sn.selectedAddress,
                Icons.arrow_forward_ios,
                () {
                  Nav.to(AllAddressesScreen.routeName).then((value) {
                    sn.getAddresses();
                  });
                },
              ),
              Gaps.vGap32,
              Visibility(
                visible: UserSessionDataModel.provider == 'normal',
                child: GestureDetector(
                  onTap: () {
                    Nav.to(ChangePasswordScreen.routeName);
                  },
                  child: Center(
                    child: Text(
                      Translation.current.change_password,
                      style: TextStyle(
                        color: AppColors.redColor2,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 0.2.sh,
          )
        ],
      ),
    );
  }

  _buildCard(String label, String value, IconData icon, Function() onTap) {
    var padding = label.length * (6);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: 0.9.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(color: AppColors.text_gray, fontSize: 40.sp),
            ),
            Gaps.hGap16,
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: .2.sw, maxWidth: .7.sw - (padding)),
              child: Text(
                value,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 40.sp,
                  overflow: TextOverflow.ellipsis,
                ),
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
            ),
            Spacer(),
            Icon(
              icon,
              color: AppColors.text_gray,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _showMyDialog(widget,context) async {
  //   return showGeneralDialog<void>(
  //     context: context,
  //     useRootNavigator: true,
  //     barrierDismissible: false, // user must tap button!
  //     pageBuilder: (_,__,___) {
  //       return SafeArea(
  //         child: Container(
  //           color: Colors.black,
  //           child: Stack(
  //             children: [
  //               Align(
  //                 alignment: const Alignment(.9,-.9),
  //                 child: GestureDetector(
  //                   onTap: (){
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     width: 40,
  //                     height: 40,
  //                     decoration: const BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color: Colors.white,
  //                     ),
  //                     child: Center(
  //                       child: Icon(Icons.close_rounded),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Center(
  //                 child: SizedBox(
  //                   child: Container(
  //                     width: 1.sw,
  //                     height: .5.sh,
  //                     child:widget ,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  _buildCoverImage(double width, double height, String? imageUrl) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          child: InkWell(
              onTap: () {
                Navigator.push(
                    sn.context,
                    PageRouteBuilder(
                        opaque: false,
                        barrierColor: Colors.white.withOpacity(0),
                        pageBuilder: (BuildContext context, _, __) {
                          return FullScreenViewer(
                              tag: key2,
                              disableSwipeToDismiss: false,
                              disposeLevel: DisposeLevel.high,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl ?? "",
                                placeholder: (context, url) {
                                  return SizedBox();
                                },
                              ));
                        }));
                //   changeCoverImageTapper();
              },
              child: Hero(
                tag: key2,
                child: MomentHeader(
                  height: 0.1.sh,
                  width: 1.sw,
                  image: sn.getCoverImage(),
                ),
              )),
        ),
        Positioned(
          width: 0.25.sw,
          right: 1,
          top: 0.17.sh,
          child: GestureDetector(
            onTap: () {
              changeCoverImageTapper();
            },
            child: Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mansourDarkOrange3,
              ),
              child: SvgPicture.asset(
                'assets/images/svg/camera2.svg',
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  /// UI Controllers
  changeProfileImageTapper() {
    showModalBottomSheet(
      context: sn.context,
      builder: (ctx) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Change_Profile_Photo,
                        style: TextStyle(
                            fontSize: 50.sp, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Nav.pop();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                  Gaps.vGap16,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Camera,
                    onTap: () {
                      sn.changeProfileImage(0);
                    },
                    icon: 'assets/images/svg/icon/camera_profile.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Gallery,
                    onTap: () {
                      sn.changeProfileImage(1);
                    },
                    icon: 'assets/images/svg/icon/gallary_icon.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).Use_Avatar,
                    onTap: () {
                      sn.changeProfileImage(2);
                    },
                    icon: 'assets/images/svg/icon/use_avatar_icon.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).Delete_Profile_Image,
                    onTap: () {
                      sn.changeProfileImage(3);
                    },
                    icon: 'assets/images/svg/icon/delete_image_icon.svg',
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                10,
              ),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: 1.sh,
            minHeight: 0.4.sh,
          ),
          enableDrag: false,
        );
      },
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 1.sh,
        minHeight: 0.4.sh,
      ),
    );
  }

  changeCoverImageTapper() {
    showModalBottomSheet(
      context: sn.context,
      builder: (ctx) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Change_Cover_Photo,
                        style: TextStyle(
                            fontSize: 50.sp, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Nav.pop();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                  Gaps.vGap16,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Camera,
                    onTap: () {
                      sn.changeCoverImage(0);
                    },
                    icon: 'assets/images/svg/icon/camera_profile.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Gallery,
                    onTap: () {
                      sn.changeCoverImage(1);
                    },
                    icon: 'assets/images/svg/icon/gallary_icon.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).delete_image_title,
                    onTap: () {
                      sn.changeCoverImage(2);
                    },
                    icon: 'assets/images/svg/icon/delete_image_icon.svg',
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                10,
              ),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: 1.sh,
            minHeight: 0.3.sh,
          ),
          enableDrag: false,
        );
      },
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 1.sh,
        minHeight: 0.3.sh,
      ),
    );
  }

  buildEditImageCard({
    required Function() onTap,
    required String text,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: onTap, icon: SvgPicture.asset(icon)),
            Gaps.hGap12,
            Text(
              text,
              style: TextStyle(
                fontSize: 50.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeBirthDateTapper() {
    showModalBottomSheet(
      context: sn.context,
      builder: (ctx) {
        return ValueListenableBuilder(
            valueListenable: sn.selectedDateListen,
            builder: (_, __, ___) {
              return BottomSheet(
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translation.current.edit_birth_date,
                              style: TextStyle(
                                  fontSize: 50.sp, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  Nav.pop();
                                },
                                icon: Icon(Icons.clear))
                          ],
                        ),
                        Gaps.vGap32,
                        GestureDetector(
                          onTap: () async {
                            DateTime? d = await sn.saveDateTapper();
                            print('$d');
                            if (d != null) {
                              sn.selectedDate = d;
                            }
                          },
                          child: Container(
                            width: 0.8.sw,
                            child: CustomTextField(
                              enabled: false,
                              controller: sn.textEditingController,
                              maxLines: 9,
                              height: 200,
                              hintText: DateTimeHelper.getStringDateInEnglish(
                                  sn.selectedDateListen.value),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.text_gray),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.text_gray),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.text_gray),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.text_gray),
                              ),
                            ),
                          ),
                        ),
                        Gaps.vGap32,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomMansourButton(
                              height: 40,
                              width: 0.4.sw,
                              titleText: Translation.current.save,
                              onPressed: () {
                                sn.changeBirthDate();
                              },
                            ),
                            CustomMansourButton(
                              height: 40,
                              width: 0.4.sw,
                              titleText: Translation.current.cancel,
                              backgroundColor: AppColors.text_gray,
                              onPressed: () {
                                Nav.pop();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                onClosing: () {},
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      10,
                    ),
                  ),
                ),
                constraints: BoxConstraints(
                  maxHeight: 1.sh,
                  minHeight: 0.4.sh,
                ),
                enableDrag: false,
              );
            });
      },
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 1.sh,
        minHeight: 0.4.sh,
      ),
    );
  }
}

// old
/*Text(
                  '${UserSessionDataModel.fullName}',
                  style: TextStyle(
                    fontSize: 50.sp,
                  ),
                ),
                Gaps.vGap24,
                Divider(
                  thickness: 1,
                  color: AppColors.mansourDarkOrange,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.firstName,
                  infoValue: UserSessionDataModel.name,
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.lastName,
                  infoValue: UserSessionDataModel.surname,
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.userName,
                  infoValue: '${UserSessionDataModel.userName}',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.email,
                  infoValue: '${UserSessionDataModel.emailAddress}',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.phone,
                  infoValue: '${UserSessionDataModel.phoneNumber}',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.gender,
                  infoValue:
                      UserSessionDataModel.gender! == 0 ? 'Female' : 'Male',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.date,
                  infoValue:
                      '${DateFormat("yyyy-MM-dd").format(DateTime.parse(UserSessionDataModel.birthday))}',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.my_points,
                  infoValue: '${UserSessionDataModel.points}',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.mansourDarkOrange,
                ),*/
