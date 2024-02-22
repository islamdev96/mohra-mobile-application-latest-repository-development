import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/models/profile.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';

part 'app_config_state.dart';

/// App config methods goes here
/// Like methods related to app behaviour
class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(AppConfigState.initialState);

  Future<AppConfigState> applicationStarted() async {
    final profile = await _getUserProfile();
    return this.state.copyWith(
          isApplicationStarted: true,
          profile: profile,
        );
  }

  Future<AppConfigState> userLogout() async {
    AppConfig().deleteToken();
    Navigator.of(getIt<NavigationService>().appContext!)
        .pushNamedAndRemoveUntil(
      LoginScreen.routeName,
      (Route<dynamic> route) => false,
    );

    return this.state.clearProfile();
  }

  Future<AppConfigState> setUserProfile() async {
    return this.state.copyWith(
          profile: Profile(
            phoneConfirmed: false,
            name: "Issa",
          ),
        );
  }

  Future<AppConfigState> verifyUserAccount() async {
    final profile = Profile(phoneConfirmed: false, name: "Issa");
    final newProfile = profile.copyWith(phoneConfirmed: true);
    return this.state.copyWith(profile: newProfile);
  }

  Future<Profile?> _getUserProfile() async {
    if (!await AppConfig().hasToken) return null;

    return Profile(phoneConfirmed: true);
  }
}
