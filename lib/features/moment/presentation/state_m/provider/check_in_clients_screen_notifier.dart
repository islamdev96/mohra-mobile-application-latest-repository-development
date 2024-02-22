import 'package:flutter/material.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/features/account/data/model/request/get_nearby_clients_request.dart';
import 'package:starter_application/features/account/domain/entity/nearby_client_entity.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/moment/presentation/screen/check_in_clients/check_in_clients_screen.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class CheckInClientsScreenNotifier extends ScreenNotifier {
  /// Constructor
  CheckInClientsScreenNotifier(this.param);

  /// Fields
  late BuildContext context;
  final CheckInClientsScreenParam param;
  AccountCubit accountCubit = AccountCubit();
  List<NearbyClientEntity> clients = [];

  /// Getters and Setters

  /// Methods
  getClients() {
    accountCubit.getNearbyClients(GetNearbyClientsParams(
        clientId: UserSessionDataModel.userId,
        longitude: param.location.longitude,
        latitude: param.location.latitude));
  }

  navToUserProfile(NearbyClientEntity clientEntity) {
    Nav.to(VisitUserProfileScreen.routeName,
        arguments: VisitUserProfileScreenParams(id: clientEntity.id!));
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
