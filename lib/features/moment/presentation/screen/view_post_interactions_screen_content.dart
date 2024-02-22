import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/Interact/presentation/state_m/cubit/Interact_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/view_post_interactions_screen_notifier.dart';

class ViewPostInteractionsScreenContent extends StatefulWidget {
  @override
  State<ViewPostInteractionsScreenContent> createState() => _ViewPostInteractionsScreenContentState();
}

class _ViewPostInteractionsScreenContentState extends State<ViewPostInteractionsScreenContent> {
  late ViewPostInteractionsScreenNotifier sn;
  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ViewPostInteractionsScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 50.h),
        child: BlocConsumer<InteractCubit , InteractState>(
          bloc: sn.interactCubit,
          listener: (context, state){
              if(state is InteractListLoaded){
                sn.onInteractionListLoaded(state.getInteractionListEntity);
              }
          },
          builder: (context, state){
            return state.maybeMap(
              interactLoadingState: (s)=> WaitingWidget(),
              orElse: ()=> buildList(),
            );
          },
        ),
      ),
    );
  }


  Widget buildList(){
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Text(
          '${Translation.current.all} ${sn.interactions.length}',
          style: TextStyle(
            fontSize: 50.sp,
            color: AppColors.mansourDarkOrange,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        Container(
          height: 0.9.sh,
          width: 0.9.sw,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.h,
                      height: 120.h,
                      child: Stack(
                        children: [
                          ProfilePic(width: 120.h, height: 120.h , imageUrl: sn.interactions[index].client!.imageUrl?? '',),
                          PositionedDirectional(
                            bottom: 0,
                            end: 0,
                            child: buildReaction(sn.interactions[index].interactionType!),
                          )
                        ],
                      ),
                    ),
                    Gaps.hGap32,
                    Text('${sn.interactions[index].client?.name ?? ''}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap32;
              },
              itemCount: sn.interactions.length),
        )
      ],
    );
  }

 Widget  buildReaction(int type){
    String Icon = '';
    switch(type){
      case 0 :
        Icon = AppConstants.IMAGE_SAD_REACTION;
        break;
      case 1 :
        Icon = AppConstants.IMAGE_WINK_REACTION;
        break;
      case 2 :
        Icon = AppConstants.IMAGE_LOVE_REACTION;
        break;
      case 3 :
        Icon = AppConstants.IMAGE_NASTY_REACTION;
        break;
      case 4 :
        Icon = AppConstants.IMAGE_CUDDLY_REACTION;
        break;
      case 5 :
        Icon = AppConstants.IMAGE_LIKE_REACTION;
        break;
      case 6 :
        Icon = AppConstants.IMAGE_DISLIKE_REACTION;
        break;
    }
    return Container(
      height: 80.r,
      width: 80.r,
      child: Center(
        child: ClipOval(
          child: Container(
            child: Image.asset(
              Icon,
              height:70.h,
              width: 70.h,
            ),
          ),
        ),
      ),
    );
  }

}
