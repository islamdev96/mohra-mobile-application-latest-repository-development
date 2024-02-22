import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/user/presentation/screen/add_new_address_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/all_addresses_screen_notifier.dart';
import 'all_addresses_screen_content.dart';

class AllAddressesScreen extends StatefulWidget {
  static const String routeName = "/AllAddressesScreen";

  const AllAddressesScreen({Key? key}) : super(key: key);

  @override
  _AllAddressesScreenState createState() => _AllAddressesScreenState();
}

class _AllAddressesScreenState extends State<AllAddressesScreen> {
  final sn = AllAddressesScreenNotifier();

  @override
  void initState() {
    sn.getAllAddresses();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllAddressesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Nav.pop(),
            child:  Icon(
              AppConstants.getIconBack(),
              color: Colors.black,
              size: 30,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    Nav.to(AddNewAddressScreen.routeName).then((value) => sn.getAllAddresses());
                  },
                  child: Text('+' + Translation.current.add_new, style: TextStyle(
                    color: AppColors.mansourDarkOrange3,
                    fontSize: 50.sp
                  ),),
                ),
              ),
            )
          ],
          title: Text(
            Translation.current.my_addresses,
            style: TextStyle(color: AppColors.black, fontSize: 50.sp, fontWeight: FontWeight.bold),
          ),
        ) ,

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AllAddressesScreenContent(),
      ),
    );
  }
}
