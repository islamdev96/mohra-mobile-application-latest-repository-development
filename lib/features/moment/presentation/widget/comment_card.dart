
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';


class CommentCard extends StatelessWidget {
  String username, date, comment ;
  double width, height;
  String? imageUrl;
  CommentCard(
      {Key? key,
      required this.date,
      required this.comment,
      required this.username,
      required this.width,
      required this.imageUrl,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.05),
                offset: Offset(0, 0),
                blurRadius: 1,
                spreadRadius: 2),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePic(
              width: .2 * width,
              height: .2 * width,
              imageUrl: imageUrl,
            ),
            Gaps.hGap16,
            SizedBox(
              width: .75 * width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(username , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                    color: AppColors.black,
                  ),),

                  Gaps.vGap10,
                  SizedBox(
                      child: Text(comment,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.sp,
                        color: AppColors.text_gray,
                      ),)),
                  Gaps.vGap10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(date),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
