import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodCategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final double? height;
  final double? width;
  final Function() onTap;

  const FoodCategoryCard(
      {Key? key,
      required this.title,
      required this.image,
      this.height,
      this.width,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$image",
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.r),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),

            ),
            Container(
              height: height,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(35.r)
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage("assets/images/png/temp/food_category.png"),
                fit: BoxFit.cover,
              )),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 30.w,
                bottom: 40.h,
              ),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp,
                  ),
                ),
              ),
            ),
          )),
    );

    /*return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 30.w,
              bottom: 40.h,
            ),
            child: Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}
