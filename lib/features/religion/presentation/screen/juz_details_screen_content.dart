import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/juz_details_screen_notifier.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_page.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_text.dart';

import '../screen/../state_m/provider/surah_details_screen_notifier.dart';

class JuzDetailsScreenContent extends StatefulWidget {
  @override
  State<JuzDetailsScreenContent> createState() =>
      _JuzDetailsScreenContentState();
}

class _JuzDetailsScreenContentState extends State<JuzDetailsScreenContent> {
  late JuzDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<JuzDetailsScreenNotifier>(context);
    sn.context = context;
    if (sn.style == QuranStyle.ArabicClassic) return _buildClassicQuranPage();
    return Container();
    // return AyatList(
    //   padding: EdgeInsets.symmetric(
    //     vertical: 64.h,
    //   ),
    //   surahNum: sn.surah.num,
    //   ayat: sn.surah.ayat,
    //   selectedIndex: sn.selectedAyahIndex,
    //   style: sn.style,
    //   onTap: sn.onAyahTap,
    // );
  }

  Widget _buildClassicQuranPage() {
    return QuranPage(
      text: sn.juz,
      pageNum: 1,
      hideFooter: true,
      bottomSpace: 40.h,
    );
    return Column(
      children: [
        Gaps.vGap32,
        Expanded(
          child: Container(
            margin: AppConstants.screenPadding,
            child: Stack(
              children: [
                Positioned(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 80.w,
                    ),
                    child: Column(
                      children: [
                        Gaps.vGap96,
                        QuranText(
                          sn.juz,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 57.sp,
                            height: 2,
                          ),
                        ),
                        Gaps.vGap64,
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: IgnorePointer(
                    ignoring: true,
                    child: SizedBox(
                      width: 1.sw - AppConstants.hPadding * 2,
                      child: SvgPicture.asset(
                        AppConstants.SVG_QURAN_BORDER,
                        fit: BoxFit.fill,
                        color: AppColors.mansourPurple4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap256,
        Container(
          width: 1.sw,
          height: 200.h,
          padding: AppConstants.screenPadding,
          color: AppColors.mansourPurple4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Page 42",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45.sp,
                ),
              ),
              SizedBox(
                height: 70.h,
                child: SvgPicture.asset(
                  AppConfig().isLTR
                      ? AppConstants.SVG_ARROW_RIGHT
                      : AppConstants.SVG_ARROW_LEFT,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
