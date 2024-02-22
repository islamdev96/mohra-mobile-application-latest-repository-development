import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/story_details_screen_params.dart';

import '../screen/../state_m/provider/my_life_video_screen_notifier.dart';
import 'my_life_video_screen_content.dart';

class MyLifeVideoScreen extends StatefulWidget {

  static const String routeName = "/MyLifeVideoScreen";

  const MyLifeVideoScreen({Key? key}) : super(key: key);

  @override
  _MyLifeVideoScreenState createState() => _MyLifeVideoScreenState();
}

class _MyLifeVideoScreenState extends State<MyLifeVideoScreen> {
  final sn = MyLifeVideoScreenNotifier();

  @override
  void initState() {
    sn.getStory();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyLifeVideoScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: InkWell(
              onTap: () {
                Nav.pop();
              },
              child:  Icon(
                AppConstants.getIconBack(),
                color: Colors.black,
              )),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppConstants.SVG_SHARE_FILL,
                    color: AppColors.black_text,
                    height: 50.h,
                    width: 50.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MyLifeVideoScreenContent(),
      ),
    );
  }
}
