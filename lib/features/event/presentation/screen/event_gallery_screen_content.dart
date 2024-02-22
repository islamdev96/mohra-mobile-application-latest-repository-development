import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';

import '../screen/../state_m/provider/event_gallery_screen_notifier.dart';

class EventGalleryScreenContent extends StatefulWidget {
  @override
  State<EventGalleryScreenContent> createState() =>
      _EventGalleryScreenContentState();
}

class _EventGalleryScreenContentState extends State<EventGalleryScreenContent> {
  late EventGalleryScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventGalleryScreenNotifier>(context);
    sn.context = context;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: _buildImageDisplayedWidget(),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Expanded(child: _buildImagesWidget())
      ],
    );
  }

  Widget _buildImageDisplayedWidget() {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: CustomNetworkImageWidget(
            imgPath: sn.images.elementAt(sn.imageToDisplay),
          )),
    );
  }

  Widget _buildImagesWidget() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 0.1.sh,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: index == 0 ? 60.w : 0,
                    end: index == sn.images.length - 1 ? 60.w : 0,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () {
                        sn.imageToDisplay = index;
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      sn.images.elementAt(index)),
                                  colorFilter: ColorFilter.mode(
                                      AppColors.white.withOpacity(
                                          sn.imageToDisplay == index ? 1 : 0.3),
                                      BlendMode.dstATop),
                                  fit: BoxFit.cover))),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 20.w,
                  ),
              itemCount: sn.images.length),
        ));
  }
}
