import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';

typedef OnSend = void Function(int id);

class HomeServicesSlider extends StatefulWidget {
  HomeServicesSlider({Key? key, this.imageSlider, required this.onSendToParent})
      : super(key: key);
  final List<ItemEntity>? imageSlider;
  final OnSend onSendToParent;

  @override
  State<HomeServicesSlider> createState() => _HomeServicesSliderState();
}

class _HomeServicesSliderState extends State<HomeServicesSlider> {

  int _current = 0;

  late List<UniqueKey> keys;

  @override
  void initState() {
    keys = List.generate(widget.imageSlider!.length, (index) => UniqueKey());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.imageSlider!.length,
            itemBuilder: (context, i, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: InkWell(
                  onTap: () {
                    widget.onSendToParent(widget.imageSlider![i].shopId!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          30.r,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.imageSlider![i].imageUrl!,
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 450.h,
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
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageSlider!.asMap().entries.map((entry) {
            return Container(
              width: 20.w,
              height: 20.h,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? AppColors.primaryColorLight
                      : AppColors.text_gray),
            );
          }).toList(),
        ),
      ],
    );
  }
}
