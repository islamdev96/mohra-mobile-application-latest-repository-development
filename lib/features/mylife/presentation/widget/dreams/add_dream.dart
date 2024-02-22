import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/data/model/response/get_dream_list_response.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/state_m/provider/dream_screen_notifier.dart';
import 'package:starter_application/features/mylife/presentation/widget/dreams/dream_step.dart';
import 'package:starter_application/features/mylife/presentation/widget/dreams/icon_picker_bottom_sheet.dart';
import 'package:starter_application/generated/l10n.dart';

class AddDreamBottomSheet extends StatefulWidget {
  final List<String> imageList;
  final DreamScreenNotifier sn;

  AddDreamBottomSheet({
    required this.imageList,
    required this.sn,
  });

  @override
  State<AddDreamBottomSheet> createState() => _AddDreamBottomSheetState();
}

class _AddDreamBottomSheetState extends State<AddDreamBottomSheet> {
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
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  Translation.current.tell_us_about_your_dreams,
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
                  height: 100.h,
                  width: 100.h,
                  child: InkWell(
                    onTap: () async {
                      var a = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return IconPickerBottomSheet(
                            sn: widget.sn,
                            imageList: this.widget.imageList,
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
                      setState(() {});
                    },
                    child: widget.sn.selectedIconDream == -1
                        ? SvgPicture.asset(
                            AppConstants.SVG_CAMERA,
                            color: AppColors.text_gray,
                          )
                        : ImageIcon(
                            AssetImage(
                                widget.imageList[widget.sn.selectedIconDream]),
                            color: widget.sn.addDreamColor,
                            size: 150.w,
                          ),
                  ),
                ),
                Gaps.hGap32,
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: widget.sn.dreamTitleTextFieldController,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_text,
                        fontSize: 45.sp),
                    decoration: InputDecoration(
                      hintText: Translation.current.dream_title_hint,
                      hintStyle: TextStyle(
                          fontSize: 40.sp, color: AppColors.textLight2),
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
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Gaps.vGap32,
            Center(
              child: Text(
                Translation.current.add_step_to_reach_your_dreams,
                style: TextStyle(fontSize: 40.sp, color: AppColors.text_gray),
              ),
            ),
            Gaps.vGap50,
            UnconstrainedBox(
              child: Container(
                width: 0.7.sw,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.sn.steps.length,
                  itemBuilder: (context, index) {
                    return DreamStep(
                      onDelete: () {
                        widget.sn.steps.remove(widget.sn.steps[index]);
                        setState(() {});
                      },
                      stepName: widget.sn.steps[index].title,
                    );
                  },
                ),
              ),
            ),
            Gaps.vGap50,
            UnconstrainedBox(
              child: Container(
                width: 0.7.sw,
                child: Column(
                  children: [
                    TextFormField(
                      controller: widget.sn.stepTextFiledController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_text,
                        fontSize: 45.sp,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            "${Translation.current.dream_step} ${widget.sn.steps.length + 1} ?",
                        hintStyle: TextStyle(
                            fontSize: 40.sp, color: AppColors.textLight2),
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
                        setState(() {});
                      },
                    ),
                    Gaps.vGap24,
                    CustomMansourButton(
                      width: 100,
                      height: 40,
                      titleText: Translation.current.add,
                      backgroundColor:
                          widget.sn.stepTextFiledController.value.text.isEmpty
                              ? AppColors.mansourNotSelectedBorderColor
                              : AppColors.primaryColorLight,
                      titleStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 45.sp),
                      textColor: AppColors.lightFontColor,
                      onPressed: () {
                        if (widget
                            .sn.stepTextFiledController.value.text.isNotEmpty) {
                          StepModel s = StepModel(
                            title: widget.sn.stepTextFiledController.value.text,
                            order: widget.sn.steps.length + 1,
                            status: 0,
                            id: 0,
                          );
                          widget.sn.steps.add(s);
                          widget.sn.stepTextFiledController.clear();
                          setState(
                            () {},
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Gaps.vGap64,
            BlocConsumer<MylifeCubit, MylifeState>(
              bloc: widget.sn.mylifeCubit,
              listener: (context, state) {
                if (state is DreamCreated) {
                  widget.sn.onDreamCreated(state.dreamEntity);
                }
              },
              builder: (context, state) {
                if (state is CreateDream) {
                  return TextWaitingWidget(
                    Translation.current.create_your_dream,
                  );
                } else
                  return CustomMansourButton(
                    titleText: Translation.current.save_my_dream,
                    backgroundColor:
                        (widget.sn.canSaveDream() && widget.sn.addedIcon())
                            ? AppColors.primaryColorLight
                            : AppColors.mansourNotSelectedBorderColor,
                    titleStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                    textColor: AppColors.lightFontColor,
                    onPressed: () async {
                      if (widget.sn.canSaveDream()) {
                        if (widget.sn.addedIcon()) {
                          widget.sn.onSavePress();
                          Nav.pop();
                        } else {
                          var a = await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return IconPickerBottomSheet(
                                sn: widget.sn,
                                imageList: this.widget.imageList,
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
                          setState(() {});
                        }
                      }
                    },
                  );
              },
            ),
            Gaps.vGap64,
          ],
        ),
      ),
    );
  }
}
