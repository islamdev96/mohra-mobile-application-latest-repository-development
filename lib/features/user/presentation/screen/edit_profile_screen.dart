import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/user/presentation/screen/edit_address_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/features/user/presentation/screen/all_addresses_screen.dart';
import '../screen/../state_m/provider/edit_profile_screen_notifier.dart';
import 'edit_profile_screen_content.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = "/EditProfileScreen";

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final sn = EditProfileScreenNotifier();

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
    return ChangeNotifierProvider<EditProfileScreenNotifier>.value(
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
            IconButton(
              icon: Icon(Icons.edit_location_outlined,color: Colors.black,
                size: 30,),
              onPressed: (){
                  Nav.to(AllAddressesScreen.routeName);
              },
            )
          ],
          title: Text(
            Translation.current.edit_profile,
            style: TextStyle(color: AppColors.black, fontSize: 60.sp),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: EditProfileScreenContent(),
      ),
    );
  }
}
