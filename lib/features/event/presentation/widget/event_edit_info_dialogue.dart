import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/generated/l10n.dart';

class EventEditInfoDialogue extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final Function onSave;
  const EventEditInfoDialogue(
      {Key? key,
      required this.nameController,
      required this.phoneController,
      required this.emailController,
      required this.onSave})
      : super(key: key);

  @override
  _EventEditInfoDialogueState createState() => _EventEditInfoDialogueState();
}

class _EventEditInfoDialogueState extends State<EventEditInfoDialogue> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.nameController.text);
    _phoneController = TextEditingController(text: widget.phoneController.text);
    _emailController = TextEditingController(text: widget.emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: AppColors.white,
          ),
          padding: EdgeInsets.all(80.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                  border: const UnderlineInputBorder(),
                  disabledBorder: const UnderlineInputBorder(),
                  enabledBorder: const UnderlineInputBorder(),
                  errorBorder: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(),
                  focusedErrorBorder: const UnderlineInputBorder(),
                  controller: _nameController,
                  hintText: Translation.of(context).name,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name),
              CustomTextField(
                  border: const UnderlineInputBorder(),
                  disabledBorder: const UnderlineInputBorder(),
                  enabledBorder: const UnderlineInputBorder(),
                  errorBorder: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(),
                  focusedErrorBorder: const UnderlineInputBorder(),
                  hintText: Translation.of(context).phone,
                  controller: _phoneController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone),
              CustomTextField(
                  border: const UnderlineInputBorder(),
                  disabledBorder: const UnderlineInputBorder(),
                  enabledBorder: const UnderlineInputBorder(),
                  errorBorder: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(),
                  focusedErrorBorder: const UnderlineInputBorder(),
                  hintText: Translation.of(context).email,
                  controller: _emailController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress),
              SizedBox(
                height: 40.h,
              ),
              CustomMansourButton(
                onPressed: _onSave,
                titleText: Translation.of(context).save,
              )
            ],
          )),
    );
  }

  void _onSave() {
    widget.onSave();
    widget.nameController.text = _nameController.text;
    widget.phoneController.text = _phoneController.text;
    widget.emailController.text = _emailController.text;
    Nav.pop();
  }
}
