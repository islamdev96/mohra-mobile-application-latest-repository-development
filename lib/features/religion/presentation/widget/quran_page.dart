import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_text.dart';

class QuranPage extends StatelessWidget {
  final String text;
  final int pageNum;
  final double? bottomSpace;
  final String? pageName;
  final String? titleImage;
  final String? title;
  final bool hideNextButton;
  final bool hidBackButton;
  final VoidCallback? onBackTap;
  final VoidCallback? onNextTap;
  final ScrollController? controller;
  final bool showPageNum;
  final bool hideFooter;

  const QuranPage({
    Key? key,
    required this.text,
    required this.pageNum,
    this.titleImage,
    this.title,
    this.bottomSpace,
    this.pageName,
    this.hideNextButton = false,
    this.hidBackButton = false,
    this.onBackTap,
    this.onNextTap,
    this.controller,
    this.showPageNum = true,
    this.hideFooter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildClassicQuranPage();
  }

  Widget _buildClassicQuranPage() {
    return GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (!hideFooter) {
            if (dragEndDetails.primaryVelocity! < 0) {
              if (!hidBackButton)
                onBackTap!();
            } else if (dragEndDetails.primaryVelocity! > 0) {
              if (!hideNextButton)
                onNextTap!();
            }
          }
        },
      child: Column(
        children: [
          Gaps.vGap32,
          Expanded(
            child: Container(
              margin: AppConstants.screenPadding,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned.fill(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: SizedBox(
                      width: 1.sw - AppConstants.hPadding * 2,
                      child: SvgPicture.asset(
                        AppConstants.SVG_QURAN_BORDER,
                        fit: BoxFit.fill,
                        color: AppColors.mansourPurple4,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Column(
                      children: [
                        Gaps.vGap64,
                        Expanded(
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowIndicator();
                              return false;
                            },
                            child: SingleChildScrollView(
                              controller: controller,
                              padding: EdgeInsets.symmetric(
                                horizontal: 80.w,
                              ),
                              child: Column(
                                children: [
                                  if (titleImage != null || title != null)
                                    Container(
                                      width: 1.sw,
                                      height: 150.h,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.mansourPurple4.withOpacity(
                                          0.05,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: titleImage != null
                                            ? SizedBox(
                                                height: 100.h,
                                                child: Image.asset(
                                                  titleImage!,
                                                ),
                                              )
                                            : QuranText(
                                                title!,
                                                style: TextStyle(
                                                  color: AppColors.mansourPurple4,
                                                  fontSize: 70.sp,
                                                ),
                                                strutStyle: const StrutStyle(
                                                  forceStrutHeight: true,
                                                ),
                                              ),
                                      ),
                                    ),
                                  if (titleImage != null) Gaps.vGap64,
                                  QuranText(
                                    text,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 57.sp,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gaps.vGap64,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (!hideFooter)
            Container(
              width: 1.sw,
              height: 150.h,
              padding: AppConstants.screenPadding,
              color: AppColors.mansourPurple4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${pageName ?? "Page"} ${showPageNum ? pageNum : ""}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45.sp,
                    ),
                  ),
                  Row(
                    children: [
                      if (!hidBackButton)
                        InkWell(
                          onTap: onBackTap,
                          child: SizedBox(
                            height: 70.h,
                            child: SvgPicture.asset(
                              AppConfig().isLTR
                                  ? AppConstants.SVG_ARROW_LEFT
                                  : AppConstants.SVG_ARROW_RIGHT,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      if (!hidBackButton && !hideNextButton) Gaps.hGap64,
                      if (!hideNextButton)
                        InkWell(
                          onTap: onNextTap,
                          child: SizedBox(
                            height: 70.h,
                            child: SvgPicture.asset(
                              AppConfig().isLTR
                                  ? AppConstants.SVG_ARROW_RIGHT
                                  : AppConstants.SVG_ARROW_LEFT,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
