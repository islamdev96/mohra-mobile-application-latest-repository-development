import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../core/ui/widgets/waiting_widget.dart';
import '../../../../main.dart';
import '../screen/../state_m/provider/about_us_screen_notifier.dart';
import '../state_m/cubit/help_cubit.dart';
import '../state_m/provider/help_screen_notifier.dart';

class AboutUsScreenContent extends StatelessWidget {
  late AboutUsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AboutUsScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<HelpCubit, HelpState>(
      bloc: sn.helpCubit,
      listener: (context, state) {
        if (state is GetAboutUsLoaded) {
          sn.getAboutUsLoaded(state.entity);
        }
      },
      builder: (context, state) {
        return state.maybeMap(
            helpLoadingState: (s) => WaitingWidget(),
            getAboutUsLoaded: (s) => Scaffold(
                  body: ListView(
                    children: [
                      Gaps.vGap64,
                      Center(
                        child: SizedBox(
                          width: .9.sw,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Nav.pop(context);
                                },
                                child: Icon(
                                  AppConstants.getIconBack(),
                                  color: AppColors.greyBackButton,
                                  size: 20,
                                ),
                              ),
                              Gaps.hGap32,
                              Text(
                                Translation.current.about_us,
                                style: TextStyle(
                                  color: AppColors.greyBackButton,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap50,
                      Html(
                        data: isArabic
                            ? sn.aboutUsEntity.arTitle
                            : sn.aboutUsEntity.enTitle,
                        style: {
                          '#': Style(
                              fontSize: FontSize(17),
                              direction: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr),
                        },
                      ),
                      Gaps.vGap50,
                      Html(
                        data: isArabic
                            ? sn.aboutUsEntity.arContent
                            : sn.aboutUsEntity.enContent,
                        style: {
                          '#': Style(
                              fontSize: FontSize(17),
                              direction: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr),
                        },
                      ),
                    ],
                  ),
                ),
            orElse: () => SizedBox());
      },
    );
  }

// _buildMap() {
//   return Center(
//     child: SizedBox(
//       width: 350.0,
//       height: 250.0,
//       child: Scaffold(
//         body: GoogleMap(
//           onTap: (newP) {},
//           initialCameraPosition: CameraPosition(
//             target: sn.kMapCenter,
//             zoom: 12.0,
//           ),
//           markers: <Marker>{
//             sn.markers.values
//                 .toList()
//                 .firstWhere((item) => item.markerId == MarkerId('1')),
//           },
//           gestureRecognizers: Set()
//             ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
//             ..add(Factory<VerticalDragGestureRecognizer>(
//                 () => VerticalDragGestureRecognizer())),
//           onMapCreated: sn.onMapCreated,
//           myLocationButtonEnabled: false,
//           myLocationEnabled: true,
//           buildingsEnabled: true,
//           zoomControlsEnabled: false,
//           mapType: MapType.normal,
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {},
//           child: Icon(Icons.my_location_outlined),
//           backgroundColor: AppColors.white.withOpacity(1),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
