import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/view_friend_moments_screen_notifier.dart';
import 'view_friend_moments_screen_content.dart';



class ViewFriendMomentsScreen extends StatefulWidget {
  static const String routeName = "/ViewFriendMomentsScreen";

  final ClientEntity clientEntity;
  const ViewFriendMomentsScreen({Key? key , required this.clientEntity}) : super(key: key);

  @override
  _ViewFriendMomentsScreenState createState() => _ViewFriendMomentsScreenState();
}

class _ViewFriendMomentsScreenState extends State<ViewFriendMomentsScreen> {
  final sn = ViewFriendMomentsScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.friendObject = widget.clientEntity;
    sn.getFriendMoments();

  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ProgressHUD(
         indicatorWidget: Material(
           color: Colors.transparent,
           child: TextWaitingWidget(
             Translation.current.claiming_rewards,
             textColor: Colors.white,
           ),
         ),
         child: Scaffold(
           body: ChangeNotifierProvider<ViewFriendMomentsScreenNotifier>.value(
            value: sn,
            child: ProgressHUD(
              indicatorWidget: Material(
                color: Colors.transparent,
                child: TextWaitingWidget(
                  Translation.current.claiming_rewards,
                  textColor: Colors.white,
                ),
              ),
              child: ChangeNotifierProvider.value(
                  value: sn,
                  child: BlocConsumer<UserCubit, UserState>(
                    bloc: sn.userCubit,
                      listener: (context , state){
                        if(state is GetFriendMomentsDone){
                          sn.onGetMomentsDone(state.momentEntity);
                        }
                      },
                    builder: (context , state){
                      return state.maybeMap(
                        userLoadingState: (s){
                          return WaitingWidget();
                        },
                        getFriendMomentsDone: (s) => _buildBody(),

                        orElse: () => _buildBody(),
                      );
                    },
                  ),
              ),
            ),
      ),
         ),
       );
    }

    _buildBody(){
    return Scaffold(
      backgroundColor: AppColors.mansourWhiteBackgrounColor_2,
      body: Stack(
        children: [
          ViewFriendMomentsScreenContent(),
        ],
      ),
    );
    }


}
  

 


