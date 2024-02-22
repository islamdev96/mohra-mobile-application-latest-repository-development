import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/utils/insta-image-viewer/src/insta_image_viewer.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';

class ImageMessageWidget extends StatelessWidget {
  final MessagingFileEntity messagingFileEntity;
  final int? id;
   ImageMessageWidget({Key? key, required this.messagingFileEntity, this.id})
      : super(key: key);
  UniqueKey key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: 0.4.sh, minWidth: 0.9.sw, maxWidth: 0.9.sw),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              PageRouteBuilder(
                  opaque: false,
                  barrierColor:Colors.white.withOpacity(0),
                  pageBuilder: (BuildContext context, _, __) {
                    return FullScreenViewer(
                      tag: key,
                      disableSwipeToDismiss: false,disposeLevel: DisposeLevel.high,
                      child: CachedNetworkImage(imageUrl: messagingFileEntity.url??"",placeholder: (context, url) {
                    return CircularProgressIndicator.adaptive();
                    },)
                      // Image(
                      //   image: Image.network(messagingFileEntity.url,).image,
                      // ),
                    );
                  }));
        },
        child: Hero(
          tag: key,
          child: CustomNetworkImageWidget(
            imgPath: messagingFileEntity.url,
            withChild: true,
            radius: 8,
            boxFit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
