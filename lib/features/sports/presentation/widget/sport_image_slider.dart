import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/screen/news_single_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

class SportImageSlider extends StatefulWidget {
  const SportImageSlider(
      {Key? key, required this.images, required this.onPress,required this.next})
      : super(key: key);
  final List<String> images;
  final VoidCallback onPress;
  final String next;

  @override
  State<SportImageSlider> createState() => _SportImageSliderState();
}

class _SportImageSliderState extends State<SportImageSlider> {
  int _current = 0;
  List<String> pint = ["2", "3", "4"];
  DateTime now = new DateTime.now();
  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CarouselSlider.builder(
            itemCount:widget.images.length,
            itemBuilder: (context, index, realIndex) {
              return  Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.images[index],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 650.h,
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: true,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            )),
        PositionedDirectional(
          top: 100.h,
          // start: 50.w,
          child: CustomListTile(
            width: 1.sw,
            backgroundColor: AppColors.mansourDarkGreenColor2.withOpacity(0.3),
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Nav.pop();
                  },
                  icon: Icon(
                    AppConstants.getIconBack(),
                    color: Colors.black,
                    size: 70.sp,
                  ),
                ),
                Gaps.hGap32,
                Text(
                  Translation.current.sport,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
    );
  }
}
