import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/event_home_screen_notifier.dart';
import 'package:starter_application/features/event/presentation/widget/event_filter_dialogue.dart';
import 'package:starter_application/features/location/domain/entity/location_lite_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class EventSearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(LocationLiteEntity? locationLiteEntity) search;
  final LocationLiteEntity? locationLiteEntity;
  final EventHomeScreenNotifier? sn;
  const EventSearchTextField(
      {Key? key,
      required this.controller,
      required this.search,
      required this.sn,
      required this.locationLiteEntity})
      : super(key: key);

  @override
  State<EventSearchTextField> createState() => _EventSearchTextFieldState();
}

class _EventSearchTextFieldState extends State<EventSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      fillColor: AppColors.white,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      disabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      errorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      focusedErrorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      prefixIcon: const Icon(
        Icons.search,
        color: AppColors.mansourLightGreyColor_8,
      ),
      suffixIcon: widget.sn?.locationLiteEntity == null ?
      GestureDetector(
        onTap: () {
          openFilterDialogue(context);
        },
        child: Padding(
          padding: EdgeInsetsDirectional.only(end: 40.w),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: ImageIcon(
              AssetImage(
                AppConstants.IMG_FILTER,
              ),
              color: AppColors.mansourDarkOrange3,
            ),
          ),
        ),
      ) :
      GestureDetector(
        onTap: () {
          widget.sn!.refreshSearch();
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsetsDirectional.only(end: 40.w),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.refresh,color: AppColors.mansourDarkOrange3,)
          ),
        ),
      ),
      // suffixIconConstraints: BoxConstraints(maxWidth: 100.w, maxHeight: 100.w),
      hintText: Translation.of(context).search_event,
      hintStyle: const TextStyle(color: AppColors.mansourLightGreyColor_8),
    );
  }

  openFilterDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EventFilterDialogue(
          search: (locationLiteEntity) => widget.search(locationLiteEntity),
          locationLiteEntity: widget.locationLiteEntity),
    );
  }
}
