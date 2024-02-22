import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/generated/l10n.dart';

void AddMyDreamBottomSheet({
  required BuildContext context,
  required String title,
  required VoidCallback onNav,
  required VoidCallback OnAddDreamTap,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheet(
        builder: (BuildContext context) {
          return AnimatedPadding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            duration: const Duration(milliseconds: 300),
            child: MyDreamBottomSheet(
                onPress: onNav,
                title: title,
                OnAddDreamTap: () {
                  OnAddDreamTap();
                }),
          );
        },
        onClosing: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              40.r,
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 1.sh,
        ),
      );
    },
    isScrollControlled: true,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          40.r,
        ),
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: 1.sh,
    ),
  );
}

class MyDreamBottomSheet extends StatefulWidget {
  final VoidCallback onPress;
  final VoidCallback OnAddDreamTap;
  final String title;

  const MyDreamBottomSheet(
      {Key? key,
      required this.onPress,
      required this.title,
      required this.OnAddDreamTap})
      : super(key: key);

  @override
  State<MyDreamBottomSheet> createState() => _MyDreamBottomSheetState();
}

class _MyDreamBottomSheetState extends State<MyDreamBottomSheet> {
  bool canAddStep = false;
  bool steps = false;

  Icon? _icon;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [IconPack.cupertino],
    );

    _icon = Icon(icon);
    setState(() {});
  }

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      20.r,
    ),
    borderSide: BorderSide(
      color: Colors.grey[200]!,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.6.sh,
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
      child: Column(
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
                widget.title,
                style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_text),
              ),
              Gaps.hGap64,
            ],
          ),
          Gaps.vGap64,
          Row(
            children: [
              Gaps.hGap15,
              SizedBox(
                height: 70.h,
                width: 70.h,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                          builder: (BuildContext context) {
                            return AnimatedPadding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              duration: const Duration(milliseconds: 300),
                              child: IconsBottomSheet(
                                onPress: () {},
                                title: "",
                              ),
                            );
                          },
                          onClosing: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                40.r,
                              ),
                            ),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: 1.sh,
                          ),
                        );
                      },
                      isScrollControlled: true,
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            40.r,
                          ),
                        ),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: 1.sh,
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    AppConstants.SVG_CAMERA,
                    color: AppColors.text_gray,
                  ),
                ),
              ),
              Gaps.hGap32,
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black_text,
                      fontSize: 45.sp),
                  decoration: InputDecoration(
                    hintText: Translation.current.dream_title_hint,
                    hintStyle:
                        TextStyle(fontSize: 40.sp, color: AppColors.textLight2),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  inputFormatters: [],
                  onChanged: (value) {
                    setState(() {
                      canAddStep = true;
                    });
                  },
                ),
              ),
            ],
          ),
          Gaps.vGap32,
          Visibility(
              visible: steps,
              child: Padding(
                padding: EdgeInsets.only(left: 100.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                2 != 2
                                    ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                    : AppConstants.SVG_RADIO_BUTTON_OFF,
                                color: 2 != 2
                                    ? AppColors.primaryColorLight
                                    : AppColors.accentColorLight,
                              ),
                              Gaps.hGap32,
                              Text(
                                "${Translation.current.step} 1 ${Translation.current.name}",
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_text),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                            width: 60.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_CLOSE,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                2 != 2
                                    ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                    : AppConstants.SVG_RADIO_BUTTON_OFF,
                                color: 2 != 2
                                    ? AppColors.primaryColorLight
                                    : AppColors.accentColorLight,
                              ),
                              Gaps.hGap32,
                              Text(
                                "${Translation.current.step} 2 ${Translation.current.name}",
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_text),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                            width: 60.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_CLOSE,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                2 != 2
                                    ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                    : AppConstants.SVG_RADIO_BUTTON_OFF,
                                color: 2 != 2
                                    ? AppColors.primaryColorLight
                                    : AppColors.accentColorLight,
                              ),
                              Gaps.hGap32,
                              Text(
                                "${Translation.current.step} 3 ${Translation.current.name}",
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_text),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                            width: 60.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_CLOSE,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                2 != 2
                                    ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                    : AppConstants.SVG_RADIO_BUTTON_OFF,
                                color: 2 != 2
                                    ? AppColors.primaryColorLight
                                    : AppColors.accentColorLight,
                              ),
                              Gaps.hGap32,
                              Text(
                                "${Translation.current.step} 4 ${Translation.current.name}",
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_text),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                            width: 60.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_CLOSE,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Gaps.vGap32,
          InkWell(
            onTap: () {
              setState(() {
                steps = true;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 100.w),
              height: 100.h,
              color: canAddStep
                  ? AppColors.primaryColorLight
                  : AppColors.mansourLightGreyColor_4,
              child: Center(
                child: Text(
                  Translation.current.add_step_to_reach_your_dreams,
                  style: TextStyle(
                      fontSize: 40.sp,
                      color: canAddStep
                          ? AppColors.white
                          : AppColors.mansourNotSelectedBorderColor),
                ),
              ),
            ),
          ),
          Gaps.vGap64,
          /* Row(
            children: [
              Gaps.hGap15,
              SizedBox(
                height: 70.h,
                width: 70.h,
                child: InkWell(
                  onTap: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) {
                    //     return BottomSheet(
                    //       builder: (BuildContext context) {
                    //         return AnimatedPadding(
                    //           padding: EdgeInsets.only(
                    //               bottom: MediaQuery.of(context).viewInsets.bottom),
                    //           duration: const Duration(milliseconds: 300),
                    //           child: IconsBottomSheet(
                    //               onPress: (){},
                    //               title: "",
                    //             ),
                    //         );
                    //       },
                    //       onClosing: () {},
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.vertical(
                    //           top: Radius.circular(
                    //             40.r,
                    //           ),
                    //         ),
                    //       ),
                    //       constraints: BoxConstraints(
                    //         maxHeight: 1.sh,
                    //       ),
                    //     );
                    //   },
                    //   isScrollControlled: true,
                    //   isDismissible: false,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(
                    //         40.r,
                    //       ),
                    //     ),
                    //   ),
                    //   constraints: BoxConstraints(
                    //     maxHeight: 1.sh,
                    //   ),
                    // );
                  },
                  child: SvgPicture.asset(
                    AppConstants.SVG_APPOINTMENT_MY_LIFE,
                  ),
                ),
              ),
              Gaps.hGap32,
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black_text,
                      fontSize: 45.sp),
                  decoration: InputDecoration(
                    hintText: "Add Note",
                    hintStyle:
                        TextStyle(fontSize: 40.sp, color: AppColors.black_text),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  inputFormatters: [],
                  onChanged: (value) {
                    setState(() {
                      canAddStep = true;
                    });
                  },
                ),
              ),
            ],
          ),
          Gaps.vGap32,*/
          CustomMansourButton(
            titleText: Translation.current.save_my_dream,
            backgroundColor: steps
                ? AppColors.primaryColorLight
                : AppColors.mansourNotSelectedBorderColor,
            titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
            textColor: AppColors.lightFontColor,
            onPressed: () {
              Nav.pop();
            },
          ),
          Gaps.vGap64,
        ],
      ),
    );
  }
}

class IconsBottomSheet extends StatefulWidget {
  final VoidCallback onPress;
  final String title;

  const IconsBottomSheet({
    Key? key,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  @override
  State<IconsBottomSheet> createState() => _IconsBottomSheetState();
}

class _IconsBottomSheetState extends State<IconsBottomSheet> {
  List<IconPack> iconPackModes = const <IconPack>[IconPack.material];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.sh,
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
      child: Column(
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
                iconPackModes.length.toString(),
                style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_text),
              ),
              Gaps.hGap64,
            ],
          ),
        ],
      ),
    );
  }

  Widget _customContainer({Widget? child}) {
    return Container(
      height: 100.h,
      width: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(
            30.r,
          ),
          child: child),
    );
  }
}
