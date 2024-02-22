import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/mylife/presentation/state_m/provider/dream_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
class IconPickerBottomSheet extends StatefulWidget {
  final List<String> imageList;

  final DreamScreenNotifier sn;
  List<bool> selected = [];

  IconPickerBottomSheet({
    required this.imageList,
    required this.sn,
  }) {
    selected = List.generate(imageList.length, (index) => false);
  }

  @override
  State<IconPickerBottomSheet> createState() => _IconPickerBottomSheetState();
}

class _IconPickerBottomSheetState extends State<IconPickerBottomSheet> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8.sh,
      padding: EdgeInsets.only(
        left: 70.h,
        right: 70.h,
        top: 70.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.r,
          ),
        ),
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_CLOSE,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                Translation.current.dream_icon,
                style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_text),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: SvgPicture.asset(
                    'assets/images/svg/checkmark.svg',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Gaps.vGap8,
          const Divider(
            height: 2,
            thickness: 0.5,
            color: AppColors.text_gray,
          ),
          Gaps.vGap32,
          Center(
            child: Text(
              Translation.current.select_dream_icon,
              style: TextStyle(fontSize: 35.sp, color: AppColors.text_gray),
            ),
          ),
          Gaps.vGap32,
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: widget.imageList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  tapped = true;
                  widget.sn.selectedIconDream = index;
                  widget.sn.addDreamColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0);
                  widget.selected = List.generate(
                      widget.imageList.length, (index) => false);
                  setState(() {
                    widget.selected[index] = true;
                  });
                  Navigator.pop(context);
                },
                child: Center(
                  child: ImageIcon(
                    AssetImage(widget.imageList[index]),
                    color: widget.selected[index]
                        ? widget.sn.addDreamColor
                        : AppColors.black,
                    size: 100.w,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
