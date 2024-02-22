import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/presentation/screen/workout_details_screen.dart';

class WorkoutRecommendationsCard extends StatelessWidget {
  final String imageUrl;
  final String title, heroTag;
  final double? calories;
  final int? time;
  final Function() onTap;

  WorkoutRecommendationsCard({
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.calories,
    required this.onTap,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    print('sddddddd');

    print(imageUrl);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Hero(
            tag: '$heroTag',
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: 550.h,
                width: double.infinity,
                imageUrl: "$imageUrl",
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) => Icon(Icons.error)),
          ),
          Container(
            height: 550.h,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(35.r),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.vGap24,
                  Text(
                    "$calories kcal | $time minute",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return Container(
      height: 100.h,
      width: double.infinity,
      child: CachedNetworkImage(
        height: 100.h,
        width: double.infinity,
        imageUrl: "$imageUrl",
        imageBuilder: (context, imageProvider) => Stack(
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage(
                    "$imageUrl",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
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
                            "$title}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.vGap32,
                          Text(
                            "$calories kcal | $time minute",
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
            )
          ],
        ),
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator.adaptive()),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage("assets/images/png/temp/workout2.png"),
                fit: BoxFit.cover,
              )),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
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
                        "$title}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.vGap32,
                      Text(
                        "$calories kcal | $time minute",
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
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(
            "$imageUrl",
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
                      "$title}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.vGap32,
                    Text(
                      "$calories kcal | $time minute",
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
