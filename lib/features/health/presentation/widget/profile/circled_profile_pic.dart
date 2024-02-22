import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class ProfilePic extends StatelessWidget {
  final double width, height;
  final String? imageUrl;

  const ProfilePic({required this.width, required this.height, this.imageUrl})
      : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        child: Center(
          child: imageUrl != null
              ? ClipOval(
                  child: Container(
                    height: width,
                    width: height,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '$imageUrl',
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: .5,
                              color: Colors.black,
                            )),
                        child: Icon(
                          Icons.person,
                          size: width * .5,
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
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: .5,
                        color: Colors.black,
                      )),
                  child: Icon(
                    Icons.person,
                    size: width * .5,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
