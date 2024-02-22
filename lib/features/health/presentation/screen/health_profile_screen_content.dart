import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/health/presentation/widget/profile/health_height_weight_card.dart';
import 'package:starter_application/features/health/presentation/widget/profile/user_information_card.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/health_profile_screen_notifier.dart';

class HealthProfileScreenContent extends StatelessWidget {
  late HealthProfileScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HealthProfileScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Container(
              width: 1.sw,
              height: 0.1.sh,
              child: Center(
                child: ProfilePic(
                  width: 0.3.sw,
                  height: 0.1.sh,
                  imageUrl: UserSessionDataModel.imageUrl ?? null,
                ),
              ),
            ),
          ),
          Gaps.vGap24,
          UserInformationCard(
            width: 0.9.sw,
            firstName: '${UserSessionDataModel.name}',
            lastName: '${UserSessionDataModel.surname}',
            dateOfBirth: '${HealthProfileStaticModel.BIRTH_DAY}',
            sex: HealthProfileStaticModel.GENDER == 0
                ? Translation.current.female
                : Translation.current.male,
            medicalCondition: HealthProfileStaticModel.HEALTH_SITUATION == 0
                ? Translation.current.healthy
                : HealthProfileStaticModel.HEALTH_SITUATION == 1
                    ? Translation.current.very_healthy
                    : Translation.current.normal,
          ),
          Gaps.vGap24,
          WeightHeightCard(
            width: .9.sw,
            cardKey: Translation.current.height,
            cardUnit: 'cm',
            cardValue: '${HealthProfileStaticModel.LENGTH}',
          ),
          Gaps.vGap24,
          WeightHeightCard(
            width: .9.sw,
            cardKey: Translation.current.weight,
            cardUnit: 'kg',
            cardValue: '${HealthProfileStaticModel.WEIGHT}',
          ),
          Container(
            width: .9.sw,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translation.current.ideal,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gaps.vGap4,
                        Text(
                          Translation.current.your_bmi,
                          style: const TextStyle(
                            color: Color(0xff8F9BB3),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap24,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${HealthProfileStaticModel.MIN_WEIGHT}- ${HealthProfileStaticModel.MAX_WEIGHT} kg',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gaps.vGap4,
                        Text(
                          Translation.current.recommended_weight,
                          style: const TextStyle(
                            color: Color(0xff8F9BB3),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 250.h,
                  width: 250.w,
                  child: Stack(
                    children: [
                      Container(
                        height: 250.h,
                        width: 250.w,
                        child: CustomPaint(
                          painter: RingPainter(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${HealthProfileStaticModel.BMI}',
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 65.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    //Paint to draw ring shape
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 16.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //defining Center of Box
    Offset center = Offset(width / 2, height / 2);
    //defining radius
    double radius = min(width / 2, height / 2);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
