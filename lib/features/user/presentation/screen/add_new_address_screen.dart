import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/add_new_address_screen_notifier.dart';
import 'add_new_address_screen_content.dart';

class AddNewAddressScreen extends StatefulWidget {
  static const String routeName = "/AddNewAddressScreen";

  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final sn = AddNewAddressScreenNotifier();

  @override
  void initState() {
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
    return ChangeNotifierProvider<AddNewAddressScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
          title: Translation.current.add + ' ' + Translation.current.address,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AddNewAddressScreenContent(),
      ),
    );
  }
}
