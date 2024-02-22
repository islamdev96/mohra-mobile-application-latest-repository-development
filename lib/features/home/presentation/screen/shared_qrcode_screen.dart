import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/params/screen_params/shared_qrcode_screen_params.dart';

import '../screen/../state_m/provider/shared_qrcode_screen_notifier.dart';
import 'shared_qrcode_screen_content.dart';

class SharedQrcodeScreen extends StatefulWidget {
  static const String routeName = "/SharedQrcodeScreen";
  final SharedQRCodeScreenParams params;

  const SharedQrcodeScreen({Key? key, required this.params}) : super(key: key);

  @override
  _SharedQrcodeScreenState createState() => _SharedQrcodeScreenState();
}

class _SharedQrcodeScreenState extends State<SharedQrcodeScreen> {
  late SharedQrcodeScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = SharedQrcodeScreenNotifier(params: widget.params);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SharedQrcodeScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mansourLightGreyColor_6,
          elevation: 0.0,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SharedQrcodeScreenContent(),
      ),
    );
  }
}
