import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/features/health/presentation/screen/food_category_details_screen.dart';
import 'package:starter_application/features/health/presentation/widget/food_category/food_category_card.dart';
import 'package:starter_application/generated/l10n.dart';

class FoodCategoryGridView extends StatelessWidget {
  final width = 1.sw - AppConstants.hPadding * 2;
  final space = SizedBox(
    height: 40.h,
    width: 40.h,
  );

  late List<FoodCategoryCard> _cats;
  final int foodType;
  final List<FoodCategoryEntity> foodCategoryEntity;

  FoodCategoryGridView({
    required this.foodCategoryEntity,
    required this.foodType,
  }) {
    _cats = List.generate(
      foodCategoryEntity.length,
      (index) => FoodCategoryCard(
          height: 0.4.sw,
          title: foodCategoryEntity[index].title,
          image: foodCategoryEntity[index].imageUrl,
          onTap: () {
            print(foodType);
            Nav.to(FoodCategoryDetailsScreen.routeName,
                arguments: [foodCategoryEntity[index], foodType]);
          }),
    );
  }

  //@override
/*  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: TextStyle(
              color: Colors.black,
              fontSize: 55.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.vGap64,
          customGrid.MasonryGridView(
            gridDelegate:SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,

            ) ,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            shrinkWrap: true,
            children: _cats
              ,
          ),

        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.current.categories,
            style: TextStyle(
              color: Colors.black,
              fontSize: 55.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.vGap64,
          Expanded(
            child: GridView.builder(
              itemCount: foodCategoryEntity.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return FoodCategoryCard(
                  title: foodCategoryEntity[index].title,
                  image: '${foodCategoryEntity[index].imageUrl}',
                  onTap: () {
                    print("tapped");
                    Nav.to(FoodCategoryDetailsScreen.routeName,
                        arguments: [foodCategoryEntity[index], foodType]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 64.h,
              ),
               child: Column(
                children: [
                  _buildCategoryStyle2(),
                  space,
                  _buildCategoryStyle3(),
                  space,
                  _buildCategoryStyle1(),
                  space,
                  _buildCategoryStyle2(),
                  space,
                  _buildCategoryStyle2(),
                  space,
                  _buildCategoryStyle1(),
                  space,
                  _buildCategoryStyle2(),
                ],
              ),
            ),
          ),*/

/*
        ],
      ),
    );
  }*/

/* Widget _buildCategoryStyle1() {
    return Row(
      children: [
        Expanded(
          child: _buildCategoryCard(
            height: (width - space.width!) * 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryStyle2() {
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: _buildCategoryCard(),
          ),
        ),
        space,
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: _buildCategoryCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryStyle3() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 0.5,
            child: Column(
              children: [
                Expanded(
                  child: _buildCategoryCard(),
                ),
                space,
                Expanded(
                  child: _buildCategoryCard(),
                ),
              ],
            ),
          ),
        ),
        space,
        Expanded(
          child: AspectRatio(
            aspectRatio: 0.5,
            child: _buildCategoryCard(),
          ),
        ),
      ],
    );
  }

*/
/* Widget _buildCategoryCard({
    double? height,
    double? width,
  }) {
    return FoodCategoryCard(
      height: height,
      width: width,
      title: "Drinks",
      image: "assets/images/png/temp/food_category.png",
      onTap: () => Nav.to(FoodCategoryDetailsScreen.routeName),
    );
  }*/
