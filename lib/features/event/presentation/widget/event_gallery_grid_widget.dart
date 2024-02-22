import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/event_gallery_screen_params.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/event/presentation/screen/event_gallery_screen.dart';
import 'package:starter_application/generated/l10n.dart';

class EventGalleryGridWidget extends StatelessWidget {
  final List<String> images;
  final double? height;
  final double? width;
  final bool isSubWidget;
  const EventGalleryGridWidget(
      {Key? key,
      required this.images,
      this.height,
      this.width,
      this.isSubWidget = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildImageWidget(0)),
              SizedBox(
                width: 30.w,
              ),
              if(images.length >1) Expanded(
                child: _buildImageWidget(1),
              ),
            ],
          ),
          SizedBox(
            height: 30.w,
          ),
          if(images.length >2) Row(
            children: [
              Expanded(
                child: _buildImageWidget(2),
              ),
              SizedBox(
                width: 30.w,
              ),
              if(images.length >3)  Expanded(
                child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: _buildImageWidget(3)),
                              SizedBox(
                                width: 30.w,
                              ),
                              if(images.length >4)  Expanded(
                                child: _buildImageWidget(4),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          if(images.length >5)  Row(
                            children: [
                              Expanded(
                                child: _buildImageWidget(5),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              if(images.length >6)    Expanded(
                                child: _buildPlusTenWidget(context),
                              ),
                            ],
                          ),
                        ],
                      )

              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlusTenWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Nav.to(EventGalleryScreen.routeName,
            arguments: EventGalleryScreenParams(images: images));
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.mansourDarkPurple,
              borderRadius: BorderRadius.circular(25.r)),
          child: Center(
            child: Text(
              '+' +
                  images.sublist(6, images.length).length.toString() +
                  ' ' +
                  Translation.of(context).more,
              style: const TextStyle(color: AppColors.white_text),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(int index) {
    return GestureDetector(
      onTap: () {
        if (images.length >= index + 1)
          Nav.to(EventGalleryScreen.routeName,
              arguments: EventGalleryScreenParams(
                  images: images, chosenImageIndex: index));
      },
      child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: images.length >= index + 1
                  ? CustomNetworkImageWidget(
                      imgPath: images.elementAt(index),
                    )
                  : Container(
                      color: AppColors.mansourLightGreyColor_5,
                    ))),
    );
  }
}
