import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/presentation/screen/workout_details_screen.dart';

class OtherWorkouts extends StatelessWidget {
  final double height;
  final double itemWidth;
  const OtherWorkouts({
    Key? key,
    required this.height,
    required this.itemWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
          padding: AppConstants.screenPadding,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildCard(index);
          },
          separatorBuilder: (context, index) {
            return Gaps.hGap32;
          },
          itemCount: 5),
    );
  }

  Container _buildCard(int index) {
    return Container(
      height: height,
      width: itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
        color: Colors.black,
        image: const DecorationImage(
          image: AssetImage(
            "assets/images/png/temp/workout2.png",
          ),
          fit: BoxFit.contain,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Nav.to(WorkoutDetailsScreen.routeName),
            child: Padding(
              padding: EdgeInsets.all(
                50.w,
              ),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Body Challenge",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.vGap32,
                    Text(
                      "200 kcal | 20 minute",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
