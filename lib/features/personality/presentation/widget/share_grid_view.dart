import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';

class ShareGridView extends StatelessWidget {
  final AvatarListEntity avatarListEntity;
  const ShareGridView({Key? key , required this.avatarListEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mansourNotSelectedBorderColor,
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: avatarListEntity.avatars.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 12,
          crossAxisSpacing: 50.w,
          mainAxisSpacing: 50.w,
          childAspectRatio: 2 / 5,
        ),
        itemBuilder: (context, index) {
          return _buildGridItem(index);
        },
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return LayoutBuilder(builder: (context, cons) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: cons.maxHeight * 0.7,
            width: cons.maxWidth,
            child: avatarListEntity.avatars[index].image == null ? SizedBox.shrink(): CachedNetworkImage(imageUrl: avatarListEntity.avatars[index].image!),

            //Image.asset(AppConstants.IMG_PERSONALITY_MALE_GREY_1),
          ),
          FittedBox(
            child: Text(
              "${avatarListEntity.avatars[index].name}",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 30.sp,
              ),
            ),
          )
        ],
      );
    });
  }
}
