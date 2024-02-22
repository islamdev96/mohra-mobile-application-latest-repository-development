library face_pile;

import 'package:flutter/material.dart';

/// [CustomListPile] displays a stacked list of users.
/// Each circle represents a person and contains their image.
/// This widget is usually used when sharing who has access to a specific
/// view or file, or when assigning tasks to someone in a workflow.
class CustomListPile extends StatelessWidget {
  const CustomListPile({
    Key? key,
    required this.images,
    required this.radius,
    required this.space,
    this.child,
    this.backgroundColor,
    this.childBackgroundColor,
    this.boxShadow,
  }) : super(key: key);

  /// List of user profile image.
  final List<Widget> images;

  /// Radius of [CircleAvatar].
  final double radius;

  /// determine the space between each [CircleAvatar].
  final double space;

  /// Widget to show in circle avatar in last order.
  final Widget? child;

  /// [CircleAvatar] background color.
  final Color? backgroundColor;

  /// [CircleAvatar] background color for child.
  final Color? childBackgroundColor;

  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final faceLength = images.length;

    final hasChild = child != null ? 1 : 0;
    final CustomListPileWidth =
        space * (faceLength + hasChild) + radius * 2 - space;

    return SizedBox(
      width: CustomListPileWidth,
      child: Stack(
        children: [
          SizedBox(
            width: radius * 2,
            height: radius * 2,
          ),
          if (child != null)
            Positioned(
              left: space * faceLength,
              child: CircleAvatar(
                radius: radius,
                backgroundColor: childBackgroundColor ?? backgroundColor,
                child: child!,
              ),
            ),
          ...List.generate(
            faceLength,
            (index) {
              // final newIndex = faceLength - index - 1;
              final image = images[index];

              final avatar = Container(
                height: radius,
                width: radius,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: boxShadow,
                ),
                child: ClipOval(
                  child: image,
                ),
              );

              return Positioned(
                left: space * index,
                child: avatar,
              );
            },
          ),
        ],
      ),
    );
  }
}
