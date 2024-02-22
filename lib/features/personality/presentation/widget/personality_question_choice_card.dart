import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class PersonalityQuestionChoiceCard extends StatelessWidget {
  final String image;
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;
  late final double _height;
  late final double _width;

  PersonalityQuestionChoiceCard({
    Key? key,
    required this.image,
    required this.name,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      _height = cons.minHeight;
      _width = cons.minWidth;

      return ClipRRect(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: getColor(),
                ),
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCheckBox(),
                  _buildImage(),
                  _buildName(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCheckBox() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.all(2),
        height: 60.h,
        width: 60.h,
        decoration: BoxDecoration(
          color: isSelected ? getColor() : getColor().withOpacity(0.3),
          border: Border.all(
            color: getColor(),
          ),
          shape: BoxShape.circle,
        ),
        child: getCheckBoxIcon(),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: _height * 0.4,
      width: _width * 0.4,
      child:image.contains('http') ?
      CachedNetworkImage(

        imageUrl: image,
        fit: BoxFit.contain,
        errorWidget: (context, url, error) =>Container(
          height: _height * 0.4,
          width: _width * 0.4,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: .5,
                color: Colors.black,
              )),
          child: Icon(
            Icons.error,
            size: _width * 0.4,
            color: Colors.black,
          ),
        ),
        placeholder: (context , _) => Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ) : Image.asset(image)
      ,
    );
  }

  Widget _buildName() {
    return Text(
      name,
      style: TextStyle(
        fontSize: 40.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Color getColor() {
    if (isSelected) {
      return AppColors.primaryColorLight;
    } else {
      return AppColors.mansourNotSelectedBorderColor;
    }
  }

  Widget getCheckBoxIcon() {
    if (!isSelected) return const SizedBox.shrink();
    return const FittedBox(
      fit: BoxFit.scaleDown,
      child: Center(
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
