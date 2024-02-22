import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/utils/insta-image-viewer/src/insta_image_viewer.dart';

class SingleProductSlider extends StatefulWidget {
  const SingleProductSlider({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  State<SingleProductSlider> createState() => _SingleProductSliderState();
}

class _SingleProductSliderState extends State<SingleProductSlider> {
  int _current = 0;

  late List<UniqueKey> keys;

  @override
  void initState() {
    keys = List.generate(widget.images.length, (index) => UniqueKey());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.images.length);
    return Stack(
      children: [
        CarouselSlider.builder(
            itemCount: widget.images.length,
            itemBuilder: (BuildContext context, _, int index) {
              return widget.images.length != 0
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                barrierColor: Colors.white.withOpacity(0),
                                pageBuilder: (BuildContext context, _, __) {
                                  return FullScreenViewer(
                                    tag: keys[_current],
                                    disableSwipeToDismiss: false,disposeLevel: DisposeLevel.high,
                                    child: CachedNetworkImage(imageUrl: widget.images[_current]??"",placeholder: (context, url) {
                                  return CircularProgressIndicator.adaptive();
                                  },)

                                    // Image(
                                    //   image: Image.network( widget.images[_current],).image,
                                    // ),
                                  );
                                }));
                      },
                      child: Hero(
                        tag: keys[_current],
                        child: Container(
                          width: 1.sw,
                          color: AppColors.white,
                          child: AspectRatio(
                              aspectRatio: 19 / 6,
                              child: Image.network(widget.images[_current])),
                        ),
                      ),
                    )
                  : const SizedBox.square();
            },
            options: CarouselOptions(
              // height: 450.h,
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: widget.images.length <= 1 ? false : true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            )),
        // Positioned.directional(
        //   bottom: 30.h,
        //   end: 40.w,
        //   textDirection: TextDirection.rtl,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: widget.images.asMap().entries.map((entry) {
        //       return Container(
        //         width: 20.w,
        //         height: 20.h,
        //         margin:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: _current == entry.key
        //                 ? AppColors.primaryColorLight
        //                 : Colors.white),
        //       );
        //     }).toList(),
        //   ),
        // ),
      ],
    );
  }
}
