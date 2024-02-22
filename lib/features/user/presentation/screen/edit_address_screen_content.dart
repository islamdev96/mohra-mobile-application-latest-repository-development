import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/widget/health_dropdown.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/features/user/presentation/widget/custom_text_field.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/edit_address_screen_notifier.dart';

class EditAddressScreenContent extends StatelessWidget {
  late EditAddressScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EditAddressScreenNotifier>(context);
    sn.context = context;
    sn.createMarkerImageFromAsset(context);
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 0.9.sw,
            height: 1.sh,
            child: BlocConsumer<UserCubit, UserState>(
                bloc: sn.userCubit,
                listener: (context, state) {

                },
                builder: (context, state) {
                  return state.map(
                    addressSelectedDone:(s) => ScreenNotImplementedError(),
                    setSelectAddress: (s) => ScreenNotImplementedError(),
                    emailChanged:(s) => ScreenNotImplementedError(),
                    deleteAccountDone: (s) => ScreenNotImplementedError(),
                    addAddressDone: (s) => ScreenNotImplementedError(),
                    userLoadingState: (s) => WaitingWidget(),
                    uploadImage: (s) => const ScreenNotImplementedError(),
                    userErrorState: (s) => ErrorScreenWidget(
                      error: s.error,
                      callback: s.callback,
                    ),
                    updateProfile: (S) => const ScreenNotImplementedError(),
                    updateProfileDone: (s) => const ScreenNotImplementedError(),
                    uploadImageDone: (s) => const ScreenNotImplementedError(),
                    getCityDone: (s) => _buildScreen(),
                    userInitState: (s) => _buildScreen(),
                    updateAddress: (s) => _buildScreen(),
                    updateAddressDone: (s) => _buildScreen(),
                    getAddressesDone: (s) =>
                        _buildAnimation(child: _buildContinueButton(), num: 4),
                    addressDeleted: (s) => ScreenNotImplementedError(),
                    changePasswordDone: (s) => ScreenNotImplementedError(),
                    getProfileDone: (s) => ScreenNotImplementedError(),
                    avatarLoaded: (s) => ScreenNotImplementedError(),
                    getFriendMomentsDone: (s) => ScreenNotImplementedError(),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation({
    required Widget child,
    required int num,
    double step = 0.1,
  }) {
    final intervalStart = step * num;

    return SlidingAnimated(
      direction: Axis.vertical,
      initialOffset: 5,
      intervalStart: intervalStart,
      intervalEnd: intervalStart + step,
      child: child,
    );
  }

  Widget _buildContinueButton() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: CustomMansourButton(
        width: 300.h,
        borderRadius: Radius.circular(
          20.r,
        ),
        titleText: Translation.current.save,
        backgroundColor: AppColors.mansourDarkOrange,
        onPressed: sn.onUpdateTapped,
      ),
    );
  }

  _buildScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildAnimation(
            child: CustomTextField(
              textType: TextInputType.text,
              action: TextInputAction.next,
              lableText: Translation.current.city,
              height: 100,
              controller: sn.cityController,
              width: 0.9.sw,
              maxLines: 5,
            ),
            num: 1),
        Gaps.vGap24,
        _buildAnimation(
          num: 2,
          child: CustomTextField(
            textType: TextInputType.text,
            action: TextInputAction.next,
            lableText: Translation.current.address_street,
            height: 100,
            controller: sn.streetController,
            width: 0.9.sw,
            maxLines: 5,
          ),
        ),
        Gaps.vGap24,
        _buildAnimation(
            num: 3,
            child: CustomTextField(
              textType: TextInputType.text,
              action: TextInputAction.done,
              height: 150,
              lableText: Translation.current.address_desc,
              controller: sn.descriptionController,
              width: 0.9.sw,
              maxLines: 5,
            )),
        Gaps.vGap24,
        _buildAnimation(child: _buildMap(), num: 6),
        Gaps.vGap24,
        BlocConsumer<UserCubit, UserState>(
            bloc: sn.userCubit,
            listener: (context, state) {
              if (state is UpdateAddressDone) {
                sn.onAddressUpdated(state.addressEntity);
              }
            },
            builder: (context, state) {
              return state.map(
                addressSelectedDone:(s) => ScreenNotImplementedError(),
                setSelectAddress: (s) => ScreenNotImplementedError(),
                emailChanged:(s) => ScreenNotImplementedError(),
                addAddressDone: (s) => ScreenNotImplementedError(),
                updateAddress: (s) => WaitingWidget(),
                updateAddressDone: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                getCityDone: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                userInitState: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                userLoadingState: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                uploadImage: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                userErrorState: (s) => ErrorScreenWidget(
                  error: s.error,
                  callback: s.callback,
                ),
                updateProfile: (S) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                updateProfileDone: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                uploadImageDone: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                getAddressesDone: (s) =>
                    _buildAnimation(child: _buildContinueButton(), num: 4),
                addressDeleted: (s) => ScreenNotImplementedError(),
                changePasswordDone: (s) => ScreenNotImplementedError(),
                getProfileDone: (s) => ScreenNotImplementedError(),
                avatarLoaded: (s) => ScreenNotImplementedError(),
                deleteAccountDone: (s) => ScreenNotImplementedError(),
                getFriendMomentsDone: (s) => ScreenNotImplementedError(),
              );
            }),
      ],
    );
  }

  _buildMap() {
    return Center(
      child: SizedBox(
        width: 350.0,
        height: 250.0,
        child: Scaffold(
          body: GoogleMap(
            onTap: (newP) {
              sn.updateMarker(MarkerId('1'), newP);
              sn.result = newP;
              sn.controller!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: 0,
                  target: LatLng(newP.latitude, newP.longitude),
                  zoom: 17.0,
                ),
              ));
              sn.notifyListeners();
            },
            initialCameraPosition: CameraPosition(
              target: sn.kMapCenter,
              zoom: 12.0,
            ),
            markers: <Marker>{
              sn.markers.values
                  .toList()
                  .firstWhere((item) => item.markerId == MarkerId('1')),
            },
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())),
            onMapCreated: sn.onMapCreated,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            buildingsEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,


          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              var newP =await  sn.currentLocation();
              sn.updateMarker(MarkerId('1'), newP);
              sn.result = newP;
              sn.controller!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: 0,
                  target: LatLng(newP.latitude, newP.longitude),
                  zoom: 17.0,
                ),
              ));
              sn.notifyListeners();
            },
            child: Icon(Icons.my_location_outlined),
            backgroundColor: AppColors.white.withOpacity(1),
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}
