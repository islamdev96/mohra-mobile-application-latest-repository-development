import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';

typedef OnSend = void Function(int id);

class ShopSlider extends StatelessWidget {
  ShopSlider({Key? key, this.imageSlider, required this.onSendToParent})
      : super(key: key);
  final List<ItemEntity>? imageSlider;
  final OnSend onSendToParent;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: imageSlider!.length,
        itemBuilder: (context, i, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
            child: InkWell(
              onTap: () {
                onSendToParent(imageSlider![i].shopId!);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.r,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        imageSlider![i].imageUrl!,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 550.h,
          aspectRatio: 9 / 16,
          viewportFraction: 0.95,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 1500),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }
}
