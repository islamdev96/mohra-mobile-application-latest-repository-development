import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
import 'package:starter_application/features/health/domain/entity/recipe_list_entity.dart';

import '../screen/../state_m/provider/reciepe_details_screen_notifier.dart';
import 'reciepe_details_screen_content.dart';

class ReciepeDetailsScreen extends StatefulWidget {
  static const String routeName = "/ReciepeDetailsScreen";
  final RecipeEntity recipeEntity;
  final int foodType;
  const ReciepeDetailsScreen({Key? key , required this.recipeEntity ,required this.foodType}) : super(key: key);

  @override
  _ReciepeDetailsScreenState createState() => _ReciepeDetailsScreenState();
}

class _ReciepeDetailsScreenState extends State<ReciepeDetailsScreen> {
  late ReciepeDetailsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = ReciepeDetailsScreenNotifier(widget.recipeEntity ,widget.foodType);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReciepeDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: 30.w,
            ),
            child:BlocListener<FavoriteCubit,FavoriteState>(
              bloc: sn.favoriteCubit,
              child: GestureDetector(
                onTap: (){
                  sn.recipeEntity.isFavorite? sn.deleteFavorite() : sn.addToFavorite();
                },
                child: SvgPicture.asset(
                  AppConstants.SVG_HEART_FILL,
                  color: sn.recipeEntity.isFavorite?AppColors.redColor : AppColors.mansourLightGreyColor_3,
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
        body: ReciepeDetailsScreenContent(),
      ),
    );
  }
}
