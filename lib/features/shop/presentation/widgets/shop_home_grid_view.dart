import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/text_style_extension.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/language_dialog.dart';
import 'package:starter_application/core/ui/dialogs/show_dialog.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/home_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/shop_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../booking/presentation/screen/home_screen/booking_services_screen.dart';
import '../../../home_services/presentation/screen/home_screen/home_services_screen.dart';
import '../screen/shop_main_screen.dart';

class ShopGridView extends StatelessWidget {
  const ShopGridView({Key? key, required this.shopCategory}) : super(key: key);
  final List<ShopCategory> shopCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: shopCategory.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 40.w,
          mainAxisSpacing: 20.w,
          childAspectRatio: AppConfig().appLanguage == AppConstants.LANG_EN
              ? MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5)
              : MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
        ),
        itemBuilder: (context, index) {
          return _buildGridItem(index, shopCategory[index].name,
              shopCategory[index].image, context);
        },
      ),
    );
  }

  Widget _buildGridItem(
      int index, String name, String image, BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return InkWell(
        onTap: () {
        shopNav(index);
        },
        child: Column(
          children: [
            Container(
              height: 250.h,
              width: 250.h,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mansourNotSelectedBorderColor
                              .withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                          child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                  // if (index > 0) //TODO change index depend on api index
                  //   Container(
                  //     height: 250.h,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: AppColors.black.withOpacity(0.5),
                  //     ),
                  //     child: Center(
                  //       child: FittedBox(
                  //         fit: BoxFit.scaleDown,
                  //         child: Text(
                  //           Translation.current.coming_soon,
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 37.sp,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   )
                ],
              ),
            ),
            Gaps.vGap40,
            FittedBox(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 37.sp,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
    });
  }

  showVisionDialog(BuildContext context) {
    ShowDialog().showElasticDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.dp15),
            ),
          ),
          title: Text(
            Translation.current.vision_2030,
            style: Colors.black.bodyText1,
          ),
          content: Container(
              width: 0.8.sw,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(25)),
              ),
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: Image.asset(
                          'assets/images/png/saudi_logo.png',
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            Translation.current.vision_desc_1,
                             style: Colors.black.bodyText2,
                          ),
                          Gaps.vGap40,
                          RichText(
                            text: TextSpan(
                              text: Translation.current.vision_desc_2, style: Colors.black.bodyText2,
                              children:  <TextSpan>[
                                TextSpan(
                                  text: 'info@mohraapps.com',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blueFontColor,
                                  ),
                                    recognizer: TapGestureRecognizer()..onTap = (){
                                    launch('mailto:info@mohraapps.com');
                                    }
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}

void shopNav(int index) {
  switch (index) {
    case 0:
      Nav.to(ShopMainScreen.routeName);
      break;
    case 1:
      Nav.to(HomeServicesScreen.routeName);
      break;
    case 2:
      Nav.to(BookingServicesScreen.routeName);
      break;
  }
}
