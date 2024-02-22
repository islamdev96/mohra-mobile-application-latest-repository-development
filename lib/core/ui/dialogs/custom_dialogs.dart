import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import 'show_dialog.dart';

void showCustomMessageDialog({
  String? title,
  String? content,
  String? buttonText,
  Function(BuildContext context)? onButtonPressed,
  required BuildContext context,
}) {
  ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(myContext).size.width * 0.75,
          height: MediaQuery.of(myContext).size.height * 0.30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title ?? '',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: ScreenUtil().setSp(42),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  content ?? '',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenUtil().setSp(36),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (buttonText != null)
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(42),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: onButtonPressed == null
                      ? () {
                          // Navigator.of(myContext).pop();
                          Nav.pop(myContext);
                        }
                      : () {
                          onButtonPressed(myContext);
                        },
                  textColor: Theme.of(myContext).primaryColor,
                ),
            ],
          ),
        ),
      );
    },
  );
}

void showCustomDialogWithIconDialog({
  Widget? icon,
  Color? iconBackColor,
  String? content,
  String? buttonText,
  bool? isDesmissible,
  bool? isBackPopped,
  Function(BuildContext context)? onButtonPressed,
  required BuildContext context,
}) {
  ShowDialog().showElasticDialog(
    barrierDismissible: isDesmissible ?? true,
    context: context,
    builder: (BuildContext context) {
      print("showCustomDialogWithIconDialog");
      return WillPopScope(
        onWillPop: () async {
          return isBackPopped ?? true;
        },
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Container(
                    width: ScreenUtil().setWidth(150),
                    height: ScreenUtil().setWidth(150),
                    decoration: BoxDecoration(
                        color: iconBackColor ?? Colors.greenAccent,
                        borderRadius: BorderRadius.circular(200)),
                    child: Center(
                      child: icon ??
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    content ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil().setSp(40),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (buttonText != null)
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(42),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: onButtonPressed == null
                        ? () {
                            // Navigator.of(context).pop();
                            Nav.pop(context);
                          }
                        : () => onButtonPressed(context),
                    textColor: Theme.of(context).primaryColor,
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showCustomConfirmCancelDialog({
  String? title,
  String? content,
  Function(BuildContext context)? onConfirm,
  Function(BuildContext context)? onCancel,
  bool? isDismissible,
  bool? canPop,
  String? cancelText,
  confirmText,
  required BuildContext mainContext,
}) {
  ShowDialog().showElasticDialog(
    context: mainContext,
    barrierDismissible: isDismissible ?? true,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(canPop ?? true),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: MediaQuery.of(mainContext).size.width * 0.75,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenUtil().setSp(42),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(280),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          content ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ScreenUtil().setSp(36),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          cancelText ?? Translation.of(context).cancel,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onPressed: onCancel != null
                          ? () => onCancel(context)
                          : () {
                              // Navigator.of(context).pop();
                              Nav.pop(context);
                            },
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          confirmText ?? Translation.of(context).confirm,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: onConfirm != null
                          ? () => onConfirm(context)
                          : () {
                              // Navigator.of(context).pop();
                              Nav.pop(context);
                            },
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

showCustomDialogWithTextField(
    {required BuildContext context,
    String? labelText,
    String? hintText,
    int? minLines,
    int? maxLines,
    double? height,
    String title = '',
    Function(String text)? onConfirm,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    Color? helperTextColor,
    TextInputType? keyboardType}) {
  final _textKey = new GlobalKey<FormFieldState<String>>();
  final _textController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext bc) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(40),
            ),
          ),
          //scrollable: true,
          child: Container(
            width: ScreenUtil().screenWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labelText == null ? "" : labelText,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ScreenUtil().setSp(32),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              Translation.of(context).cancel,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(42),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Nav.pop(context);
                          },
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              Translation.of(context).confirm,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(42),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_textKey.currentState!.validate()) {
                              if (onConfirm != null)
                                onConfirm(_textController.text);
                              // Navigator.of(context).pop();
                              Nav.pop(context);
                            }
                          },
                          textColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
