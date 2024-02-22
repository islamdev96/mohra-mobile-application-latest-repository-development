import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/challenge_details_screen_params.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_challege_details.request.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/friend/presentation/screen/select_friends_screen.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:flutter/services.dart';
import 'package:geocoder2/geocoder2.dart';
class ChallengeScreenNotifier extends ScreenNotifier {
  /// Constructor
  ChallengeScreenNotifier(this.param);

  late BuildContext context;
  List<FriendEntity> _friends = [];
  ChallengeCubit challengeCubit = ChallengeCubit();
  ChallengeCubit challengeStepsCubit = ChallengeCubit();
  final ChallengeDetailsScreenParams param;
  int _currentStep = 0;

  int get currentStep => this._currentStep;
  bool isLoading = true;
  List<FriendEntity> get friends => this._friends;
  late ChallangeItemEntity itemEntity;
  bool get loading => isLoading;
  set loading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  set currentStep(int value) {
    this._currentStep = value;
    notifyListeners();
  }

  String targetLocationAddress = '';

  load(value) {
    isLoading = value;
    notifyListeners();
  }

  getChallengeDetails(id) {
    challengeCubit.getChallenge(GetChallengeDetailsRequest(id: id));

    notifyListeners();
  }

  setChallengeDetails(ChallangeItemEntity item)async {
    itemEntity = item;
    _currentStep = item.currentStep ?? 0;
    await getLocationDetails();
    isLoading = false;

    notifyListeners();
  }

  onFriendsTap(id) {
    if (itemEntity.currentStep == 1) {
      Nav.to(SelectFriendsScreen.routeName,
          arguments: SelectFriendsScreenParam(
              challengeId: id,
              isChallenge: true,
              onSelectFriends: (friends) {
                _friends = friends;
                print("hereee$_friends");
                if (_friends.isNotEmpty) {
                  challengeStepsCubit.inviteFriends(InviteFriendsRequest(
                      challengeId: id,
                      friends: friends
                          .map((e) => e.friendId)
                          .whereType<int>()
                          .toList()));
                }
                notifyListeners();
              }));
    }
  }

  void claimRewards(id) {
    challengeStepsCubit.claimRewards(ClaimRewardsRequest(id: id));
  }

  void JoinOrUnjoin(id, isJoiin) {
    challengeStepsCubit
        .joinOrUnJoinChallenges(JoinRequest(id: id, join: isJoiin));
  }

  @override
  void closeNotifier() {
    challengeCubit.close();
    challengeStepsCubit.close();
    this.dispose();
  }

  void onVerifyPostCreated() {
    getChallengeDetails(itemEntity.id);
    param.onStepChange?.call(itemEntity.currentStep!);
  }

  getLocationDetails() async {
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: itemEntity.firstLocationLatitude!,
        longitude: itemEntity.firstLocationLongitude!,
        googleMapApiKey: AppConstants.API_KEY_GOOGLE_MAPS);
    //Formated Address
    targetLocationAddress = data.address;


  }



}
