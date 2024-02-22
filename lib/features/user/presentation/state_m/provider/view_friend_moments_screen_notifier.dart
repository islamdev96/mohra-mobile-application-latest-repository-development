import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart' as friend;
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/user/data/model/request/get_my_friend_moments_params.dart';
import 'package:starter_application/features/user/domain/usecase/get_my_friend_moments_usecase.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class ViewFriendMomentsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late friend.ClientEntity friendObject;
  final userCubit = UserCubit();
  late MomentEntity momentEntity;
  List<MomentItemEntity> moments = [];

  final RefreshController momentsRefreshController = RefreshController();

  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }


  getFriendMoments(){
    userCubit.getMyFriendMometns(GetMyFriendMomentsParams(ClientId: this.friendObject.id!));
  }

  onGetMomentsDone(MomentEntity momentEntity){
    this.momentEntity = momentEntity;
    moments = momentEntity.items ??[];
    notifyListeners();
  }


  Future<Result<AppErrors, List<MomentItemEntity>>> getMomentsItems(
      int unit) async {
    final result = await getIt<GetMyFriendMomentsUseCase>()(
        GetMyFriendMomentsParams(
          SkipCount: unit * 10,
          MaxResultCount: 10,
          ClientId: this.friendObject.id!,
        ));
    return Result<AppErrors, List<MomentItemEntity>>(
        data: result.data?.items, error: result.error);
  }

  void onMomentsItemsFetched(List<MomentItemEntity> items, int nextUnit) {
    moments = items;
    notifyListeners();
  }
}
