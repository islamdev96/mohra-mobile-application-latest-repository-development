import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/sorting_option_enum.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/single_category_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/bottom_sheet_product_filter.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_grid_view.dart';
import 'package:starter_application/generated/l10n.dart';

class SingleCategoryScreenContent extends StatefulWidget {
  @override
  State<SingleCategoryScreenContent> createState() =>
      _SingleCategoryScreenContentState();
}

class _SingleCategoryScreenContentState
    extends State<SingleCategoryScreenContent> {
  late SingleCategoryScreenNotifier sn;
  final padding = EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h);

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SingleCategoryScreenNotifier>(context);
    sn.context = context;
    return Container(
      color: AppColors.white,
      child: _buildProductGridView(),
    );
  }

  Widget _buildProductGridView() {
    return Container(
      height: 1.sh,
      child: Stack(
        children: [
          ProductGridView(
            products: sn.ProductInSupcategory!,
            sn: sn,
          ),
          if(sn.ProductInSupcategory!.length > 0) BuildFooter(sn: sn,)
        ],
      ),
    );
  }

  // _buildFooter() {
  //   return Positioned(
  //     bottom: 50.h,
  //     left: 0,
  //     right: 0,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 120.h,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(50),
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(
  //                     0.4,
  //                   ),
  //                   offset: const Offset(0, 2),
  //                   spreadRadius: 3,
  //                   blurRadius: 5,
  //                 ),
  //               ]),
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 20.w),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 InkWell(
  //                   onTap: () {
  //                     showBottomSheet(
  //                       context: context,
  //                       builder: (context) {
  //                         // context.watch<SingleCategoryScreenNotifier>();
  //                         return Column(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Gaps.vGap16,
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 SizedBox(
  //                                   width: 70.sp + Dimens.dp32.w,
  //                                 ),
  //                                 Text(
  //                                   Translation.current.sorting_by,
  //                                   style: TextStyle(
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 50.sp,
  //                                   ),
  //                                 ),
  //                                 Gaps.hGap32,
  //                                 InkWell(
  //                                   onTap: sn.onSortingOrderChanged,
  //                                   child: Icon(
  //                                     sn.sortingOrder == SortingOrder.ASC
  //                                         ? Icons.arrow_upward_outlined
  //                                         : Icons.arrow_downward_outlined,
  //                                     color: sn.sortingOrder == SortingOrder.ASC
  //                                         ? AppColors.greenColor
  //                                         : AppColors.redColor,
  //                                     size: 70.sp,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Gaps.vGap16,
  //                             LimitedBox(
  //                               maxHeight: SortingType.values.length * 0.05.sh,
  //                               child: ListView.separated(
  //                                 separatorBuilder: (context, index) {
  //                                   return Gaps.vGap16;
  //                                 },
  //                                 itemCount: SortingType.values.length,
  //                                 itemBuilder: (context, index) {
  //                                   return InkWell(
  //                                     onTap: () {
  //                                       sn.changeSorting(SortingType.values
  //                                           .elementAt(index));
  //                                       Nav.pop();
  //                                     },
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                       MainAxisAlignment.center,
  //                                       children: [
  //                                         SizedBox(
  //                                           width: 50.sp + Dimens.dp32.w,
  //                                         ),
  //                                         Text(
  //                                           getTranslatedSortingType(
  //                                               context,
  //                                               SortingType.values
  //                                                   .elementAt(index)),
  //                                           style: TextStyle(
  //                                               color: AppColors
  //                                                   .mansourBackArrowColor2,
  //                                               fontSize: 45.sp),
  //                                         ),
  //                                         Gaps.hGap32,
  //                                         Icon(
  //                                           Icons.done,
  //                                           color: sn.sorting?.index == index
  //                                               ? AppColors.greenColor
  //                                               : Colors.transparent,
  //                                           size: 50.sp,
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   );
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         );
  //                       },
  //                     );
  //                   },
  //                   child: Row(
  //                     children: [
  //                       SvgPicture.asset(AppConstants.SVG_SORT),
  //                       SizedBox(
  //                         width: 10.w,
  //                       ),
  //                       Text(
  //                         sn.sorting != null
  //                             ? getTranslatedSortingType(context, sn.sorting!)
  //                             : Translation.of(context).Sort,
  //                         style: TextStyle(
  //                             fontSize: 40.sp,
  //                             color: sn.sorting != null
  //                                 ? AppColors.primaryColorLight
  //                                 : Colors.grey),
  //                       ),
  //                       SizedBox(
  //                         width: 10.w,
  //                       ),
  //                       if (sn.sorting != null)
  //                         IconButton(
  //                           onPressed: sn.onSortingReset,
  //                           icon: SizedBox(
  //                             height: 55.h,
  //                             width: 55.h,
  //                             child: const Icon(
  //                               Icons.clear,
  //                               color: AppColors.accentColorLight,
  //                             ),
  //                           ),
  //                         )
  //                     ],
  //                   ),
  //                 ),
  //                 Gaps.hGap32,
  //                 VerticalDivider(
  //                   color: Colors.grey[500],
  //                   thickness: 2,
  //                   indent: 15,
  //                   endIndent: 15,
  //                 ),
  //                 Gaps.hGap32,
  //                 InkWell(
  //                   onTap: () {
  //                     bottomSheetProductFilter(
  //                       context: context,
  //                       data: sn.filterData,
  //                       onApplyTap: sn.onApplyFilterTap,
  //                     );
  //                   },
  //                   child: Row(
  //                     children: [
  //                       SvgPicture.asset(AppConstants.SVG_FILTER),
  //                       SizedBox(
  //                         width: 10.w,
  //                       ),
  //                       Text(
  //                         Translation.of(context).Filter,
  //                         style: TextStyle(fontSize: 40.sp, color: Colors.grey),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}


