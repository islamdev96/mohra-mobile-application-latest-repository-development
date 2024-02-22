import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_tabs_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/state_m/provider/home_services_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/widget/custom_shop_app_bar.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_tabs_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_services_title_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/slider_home_services_home_page.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class HomeServicesScreenContent extends StatefulWidget {
  HomeServicesScreenContent({Key? key}) : super(key: key);

  @override
  _HomeServicesScreenContentState createState() =>
      _HomeServicesScreenContentState();
}

class _HomeServicesScreenContentState extends State<HomeServicesScreenContent> {
  late HomeServicesScreenNotifier sn;
  final padding = EdgeInsets.symmetric(
    horizontal: 50.w,
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HomeServicesScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mansourLightBlueColor,
        leading: InkWell(
            onTap: () {
              Nav.pop();
            },
            child: Icon(
              AppConstants.getIconBack(),
              color: Colors.white,
            )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "your location",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "970 Muriel Squsare Apt. 564",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeServicesTextField(
                hint: Translation.of(context).wha_services_are_you_looking_for,
                suffix: const Icon(Icons.search),
                hintSize: 14,
                onChanged: (s) => setState(() {
                  sn.search = s;
                }),
                controller: sn.controller,
                prefix: (sn.search != null ||
                    (sn.search != null && sn.search != ''))
                    ? InkWell(
                    onTap: () => setState(() {
                      sn.controller.clear;
                    }),
                    child: const Icon(Icons.close))
                    : null,
              ),
            ),
            HomeServicesSlider(
              imageSlider: [
                ItemEntity(
                    isActive: true,
                    id: 10,
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(Duration(days: 1)),
                    imageUrl:
                        "https://img.freepik.com/premium-photo/bottle-dishwashing-liquid-basket-rags-blue-background_393202-13839.jpg?w=1060",
                    productId: 1,
                    shopId: 1,
                    shopName: "ff"),
                ItemEntity(
                    isActive: true,
                    id: 10,
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(Duration(days: 1)),
                    imageUrl:
                        "https://m.media-amazon.com/images/I/41eFcBVIPoL._SX300_SY300_QL70_FMwebp_.jpg",
                    productId: 1,
                    shopId: 1,
                    shopName: "ff")
              ],
              onSendToParent: (id) {
                print(id);
              },
            ),
            HomeServicesTitleWidget(
              title: Translation.of(context).Services_Categories,
              textColor: AppColors.black,
            ),
            [
              EventCategoryEntity(
                isActive: true,
                name: "Cleaning",
                id: 1,
                enName: 'Cleaning',
                arName: 'Cleaning',
              ),
              EventCategoryEntity(
                isActive: true,
                name: "Maintenance",
                id: 2,
                enName: 'Maintenance',
                arName: 'Maintenance',
              ),
              EventCategoryEntity(
                isActive: true,
                name: "Other",
                id: 3,
                enName: 'Other',
                arName: 'Other',
              )
            ].isEmpty
                ? _buildEmptyWidget()
                : HomeServicesTabsWidget(
              categories: [
                EventCategoryEntity(
                  isActive: true,
                  name: "Cleaning",
                  id: 1,
                  enName: 'Cleaning',
                  arName: 'Cleaning',
                ),
                EventCategoryEntity(
                  isActive: true,
                  name: "Maintenance",
                  id: 2,
                  enName: 'Maintenance',
                  arName: 'Maintenance',
                ),
                EventCategoryEntity(
                  isActive: true,
                  name: "Other",
                  id: 3,
                  enName: 'Other',
                  arName: 'Other',
                )
              ],
              selectedTabId: 1,
              onTabSelected: (eventCategoryEntity) {
                // sn.chosenCategory = eventCategoryEntity;
              },
            ),
            Gaps.vGap64,
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return HomeServiceWidget();
                },
                itemCount: 10,
              ),
              height:  0.2.sh * 10,
            )
          ],
        ),
      ),
    );
  }

  /// Widgets
  Widget _buildEmptyWidget() {
    return SizedBox(
      height: 0.2.sh,
      child: Center(
        child: EmptyErrorScreenWidget(
          message: Translation.current.no_data,
          textColor: AppColors.white_text,
        ),
      ),
    );
  }
}
