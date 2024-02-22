import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

//Todo Refactoring
//Todo instead of providing space and vPadding we should provide height and adapt to it
//Todo make values double
class ScaleRuler extends StatefulWidget {
  final int? totalValueWeight;
  final int? totalValueHeight;
  final int stepValue;
  final int miniStepCounts;
  final double space;
  final double currentValue;
  final double stepThikness;

  final Duration duration;
  final Curve curve;
  final bool isHeight;

  ScaleRuler({
    Key? key,
    this.totalValueWeight,
    required this.isHeight,
    this.totalValueHeight,
    this.stepValue = 10,
    this.miniStepCounts = 5,
    this.space = 2,
    this.currentValue = 180,
    this.stepThikness = 1,
    double? vPadding,
    double? hPadding,
    double? majorStepLenght,
    double? smallStepLenght,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
  }) : super(key: key) {
    _vPadding = vPadding ?? 30.h;
    _hPadding = hPadding ?? 20.w;
    stepsCounts = ((isHeight ? totalValueHeight : totalValueWeight)! / stepValue).floor();
    // totalHeight =
    //     (stepsCounts * miniStepCounts * space * stepThikness) + (_vPadding * 2);
    totalHeight = (stepsCounts * miniStepCounts) * (space + stepThikness) +
        (_vPadding * 2);
    _majorStepLenght = majorStepLenght ?? 20.w;
    _smallStepLenght = smallStepLenght ?? 10.w;
    totalWidth = _majorStepLenght + _hPadding;
  }

  late final int stepsCounts;
  late final double totalHeight;
  late final double totalWidth;
  late final double _vPadding;
  late final double _hPadding;
  late final double _majorStepLenght;
  late final double _smallStepLenght;

  @override
  State<ScaleRuler> createState() => ScaleRulerState();
}

class ScaleRulerState extends State<ScaleRuler> {
  double get getCurrentValueLocaitonOnRuler =>
      getValueLocationOnRuler(widget.currentValue.toDouble());

  double getValueLocationOnRuler(double value) {
    return widget._vPadding +
        ((value / widget.stepValue) * widget.miniStepCounts) *
            (widget.space + widget.stepThikness);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.totalHeight,
      width: widget.totalWidth,
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              height: getCurrentValueLocaitonOnRuler,
              width: widget.totalWidth,
              duration: widget.duration,
              curve: widget.curve,
              decoration: BoxDecoration(
                color: AppColors.mansourDarkGreenColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    50.r,
                  ),
                  bottomRight: Radius.circular(
                    50.r,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:
                List.generate(widget.stepsCounts, (index) => _buildFullStep())
                    .toList(),
          ),
          Positioned(
            child: Container(
              height: widget.totalHeight,
              width: widget.totalWidth,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(
                  50.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullStep() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
            widget.miniStepCounts, (index) => _buildMiniStep(index)).toList());
  }

  Widget _buildMiniStep(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.space),
      width: index == 0 ? widget._majorStepLenght : widget._smallStepLenght,
      height: widget.stepThikness,
      color: Colors.black,
    );
  }
}
