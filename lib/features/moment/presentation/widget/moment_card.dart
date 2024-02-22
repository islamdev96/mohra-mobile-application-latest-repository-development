import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/app.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class MomentCard extends StatelessWidget {
  final double vLineStart;
  final double vLineWidth;
  final Widget indicator;
  final Widget content;
  final double indicatorWidth;
  const MomentCard({
    Key? key,
    required this.vLineStart,
    required this.vLineWidth,
    required this.indicator,
    required this.content,
    required this.indicatorWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMomentCard();
  }

  Widget _buildMomentCard() {
    return SizedBox(
      width: 1.sw,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: (vLineStart  + vLineWidth * 0.5) - (indicatorWidth * (AppConfig().isLTR ? 0.5 :0.59)),
          ),
          indicator,
          Gaps.hGap32,
          Expanded(
            child: content,
          ),
        ],
      ),
    );
  }
}
