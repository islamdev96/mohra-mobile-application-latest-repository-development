import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/health/presentation/widget/scale_ruler.dart';
import 'package:starter_application/generated/l10n.dart';

//Todo refactor this widget and use stack instead of rows and columns,
//Todo to reduce the number of equtions and simplify the code
class HeightWeightMeters extends StatefulWidget {
  final double width;
  final double personHeight;
  final double perosonWeight;
  final double rulerSpace;
  final int rulerMiniStepCounts;
  final double rulerStepThikness;
  final int rulerStepValue;
  final int rulerMaxValueHeight;
  final int rulerMaxValueWeight;
  final int gender;

  HeightWeightMeters({
    Key? key,
    this.width = 200,
    required this.rulerMaxValueHeight,
    required this.rulerMaxValueWeight,
    required this.personHeight,
    required this.perosonWeight,
    required this.gender,
    double? rulerVPadding,
    this.rulerMiniStepCounts = 5,
    this.rulerSpace = 2,
    this.rulerStepThikness = 1,
    this.rulerStepValue = 10,
    double? rulerHPadding,
    double? rulerMajorStepLenght,
  }) : super(key: key) {
    _rulerVPadding = rulerVPadding ?? 30.h;
    _rulerHPadding = 20.w;
    _rulerMajorStepLenght = rulerMajorStepLenght ?? 20.w;
    _rulerTotalWidth = _rulerMajorStepLenght + _rulerHPadding;
  }

  late final double _rulerVPadding;
  late final double _rulerHPadding;
  late final double _rulerMajorStepLenght;
  late final double _rulerTotalWidth;

  @override
  State<HeightWeightMeters> createState() => _HeightWeightMetersState();
}

class _HeightWeightMetersState extends State<HeightWeightMeters> {
  /// For Animation
  double? heightLineWidth = 0;
  double personHeight = 0;
  double personHeightOpacity = 0;
  double personWeight = 0;
  double personWeightOpacity = 0;

  Duration subAnimationDuration = const Duration(milliseconds: 300);

  final TextStyle titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 35.sp,
    fontFamily: AppConfig().appLanguage!.startsWith(AppConstants.LANG_EN)
        ? GoogleFonts.poppins().fontFamily
        : GoogleFonts.cairo().fontFamily,
  );
  late final Size titleSize;
  //! This is used to Center the rulers titles with the rulers
  late final contentHPadding;

  @override
  void initState() {
    super.initState();
    titleSize = textSize(
      Translation.current.weight,
      titleStyle,
      maxLines: 1,
    );
    contentHPadding = titleSize.width * 0.5 - widget._rulerTotalWidth * 0.5;

    /// Animation
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      setState(() {
        personHeight = widget.personHeight;
      });
      await Future.delayed(subAnimationDuration).then((value) async {
        setState(() {
          heightLineWidth = null;
        });
        await Future.delayed(subAnimationDuration).then((value) async {
          setState(() {
            personHeightOpacity = 1;
          });
          await Future.delayed(subAnimationDuration).then((value) async {
            setState(() {
              personWeight = widget.perosonWeight;
            });
            await Future.delayed(subAnimationDuration).then((value) {});
            setState(() {
              personWeightOpacity = 1;
            });
          });
        });
      });
    });
  }

  double get personHeightLocationOnRuler =>
      getValueLocationOnRuler(widget.personHeight.toDouble());
  double get personWeightLocationOnRuler =>
      getValueLocationOnRuler(widget.perosonWeight.toDouble());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMainContent(),
          Gaps.vGap24,
          _buildRulersTitles(),
        ],
      ),
    );
  }

  Row _buildRulersTitles() {
    return Row(
      children: [
        Text(
          Translation.current.weight,
          style: titleStyle,
        ),
        const Spacer(),
        Text(
          Translation.current.height,
          style: titleStyle,
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SizedBox(
      width: widget.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: contentHPadding,
          ),

          /// Weight height ruler
          _buildRuler(
            personWeight,isHeight: false
          ),
          _buildPersonWeightInfo(),
          SizedBox(
            height: personHeightLocationOnRuler,
            child: SizedBox(
              height: personHeightLocationOnRuler - 10.h,
              width: 150.w,
              child: Image.asset(
                widget.gender == 0 ?
                AppConstants.IMG_HEALTH_FEMALE_BODY_SPECTS :AppConstants.IMG_HEALTH_MALE_BODY_SPECTS ,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          _buildPersonHeightInfo(),

          /// Person height ruler
          _buildRuler(
            personHeight,isHeight: true
          ),
          SizedBox(
            width: contentHPadding,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonWeightInfo() {
    return Expanded(
      child: SizedBox(
        height: personWeightLocationOnRuler,
        child: Align(
          alignment: AlignmentDirectional.topCenter,
          child: AnimatedOpacity(
            opacity: personWeightOpacity,
            duration: subAnimationDuration,
            child: Text(
              "${widget.perosonWeight} kg",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonHeightInfo() {
    return Expanded(
      child: SizedBox(
        height: personHeightLocationOnRuler,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedSize(
              duration: subAnimationDuration,
              curve: Curves.easeOut,
              child: Container(
                color: Colors.black,
                height: 3.h,
                width: heightLineWidth,
              ),
            ),
            Gaps.vGap24,
            Center(
              child: AnimatedOpacity(
                opacity: personHeightOpacity,
                duration: subAnimationDuration,
                child: Text(
                  "${widget.personHeight} cm",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRuler(
      double currentValue, {bool isHeight = true}) {
    return ScaleRuler(
      duration: subAnimationDuration,
      curve: Curves.easeOut,
      space: widget.rulerSpace,
      miniStepCounts: widget.rulerMiniStepCounts,
      stepThikness: widget.rulerStepThikness,
      stepValue: widget.rulerStepValue,
      vPadding: widget._rulerVPadding,
      majorStepLenght: widget._rulerMajorStepLenght,
      hPadding: widget._rulerHPadding,
      totalValueHeight: widget.rulerMaxValueHeight,
      totalValueWeight: widget.rulerMaxValueWeight,
      currentValue: currentValue,
      isHeight: isHeight,
    );
  }

  double getValueLocationOnRuler(double value) {
    return widget._rulerVPadding +
        ((value / widget.rulerStepValue) * widget.rulerMiniStepCounts) *
            (widget.rulerSpace + widget.rulerStepThikness);
  }
}
