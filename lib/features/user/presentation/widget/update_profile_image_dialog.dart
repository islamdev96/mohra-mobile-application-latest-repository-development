import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/text_style_extension.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/languages_enum.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/show_dialog.dart';
import 'package:starter_application/generated/l10n.dart';

void showChangeProfileDialog({
  required BuildContext context,
  required String imageUrl,
   bool isCircle = false,
  required Function() onConfirm,
   Function()? onCancel,
}) {
  ShowDialog().showElasticDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return ChangeProfilePicDialog(
        imageUrl: imageUrl,
        isCircle: isCircle,
        onConfirm: onConfirm,
        onCancel: onCancel,
      );
    },
  );
}

class ChangeProfilePicDialog extends StatefulWidget {
  const ChangeProfilePicDialog(
      {required this.imageUrl,required this.isCircle, required this.onConfirm, this.onCancel});

  final String imageUrl;
  final bool isCircle;
  final Function() onConfirm;
  final Function()? onCancel;

  @override
  State createState() => new LanguageDialogState();
}

class LanguageDialogState extends State<ChangeProfilePicDialog> {
  int? _selectedId = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.dp15),
        ),
      ),
      title: Text(
        Translation.current.update_profile_image_message,
        style: Colors.black.bodyText1,
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(25)),
        ),
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height:200,
              width:200,
              decoration: BoxDecoration(shape:widget.isCircle ? BoxShape.circle : BoxShape.rectangle,image: DecorationImage(image: FileImage(File(widget.imageUrl),),fit: BoxFit.cover,)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Text(
                    Translation.of(context).cancel,
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Nav.pop();
                  },
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(35),
                    ),
                  ),
                  child: Text(
                    Translation.of(context).confirm,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: widget.onConfirm,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void changeLanguage(BuildContext context, Locale newLocale) async {
    await Provider.of<LocalizationProvider>(context, listen: false)
        .changeLanguage(newLocale, context);
    AppConfig().setAppLanguage = newLocale.languageCode;
    if (AppConfig().appOptions.changeLangRestart)
      RestartWidget.restartApp(context);
  }
}
