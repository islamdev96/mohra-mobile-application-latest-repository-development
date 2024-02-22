import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';

import '../screen/../state_m/provider/food_details_screen_notifier.dart';
import 'food_details_screen_content.dart';

class FoodDetailsScreen extends StatefulWidget {
  static const String routeName = "/FoodDetailsScreen";
  final DishEntity dishEntity;
  final int foodType;
  const FoodDetailsScreen({Key? key,required this.dishEntity , required this.foodType }) : super(key: key);

  @override
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late FoodDetailsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn =FoodDetailsScreenNotifier(widget.dishEntity ,widget.foodType);
    //sn.getDishById();

  }

  @override
  void dispose() {
    sn.closeNotifier();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodDetailsScreenNotifier>.value(
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
                  print('sdsdsdsd');
                  print(sn.dishEntity.isFavorite);
                  sn.dishEntity.isFavorite? sn.deleteFavorite() : sn.addToFavorite();
                },
                child: SvgPicture.asset(
                  AppConstants.SVG_HEART_FILL,
                  color: sn.dishEntity.isFavorite?AppColors.redColor : AppColors.mansourLightGreyColor_3,
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
        body: FoodDetailsScreenContent(),
      ),
    );
  }
}
