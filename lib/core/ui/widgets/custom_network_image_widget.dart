import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final String? imgPath;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;
  final BoxFit? boxFit;
  final Widget? errorImage;
  final double? radius;
  final bool withChild;

  const CustomNetworkImageWidget(
      {Key? key,
      required this.imgPath,
      this.width,
      this.height,
      this.child,
      this.color,
      this.boxFit,
      this.errorImage,
      this.radius,
      this.withChild = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imgPath != null ?  CachedNetworkImage(
      imageUrl: imgPath!,
      imageBuilder: withChild
          ? (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 0),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        color ?? AppColors.transparent, BlendMode.lighten),
                    image: imageProvider,
                    fit: boxFit ?? BoxFit.cover,
                  ),
                ),
                child: child,
              )
          : null,
      placeholder: (context, url) => Shimmer.fromColors(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 0),
              color: AppColors.shimmerBaseColor,
            ),
          ),
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor),
      errorWidget: (context, url, error) => errorImage != null
          ? errorImage!
          : Container(
              width: width,
              height: height,
              color: AppColors.mansourLightGreyColor_3,
              child: Center(child: Icon(Icons.broken_image)))
    ) : Container(
        width: width,
        height: height,
        color: AppColors.mansourLightGreyColor_3,
        child: const Center(child: Icon(Icons.broken_image)));
  }
}
