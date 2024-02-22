import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';

import '../../../features/moment/domain/entity/moment_entity.dart';

class ImageListScreen extends StatefulWidget {
  final List<ImagesEntity> images;
  int currentIndex;

  ImageListScreen({required this.images, required this.currentIndex});

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  PageController _pageController = PageController();
  int currentPageIndex = 0;
  List<ImagesEntity> modifiedImages = [];

  @override
  void initState() {
    modifiedImages = List.from(widget.images);
    ImagesEntity image = modifiedImages[widget.currentIndex];
    modifiedImages.removeAt(widget.currentIndex);
    modifiedImages.insert(0, image);

    super.initState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! > 0) {
                Nav.pop();
                Nav.pop();
              } else if (details.primaryDelta! < 0) {
                Nav.pop();
                Nav.pop();
              }
            },
            child: Container(
              height: 1.sh,
              width: 1.sw,
              child: Stack(
                children: [
                  PhotoViewGallery.builder(
                    itemCount: modifiedImages.length,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: CachedNetworkImageProvider(
                          modifiedImages[currentPageIndex].imageUrl!,
                          errorListener: (p0) {},
                        ),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        onTapUp: (context, details, controllerValue) {
                          // Nav.pop();
                        },
                        onTapDown: (context, details, controllerValue) {
                          // Nav.pop();
                        },
                      );
                    },
                    scrollPhysics: const BouncingScrollPhysics(),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    pageController: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: buildCircleIndicator(),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.cancel),
                          color: AppColors.black,
                          onPressed: () {
                            Nav.pop();
                            Nav.pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCircleIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        modifiedImages.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPageIndex == index
                  ? Colors.white
                  : AppColors.mansourDarkOrange,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
