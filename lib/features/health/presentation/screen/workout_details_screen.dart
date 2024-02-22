import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';

import '../screen/../state_m/provider/workout_details_screen_notifier.dart';
import 'workout_details_screen_content.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  static const String routeName = "/WorkoutDetailsScreen";
  final OneSessionEntity oneSessionEntity;

  const WorkoutDetailsScreen({Key? key , required this.oneSessionEntity}) : super(key: key);

  @override
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  late  WorkoutDetailsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = WorkoutDetailsScreenNotifier(widget.oneSessionEntity);

  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: 30.w,
            ),
            child:BlocListener<FavoriteCubit,FavoriteState>(
              bloc: sn.favoriteCubit,
              child:  GestureDetector(
                onTap: () {
                  sn.oneSessionEntity.isFavorite!? sn.deleteFavorite() : sn.addToFavorite();

                },
                child: SvgPicture.asset(
                  AppConstants.SVG_HEART_FILL,
                  color: sn.oneSessionEntity.isFavorite!?AppColors.redColor : AppColors.mansourLightGreyColor_3,
                  height: 70.h,
                  width: 70.h,
                ),
              ),
              listener: (context,state){
                if(state is CreateFavoriteSuccessState){
                  sn.addingDone(state.favoriteEntity);
                  setState(() {

                  });
                }
                if(state is DeleteFavoriteSuccessState){
                  sn.deleteDone();
                  setState(() {

                  });
                }
              },
              listenWhen: (previousState, state) {
                return  previousState != state;
              },
            ),
          ),
        ]),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: WorkoutDetailsScreenContent(),
      ),
    );
  }
}
