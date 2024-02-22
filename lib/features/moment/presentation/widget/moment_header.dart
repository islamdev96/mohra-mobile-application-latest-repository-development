import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';

class MomentHeader extends StatelessWidget {
  final double height;
  final double width;
  final String? image;
  const MomentHeader({Key? key, required this.height, required this.width, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper:
      AppConfig().isLTR ? _MomentHeaderClipper() : _MomentHeaderAClipper(),
      child: Container(
        height: height,
        width: width,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.personalityGradiant3,
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
          image: image != null ? DecorationImage(image: NetworkImage(image!),fit: BoxFit.cover):null
        ),
      ),
    );
  }
}

class _MomentHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final x0 = 0.0, y0 = 0.0, xn = size.width, yn = size.height;
    path.lineTo(xn, y0);
    // path.lineTo(xn, 0.7 * yn);
    // path.cubicTo(0.8 * xn, 1.2 * yn, xn, yn, x0, 0.7 * yn);
    path.lineTo(xn, 0.8 * yn);
    path.cubicTo(0.7 * xn, 1.1 * yn, xn, yn, x0, 0.8 * yn);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

class _MomentHeaderAClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final x0 = 0.0, y0 = 0.0, xn = size.width, yn = size.height;
    path.lineTo(x0, 0.89 * yn);
    path.cubicTo(0.2 * xn, yn , -10, yn *1.1, xn, 0.78 * yn);
    path.lineTo(xn, y0);

    // path.lineTo(x0, 0.8 * yn);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
