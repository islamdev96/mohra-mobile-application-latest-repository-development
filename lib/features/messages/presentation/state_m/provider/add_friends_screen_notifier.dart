import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/friend/data/model/request/get_clients_request.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../core/models/user_session_data_model.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/params/screen_params/visit_user_profile_screen_params.dart';
import '../../../../user/presentation/screen/view_profile_screen.dart';
import '../../../../user/presentation/screen/visit_user_profile_screen.dart';

class AddFriendsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  List<ClientEntity> clients = [];
  FriendCubit friendCubit = FriendCubit();

  RefreshController refreshController = RefreshController();

  TextEditingController searchController = TextEditingController();
  CancelToken? cancelToken;

  AddFriendsScreenNotifier() {
    searchController.addListener(() {
      if (searchController.text != '') getClients();
    });
  }

  /// Getters and Setters

  /// Methods

  Future<Result<AppErrors, List<ClientEntity>>> returnData(int unit) async {
    return friendCubit.returnClientsWithoutFriends(
      getClientParams(unit),
    );
  }

  void onDataFetched(List<ClientEntity> items, int nextUnit) {
    clients = items;
    notifyListeners();
  }

  getClients() {
    clients = [];
    notifyListeners();
    cancelToken?.cancel();
    friendCubit.getClientsWithoutFriends(getClientParams(0));
  }

  GetClientsRequest getClientParams(int unit) {
    cancelToken = CancelToken();
    String finalText=searchController.text;
    if(searchController.text.startsWith("0")){
      finalText=searchController.text.substring(1,searchController.text.length);
    }
    return GetClientsRequest(
        skipCount: unit * 10,
        keyword: finalText,
        cancelToken: cancelToken,
        CheckContain: true,
    );
  }

  @override
  void closeNotifier() {
    friendCubit.close();
    searchController.dispose();
    this.dispose();
  }
  navToUserProfile(ClientEntity clientEntity) {
    if (clientEntity.id == UserSessionDataModel.userId)
      Nav.to(
        ViewProfileScreen.routeName,
      );
    else
      Nav.to(VisitUserProfileScreen.routeName,
          arguments: VisitUserProfileScreenParams(id: clientEntity.id!));
  }

}
