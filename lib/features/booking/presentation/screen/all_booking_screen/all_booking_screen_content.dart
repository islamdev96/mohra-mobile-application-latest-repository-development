import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/all_booking_screen_notifier.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/booking_services_screen_notifier.dart';
import 'package:starter_application/features/booking/presentation/widget/booking_category_widget.dart';
import 'package:starter_application/features/booking/presentation/widget/booking_widget.dart';
import 'package:starter_application/features/booking/presentation/widget/home_filter.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_tabs_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/state_m/provider/home_services_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/widget/custom_shop_app_bar.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_tabs_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_services_title_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/slider_home_services_home_page.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class AllBookingsScreenContent extends StatefulWidget {
  AllBookingsScreenContent({Key? key}) : super(key: key);

  @override
  _AllBookingsScreenContentState createState() =>
      _AllBookingsScreenContentState();
}

class _AllBookingsScreenContentState extends State<AllBookingsScreenContent> {
  late AllBookingsScreenNotifier sn;
  final padding = EdgeInsets.symmetric(
    horizontal: 50.w,
  );
  List<String> itemList = ['Barbershop','Dr Appointment','Beauty Clinic','Message & Spa','Beauty Saloon'];

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AllBookingsScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      backgroundColor: AppColors.mansourLightGreyColor_6,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mansourLightGreyColor_6,
        leading: InkWell(
            onTap: () {
              Nav.pop();
            },
            child: Icon(
              AppConstants.getIconBack(),
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.current.Booking,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                _buildInfoRow(
                  title: Text("Jeddah, Saudi Arabia"),
                  subtitle: "",
                  image: AppConstants.IMG_EVENT_LOCATION,
                ),
                Gaps.vGap24
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: HomeServicesTextField(
                    hint: Translation.of(context)
                        .wha_services_are_you_looking_for,
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
                Gaps.hGap12,
                InkWell(
                  onTap: (){
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration:  const BoxDecoration(
                            color: Colors.white,
                            borderRadius:  BorderRadius.only(
                              topLeft:  Radius.circular(10),
                              topRight:  Radius.circular(10),
                            ),
                          ),
                          child:  HomeFilter(sn: EventOrganizerScreenNotifier(),),
                        ),
                      );
                      /* Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const HomeFilter())
                  );*/
                  },
                  child: SvgPicture.asset(
                    AppConstants.filter,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Found 5 barbershop",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                ),
                InkWell(
                  onTap: (){
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                        ),
                        context: context,
                        builder: (BuildContext context){
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                       Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(Translation.current.Selet_Cateogry,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("assets/icons/cancel.png",width: 15,height: 15,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // list of items
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: itemList.length,
                                    itemBuilder: (BuildContext context, index){
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: (Text(itemList.elementAt(index),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.normal),)),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 70.sp + Dimens.dp32.w,
                      ),
                      Text(
                        Translation.current.sorting_by + " : Default",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined,
                        color:AppColors.primaryColorLight,
                        size: 70.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return BookingWidget();
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap32;
                  },
                  itemCount: 10)),
        ],
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

  Widget _buildInfoRow({
    required Text title,
    required String subtitle,
    required String image,
    bool isNetwork = false,
    Widget? button,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.h,
          width: 50.h,
          child: SvgPicture.asset(
            AppConstants.SVG_PIN,
            color: AppColors.primaryColorLight,
          ),
        ),
        SizedBox(
          width: 40.w,
        ),
        title,
      ],
    );
  }
}
