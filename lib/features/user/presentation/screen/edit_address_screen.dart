import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/edit_address_screen_notifier.dart';
import 'edit_address_screen_content.dart';

class EditAddressScreen extends StatefulWidget {
  static const String routeName = "/EditAddressScreen";
   EditAddressScreen({Key? key}) : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late EditAddressScreenNotifier sn ;

  @override
  void initState() {
    sn = EditAddressScreenNotifier();
    sn.addressBeforEditing = UserSessionDataModel.updateAddress!;
    sn.initData();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditAddressScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
          title: Translation.current.edit_address,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: EditAddressScreenContent(),
      ),
    );
  }
}
