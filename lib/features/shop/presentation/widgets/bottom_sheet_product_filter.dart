import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';

void bottomSheetProductFilter(
    {BuildContext? context,
    required BottomSheetProductFilterData data,
      required Function onChange,
    required void Function(BottomSheetProductFilterData) onApplyTap}) {
  showModalBottomSheet(
      context: context!,
      isScrollControlled: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0.sp))),
      builder: (builder) {
        return BottomSheetProductFilter(
          initData: data,
          onApplyTap: onApplyTap,
        );
      });
}

class BottomSheetProductFilter extends StatefulWidget {
  final BottomSheetProductFilterData initData;
  final void Function(BottomSheetProductFilterData) onApplyTap;
  const BottomSheetProductFilter({
    Key? key,
    required this.initData,
    required this.onApplyTap,
  }) : super(key: key);
  @override
  _BottomSheetProductFilterState createState() =>
      _BottomSheetProductFilterState();
}

class _BottomSheetProductFilterState extends State<BottomSheetProductFilter> {
  late BottomSheetProductFilterData data;
  @override
  void initState() {
    super.initState();
    data = widget.initData;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gaps.vGap64,
          Text(
            Translation.current.advanced_filter,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 60.sp,
            ),
          ),
          _buildSlider(
            title: Translation.current.price,
            min: data.minPrice,
            max: data.maxPrice,
            start: data.startPrice ?? data.minPrice,
            end: data.endPrice ?? data.maxPrice,
            endLabel: (data.endPrice == data.maxPrice || data.endPrice == null)
                ? ">${data.maxPrice.toStringAsFixed(0)}"
                : null,
            divisions: 10,
            onChanged: (rangeValues) {
              setState(() {
                data = data.copyWith(
                  startPrice: rangeValues.start,
                  endPrice: rangeValues.end,
                );
              });
            },
            // startLabel: "Min Price",
            // endLabel: "Max Price",
          ),
          Gaps.vGap32,
          _buildSlider(
            title: Translation.current.rate,
            min: data.minRate,
            max: data.maxRate,
            start: data.startRate ?? data.minRate,
            end: data.endRate ?? data.maxRate,
            divisions: data.maxRate.toInt(),
            onChanged: (rangeValues) {
              setState(() {
                data = data.copyWith(
                  startRate: rangeValues.start,
                  endRate: rangeValues.end,
                );
              });
            },
            // startLabel: "Min Rate",
            // endLabel: "Max Rate",
          ),
          Gaps.vGap32,
          _buildSlider(
            title: Translation.current.requests_count,
            min: data.minRequests.toDouble(),
            max: data.maxRequests.toDouble(),
            start:
                data.startRequests?.toDouble() ?? data.minRequests.toDouble(),
            end: data.endRequests?.toDouble() ?? data.maxRequests.toDouble(),
            endLabel: (data.endRequests == data.maxRequests ||
                    data.endRequests == null)
                ? ">${data.maxRequests.toStringAsFixed(0)}"
                : null,
            divisions: 10,
            onChanged: (rangeValues) {
              setState(() {
                data = data.copyWith(
                  startRequests: rangeValues.start.toInt(),
                  endRequests: rangeValues.end.toInt(),
                );
              });
            },
            // startLabel: "Min Requests Count",
            // endLabel: "Max Requests Count",
          ),
          Gaps.vGap32,
          _buildSlider(
            title: Translation.current.sales_count,
            min: data.minSales.toDouble(),
            max: data.maxSales.toDouble(),
            start: data.startSales?.toDouble() ?? data.minSales.toDouble(),
            end: data.endSales?.toDouble() ?? data.maxSales.toDouble(),
            endLabel: (data.endSales == data.maxSales || data.endSales == null)
                ? ">${data.maxSales.toStringAsFixed(0)}"
                : null,
            divisions: 10,
            onChanged: (rangeValues) {
              setState(() {
                data = data.copyWith(
                  startSales: rangeValues.start.toInt(),
                  endSales: rangeValues.end.toInt(),
                );
              });
            },
            // startLabel: "Min Sales Count",
            // endLabel: "Max Sales Count",
          ),
          Gaps.vGap32,
          _buildSlider(
            title: Translation.current.year,
            min: data.minYearOffset.toDouble(),
            max: data.maxYearOffset.toDouble(),
            start: data.startYearOffset?.toDouble() ??
                data.minYearOffset.toDouble(),
            end:
                data.endYearOffset?.toDouble() ?? data.maxYearOffset.toDouble(),
            divisions: data.maxYearOffset,
            startLabel:
                "${(data.firstYear + (data.startYearOffset?.toDouble() ?? data.minYearOffset)).toStringAsFixed(0)}",
            endLabel:
                "${(data.firstYear + (data.endYearOffset?.toDouble() ?? data.maxYearOffset)).toStringAsFixed(0)}",
            onChanged: (rangeValues) {
              setState(() {
                data = data.copyWith(
                  startYearOffset: rangeValues.start.toInt(),
                  endYearOffset: rangeValues.end.toInt(),
                );
              });
            },
            // startLabel: "Min Year",
            // endLabel: "Max Year",
          ),
          Gaps.vGap64,
          SizedBox(
            width: 0.5.sw,
            child: MaterialButton(
              onPressed: _onApplyTap,
              padding: EdgeInsets.symmetric(
                vertical: 40.h,
              ),
              color: AppColors.primaryColorLight,
              child: Text(
                Translation.current.apply,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                ),
              ),
            ),
          ),
          Gaps.vGap64,
        ],
      ),
    );
  }

  Widget _buildSlider(
      {required String title,
      String? startLabel,
      String? endLabel,
      required double start,
      required double end,
      required double min,
      required double max,
      required int? divisions,
      required void Function(RangeValues rangeValues) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 50.sp,
          ),
        ),
        Gaps.vGap24,
        SliderTheme(
          data: SliderThemeData(
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 0,
            ),
            trackHeight: 20.h,
            activeTrackColor: AppColors.primaryColorLight,
            thumbColor: AppColors.primaryColorLight,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 35.sp,
            ),
          ),
          child: RangeSlider(
            values: RangeValues(start, end),
            onChanged: onChanged,
            min: min,
            max: max,
            divisions: divisions,
            labels: RangeLabels("${startLabel ?? start.toStringAsFixed(0)}",
                "${endLabel ?? end.toStringAsFixed(0)}"),
          ),
        ),
      ],
    );
  }

  void _onApplyTap() {
    widget.onApplyTap(data);
    Nav.pop();
  }
}

