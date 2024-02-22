// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:starter_application/core/common/app_colors.dart';
// import 'package:starter_application/core/common/app_config.dart';
//
// class CoverImageWidget extends StatelessWidget {
//   final double height;
//   final double width;
//   final String? imageUrl;
//
//   const CoverImageWidget(
//       {Key? key,
//       required this.height,
//       required this.width,
//       required this.imageUrl})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper:
//           AppConfig().isLTR ? _MomentHeaderClipper() : _MomentHeaderAClipper(),
//       child: Stack(
//         children: [
//
//           Container(
//             height: height,
//             width: width,
//             color: AppColors.mansourDarkOrange3,
//             child: imageUrl != null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Container(
//                       height: height,
//                       width: width,
//                       child: CachedNetworkImage(
//                         width: width,
//                         imageUrl: '$imageUrl',
//                         fit: BoxFit.cover,
//                         errorWidget: (context, url, error) {
//                           print('aaaa$error');
//                           return Container(
//                             width: width,
//                             height: height,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 image:const AssetImage(
//                                   'assets/images/png/defaut_cover_image.png',
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         },
//                         placeholder: (context, _) => Container(
//                           width: width,
//                           height: height,
//                           child: const Center(
//                             child: CircularProgressIndicator.adaptive(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(
//                     width: width,
//                     height: height,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         image: AssetImage(
//                           'assets/images/png/defaut_cover_image.png',
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//           ),
//           Container(
//             height: height,
//             width: width,
//             color: AppColors.black.withOpacity(0.3),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _MomentHeaderClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     final x0 = 0.0, y0 = 0.0, xn = size.width, yn = size.height;
//     path.lineTo(xn, y0);
//     path.lineTo(xn, 0.8 * yn);
//     path.cubicTo(0.7 * xn, 1.1 * yn, xn, yn, x0, 1 * yn);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) {
//     return true;
//   }
// }
//
// class _MomentHeaderAClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     final x0 = 0.0, y0 = 0.0, xn = size.width, yn = size.height;
//     path.lineTo(x0, 0.7 * yn);
//     path.cubicTo(0.2 * xn, yn *1.1, 0.2 * xn, yn, xn, 0.8 * yn);
//     path.lineTo(xn, y0);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) {
//     return true;
//   }
// }
