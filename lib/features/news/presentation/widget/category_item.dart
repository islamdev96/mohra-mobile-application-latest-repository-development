import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../../../../main.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
      required this.image,
      required this.name,
      required this.onPress})
      : super(key: key);
  final String name;
  final String image;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 300.w,
        height: 300.w,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          image: (image != "string" && image.isNotEmpty)
              ? DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                  fit: BoxFit.fill,
                )
              : const DecorationImage(
                  image: AssetImage(
                    AppConstants.NO_IMAGE_NULL,
                  ),
                  fit: BoxFit.fill,
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.23.sw,
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.vGap32,
          ],
        ),
      ),
    );
  }
}