class BottomSheetProductFilterData {
  final double? startPrice;
  final double? endPrice;
  final double minPrice;
  final double maxPrice;
  final double? startRate;
  final double? endRate;
  final double minRate;
  final double maxRate;
  final int? startRequests;
  final int? endRequests;
  final int minRequests;
  final int maxRequests;
  final int? startSales;
  final int? endSales;
  final int minSales;
  final int maxSales;
  final int? startYearOffset;
  final int? endYearOffset;
  final int minYearOffset;
  final int maxYearOffset;
  final int firstYear;
  BottomSheetProductFilterData({
    this.startPrice,
    this.endPrice,
    this.startRate,
    this.endRate,
    this.startRequests,
    this.endRequests,
    this.startSales,
    this.endSales,
    this.startYearOffset,
    this.endYearOffset,
    required this.minPrice,
    required this.maxPrice,
    required this.minRate,
    required this.maxRate,
    required this.minRequests,
    required this.maxRequests,
    required this.minSales,
    required this.maxSales,
    required this.minYearOffset,
    required this.maxYearOffset,
    required this.firstYear,
  });

  BottomSheetProductFilterData copyWith({
    double? startPrice,
    double? endPrice,
    double? minPrice,
    double? maxPrice,
    double? startRate,
    double? endRate,
    double? minRate,
    double? maxRate,
    int? startRequests,
    int? endRequests,
    int? minRequests,
    int? maxRequests,
    int? startSales,
    int? endSales,
    int? minSales,
    int? maxSales,
    int? startYearOffset,
    int? endYearOffset,
    int? minYearOffset,
    int? maxYearOffset,
    int? firstYear,
  }) {
    return BottomSheetProductFilterData(
      startPrice: startPrice ?? this.startPrice,
      endPrice: endPrice ?? this.endPrice,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      startRate: startRate ?? this.startRate,
      endRate: endRate ?? this.endRate,
      minRate: minRate ?? this.minRate,
      maxRate: maxRate ?? this.maxRate,
      startRequests: startRequests ?? this.startRequests,
      endRequests: endRequests ?? this.endRequests,
      minRequests: minRequests ?? this.minRequests,
      maxRequests: maxRequests ?? this.maxRequests,
      startSales: startSales ?? this.startSales,
      endSales: endSales ?? this.endSales,
      minSales: minSales ?? this.minSales,
      maxSales: maxSales ?? this.maxSales,
      startYearOffset: startYearOffset ?? this.startYearOffset,
      endYearOffset: endYearOffset ?? this.endYearOffset,
      minYearOffset: minYearOffset ?? this.minYearOffset,
      maxYearOffset: maxYearOffset ?? this.maxYearOffset,
      firstYear: firstYear ?? this.firstYear,
    );
  }
}
