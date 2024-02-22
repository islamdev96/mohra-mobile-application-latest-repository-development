import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/features/shop/presentation/widgets/custom_shop_app_bar.dart';
import '../screen/../state_m/provider/create_event_screen_notifier.dart';

class CreateEventScreenContent extends StatefulWidget {
  @override
  State<CreateEventScreenContent> createState() =>
      _CreateEventScreenContentState();
}

class _CreateEventScreenContentState extends State<CreateEventScreenContent> {
  late CreateEventScreenNotifier sn;
  double HeaderHeight = 0.20.sh;
  double ContentHeight = 0.13.sh;
  final double radius = 120.r;
  final EdgeInsets padding =
      EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h);
  final EdgeInsets hpadding =
      EdgeInsets.only(left: 40.w, right: 40.w, top: 40.h);
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      35.r,
    ),
    borderSide: const BorderSide(
      color: AppColors.mansourLightGreyColor_8,
    ),
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CreateEventScreenNotifier>(context);
    sn.context = context;
    return Stack(
      children: [_buildHeader(), _buildContent()],
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      child: Container(
        width: 1.sw,
        height: HeaderHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35.r),
            bottomLeft: Radius.circular(35.r),
          ),
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: AppColors.MessageOrangeGradiant,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gaps.vGap64,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Nav.pop(),
                        icon: Icon(
                          AppConstants.getIconBack(),
                          color: AppColors.white,
                          size: 75.sp,
                        ),
                      ),
                      Text(
                        "Select Chat",
                        style: TextStyle(
                            fontSize: 50.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: ShopSearchTextField(
                  hint: "Search",
                  suffix: IconButton(
                    icon:  Icon(
                      AppConstants.getIconBack(),
                      color: AppColors.primaryColorLight,
                    ),
                    onPressed: () {
                      // sn.search();
                    },
                  ),
                  hintSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned.fill(
        top: ContentHeight + 100.h,
        left: 0.0,
        right: 0.0,
        child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
            color: AppColors.mansourLightGreyColor_4,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
                blurRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWheelItem(
                  title: "New Chat",
                  icon: AppConstants.SVG_MESSAGE,
                  onTap: () {},
                ),
                Gaps.vGap32,
                Padding(
                  padding: padding,
                  child: Text(
                    "Recent Chat",
                    style: TextStyle(
                        fontSize: 35.sp,
                        color: AppColors.mansourLightGreyColor_11),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: sn.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildMessageItem(
                        index,
                        sn.messages[index].image,
                        sn.messages[index].name,
                        sn.messages[index].date,
                        sn.messages[index].message,
                        sn.messages[index].numNotRead,
                        sn.messages[index].isRead,
                        sn.messages[index].isSelected, () {
                      sn.navEventScreen2();
                    });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Gaps.vGap8;
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildWheelItem({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 120.h,
                  width: 120.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColorLight,
                    shape: BoxShape.circle,
                  ),
                  child: LayoutBuilder(builder: (context, cons) {
                    return InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: onTap,
                      child: Center(
                        child: SizedBox(
                          height: 80.h,
                          width: 80.h,
                          child: SvgPicture.asset(
                            icon,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                Gaps.hGap32,
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    );
  }

  _buildMessageItem(
    int index,
    String image,
    String name,
    String date,
    String message,
    String numNotRead,
    bool isRead,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.hGap64,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
