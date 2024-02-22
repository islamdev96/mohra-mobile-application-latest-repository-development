import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/find_mosque_screen_notifier.dart';
import 'package:starter_application/features/religion/presentation/widget/nearby_mosque_list/nearby_mosque_list.dart';
import 'package:starter_application/generated/l10n.dart';

class FindMosqueScreenContent extends StatefulWidget {
  @override
  State<FindMosqueScreenContent> createState() =>
      _FindMosqueScreenContentState();
}

class _FindMosqueScreenContentState extends State<FindMosqueScreenContent> {
  late FindMosqueScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FindMosqueScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: AppConstants.screenPadding,
      child: Column(
        children: [
          _build_search_text_field(),
          Gaps.vGap96,
          _buildNearbyMosqueList(),
        ],
      ),
    );
  }

  Widget _build_search_text_field() {
    return SearchTextField(
      textKey: sn.searchKey,
      controller: sn.searchController,
      focusNode: sn.searchFocusNode,
      backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
      iconColor: AppColors.mansourDarkGrey.withOpacity(
        0.6,
      ),
      hint: Translation.current.search_location,
      hintColor: AppColors.mansourDarkGrey.withOpacity(
        0.6,
      ),
      trailing: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {},
        icon: SizedBox(
          height: 75.h,
          width: 75.h,
          child: SvgPicture.asset(
            AppConstants.SVG_GPS,
            color: AppColors.mansourPurple4,
          ),
        ),
      ),
      onFieldSubmitted: sn.onSearchFieldSubmitted,
    );
  }

  Widget _buildNearbyMosqueList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.current.nearby_mosque,
            style: TextStyle(
              color: Colors.black,
              fontSize: 50.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.vGap64,
          Expanded(
            child: NearbyMosqueList(
              mosques: sn.mosques,
              userLocation: sn.userLocation,
            ),
          ),
        ],
      ),
    );
  }
}
