import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/event/presentation/widget/event_edit_info_dialogue.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class EventPersonalInformationWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final Function onSave;
  final Function onDelete;
  const EventPersonalInformationWidget(
      {Key? key,
      required this.nameController,
      required this.phoneController,
      required this.emailController,
      required this.onSave,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventTitleWidget(
          title: Translation.of(context).personal_information,
          textColor: AppColors.black_text,
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 120.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    nameController.text != ''
                        ? nameController.text
                        : Translation.of(context).name,
                    style: TextStyle(
                      color: AppColors.black_text,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => EventEditInfoDialogue(
                          emailController: emailController,
                          nameController: nameController,
                          phoneController: phoneController,
                          onSave: () {
                            onSave();
                          },
                        ),
                      );
                    },
                    child: ImageIcon(
                      const AssetImage(AppConstants.IMG_EVENT_EDIT),
                      size: 70.w,
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      nameController.text = '';
                      phoneController.text = '';
                      emailController.text = '';
                      onDelete();
                    },
                    child: Image.asset(
                      AppConstants.IMG_EVENT_CANCEL,
                      height: 70.w,
                      width: 70.w,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                phoneController.text != ''
                    ? phoneController.text
                    : Translation.of(context).phone,
                style: const TextStyle(color: AppColors.accentColorLight),
              ),
              Text(
                emailController.text != ''
                    ? emailController.text
                    : Translation.of(context).email,
                style: const TextStyle(color: AppColors.accentColorLight),
              ),
            ],
          ),
        )
      ],
    );
  }
}
