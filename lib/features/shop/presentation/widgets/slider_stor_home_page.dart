import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';

typedef OnSend = void Function(int id);

class ShopSliderStore extends StatefulWidget {
  ShopSliderStore({Key? key, this.imageSlider, required this.onSendToParent})
      : super(key: key);
  final List<ItemEntity>? imageSlider;
  final OnSend onSendToParent;

  @override
  State<ShopSliderStore> createState() => _ShopSliderStoreState();
}

class _ShopSliderStoreState extends State<ShopSliderStore> {

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: widget.imageSlider!.length,
        itemBuilder: (context, i, index) {
          return widget.imageSlider!.isEmpty
              ? Container()
              : InkWell(
                  onTap: () {
                    widget.onSendToParent(widget.imageSlider![i].shopId!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.r,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.imageSlider![i].imageUrl!,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                );
        },
        options: CarouselOptions(
          height: 400.h,
          aspectRatio: 9 / 16,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 1500),
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          scrollDirection: Axis.horizontal,
        ));
  }
}