class BuildFooter extends StatefulWidget {
  final SingleCategoryScreenNotifier sn;
  const BuildFooter({Key? key,required this.sn}) : super(key: key);

  @override
  State<BuildFooter> createState() => _BuildFooterState();
}

class _BuildFooterState extends State<BuildFooter> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                      0.4,
                    ),
                    offset: const Offset(0, 2),
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          context.watch<SingleCategoryScreenNotifier>();
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Gaps.vGap16,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 70.sp + Dimens.dp32.w,
                                  ),
                                  Text(
                                    Translation.current.sorting_by,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50.sp,
                                    ),
                                  ),
                                  Gaps.hGap32,
                                  InkWell(
                                    onTap: widget.sn.onSortingOrderChanged,
                                    child: Icon(
                                      widget.sn.sortingOrder == SortingOrder.ASC
                                          ? Icons.arrow_upward_outlined
                                          : Icons.arrow_downward_outlined,
                                      color: widget.sn.sortingOrder == SortingOrder.ASC
                                          ? AppColors.greenColor
                                          : AppColors.redColor,
                                      size: 70.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.vGap16,
                              LimitedBox(
                                maxHeight: SortingType.values.length * 0.05.sh,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Gaps.vGap16;
                                  },
                                  itemCount: SortingType.values.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        widget.sn.changeSorting(SortingType.values
                                            .elementAt(index));
                                        Nav.pop();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 50.sp + Dimens.dp32.w,
                                          ),
                                          Text(
                                            getTranslatedSortingType(
                                                context,
                                                SortingType.values
                                                    .elementAt(index)),
                                            style: TextStyle(
                                                color: AppColors
                                                    .mansourBackArrowColor2,
                                                fontSize: 45.sp),
                                          ),
                                          Gaps.hGap32,
                                          Icon(
                                            Icons.done,
                                            color: widget.sn.sorting?.index == index
                                                ? AppColors.greenColor
                                                : Colors.transparent,
                                            size: 50.sp,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppConstants.SVG_SORT),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          widget.sn.sorting != null
                              ? getTranslatedSortingType(context, widget.sn.sorting!)
                              : Translation.of(context).Sort,
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: widget.sn.sorting != null
                                  ? AppColors.primaryColorLight
                                  : Colors.grey),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        if (widget.sn.sorting != null)
                          IconButton(
                            onPressed: widget.sn.onSortingReset,
                            icon: SizedBox(
                              height: 55.h,
                              width: 55.h,
                              child: const Icon(
                                Icons.clear,
                                color: AppColors.accentColorLight,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Gaps.hGap32,
                  VerticalDivider(
                    color: Colors.grey[500],
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Gaps.hGap32,
                  InkWell(
                    onTap: () {
                      bottomSheetProductFilter(
                        context: context,
                        data: widget.sn.filterData,
                        onApplyTap: widget.sn.onApplyFilterTap,
                        onChange: widget.sn.onFilterReset
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppConstants.SVG_FILTER),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          Translation.of(context).Filter,
                          style: TextStyle(fontSize: 40.sp, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        if (widget.sn.filter)
                          IconButton(
                            onPressed: widget.sn.onFilterReset,
                            icon: SizedBox(
                              height: 55.h,
                              width: 55.h,
                              child: const Icon(
                                Icons.clear,
                                color: AppColors.accentColorLight,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
