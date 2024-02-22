import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';

class MomentCurveImage extends StatelessWidget {
  final String? imgPath;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;
  final BoxFit? boxFit;
  final Widget? errorImage;
  final double? radius;
  final bool withChild;

  const MomentCurveImage(
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
    return Container(
      width: 0.25.sw,
      height: 0.25.sw,
      child: imgPath != null
          ? Container(
              height: 0.25.sw,
              width: 0.25.sw,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(radius ?? 0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius??0),
                child: CachedNetworkImage(
                  width: 0.25.sw,
                  height: 0.25.sw,
                  imageUrl: '$imgPath',
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Container(
                    width: 0.25.sw,
                    height: 0.25.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius ?? 0),
                      border: Border.all(
                        width: .5,
                        color: Colors.black,
                      ),
                    ),
                    child:const Icon(
                      Icons.broken_image,
                      color: Colors.black,
                    ),
                  ),
                  placeholder: (context, _) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),
            )
          : Container(
              width: 0.25.sw,
              height: 0.25.sw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 0),
                  border: Border.all(
                    width: .5,
                    color: Colors.black,
                  )),
              child: Icon(
                Icons.broken_image,
                color: Colors.black,
              ),
            ),
    );
  }
}
